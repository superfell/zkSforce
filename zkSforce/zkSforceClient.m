// Copyright (c) 2006-2015,2019 Simon Fell
//
// Permission is hereby granted, free of charge, to any person obtaining a 
// copy of this software and associated documentation files (the "Software"), 
// to deal in the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense, 
// and/or sell copies of the Software, and to permit persons to whom the 
// Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included 
// in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS 
// OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN 
// THE SOFTWARE.
//

#import "zkSforceClient.h"
#import "ZKPartnerEnvelope.h"
#import "zkQueryResult.h"
#import "ZKSaveResult.h"
#import "zkSObject.h"
#import "zkSoapException.h"
#import "ZKUserInfo.h"
#import "ZKDescribeSObject.h"
#import "ZKLoginResult.h"
#import "ZKDescribeGlobalSObject.h"
#import "zkParser.h"
#import "ZKDescribeLayoutResult.h"
#import "ZKDescribeTabSetResult.h"
#import "ZKLimitInfoHeader.h"
#import "ZKLeadConvert.h"
#import "ZKLeadConvertResult.h"
#import "ZKXMLSerializable.h"
#import "zkXmlDeserializer.h"
#import "ZKSforceClient+Operations.h"
#import "ZKCallOptions.h"
#import "ZKPackageVersionHeader.h"
#import "ZKLocaleOptions.h"
#import "ZKAssignmentRuleHeader.h"
#import "ZKMruHeader.h"
#import "ZKAllowFieldTruncationHeader.h"
#import "ZKDisableFeedTrackingHeader.h"
#import "ZKStreamingEnabledHeader.h"
#import "ZKAllOrNoneHeader.h"
#import "ZKDebuggingHeader.h"
#import "ZKEmailHeader.h"
#import "ZKOwnerChangeOptions.h"
#import "ZKUserTerritoryDeleteHeader.h"
#import "ZKQueryOptions.h"
#import "ZKDuplicateRuleHeader.h"
#import "ZKXMLSerializable.h"

static const int SAVE_BATCH_SIZE = 25;
static const int DEFAULT_API_VERSION = 46;

@interface ZKSforceClient(Private)
- (NSArray *)sobjectsImpl:(NSArray *)objects name:(NSString *)elemName;
@property (retain, getter=currentUserInfo) ZKUserInfo *userInfo;
@end

@implementation ZKSforceClient

@synthesize preferedApiVersion, cacheDescribes, lastLimitInfoHeader=limitInfo;

- (instancetype)init {
    self = [super init];
    preferedApiVersion = DEFAULT_API_VERSION;
    [self setLoginProtocolAndHost:@"https://login.salesforce.com"];
    cacheDescribes = NO;
    describes = [[NSMutableDictionary alloc] init];
    return self;
}


- (id)copyWithZone:(NSZone *)zone {
    ZKSforceClient *rhs = [super copyWithZone:zone];
    rhs->authEndpointUrl = [authEndpointUrl copy];
    rhs->userInfo = userInfo;
    rhs->preferedApiVersion = preferedApiVersion;
    rhs->limitInfo = limitInfo;
    rhs.cacheDescribes = cacheDescribes;
    return rhs;
}

-(NSObject<ZKAuthenticationInfo> *)authenticationInfo {
    return self.authSource;
}

-(void)setAuthenticationInfo:(NSObject<ZKAuthenticationInfo> *)authenticationInfo {
    self.authSource = authenticationInfo;
    self.endpointUrl = self.authSource.instanceUrl;
    self.userInfo = nil;
}

- (void)flushCachedDescribes {
    describes = nil;
    if (cacheDescribes)
        describes = [[NSMutableDictionary alloc] init];
}

- (void)setLoginProtocolAndHost:(NSString *)protocolAndHost {
    [self setLoginProtocolAndHost:protocolAndHost andVersion:preferedApiVersion];
}

- (void)setLoginProtocolAndHost:(NSString *)protocolAndHost andVersion:(int)version {
    // www.salesforce.com is no longer going to be supported for login, so map requests for that
    // to login.salesforce.com
    NSString *www = @"://www.salesforce.com";
    NSString *login = @"://login.salesforce.com";
    protocolAndHost = [protocolAndHost stringByReplacingOccurrencesOfString:www withString:login options:NSCaseInsensitiveSearch range:NSMakeRange(0, protocolAndHost.length)];
    authEndpointUrl = [NSString stringWithFormat:@"%@/services/Soap/u/%d.0", protocolAndHost, version];
    preferedApiVersion = version;
}

- (NSURL *)authEndpointUrl {
    return [NSURL URLWithString:authEndpointUrl];
}

-(ZKLoginResult *)soapLogin:(ZKSoapLogin *)auth {
    ZKLoginResult *lr = auth.login;
    self.authenticationInfo = auth;
    self.userInfo = lr.userInfo;
    return lr;
}

- (ZKLoginResult *)login:(NSString *)un password:(NSString *)pwd {
    ZKSoapLogin *auth = [ZKSoapLogin soapLoginWithUsername:un
                                                  password:pwd
                                                  authHost:[NSURL URLWithString:authEndpointUrl]
                                                apiVersion:preferedApiVersion
                                                  clientId:self.clientId
                                                  delegate:delegate];
    return [self soapLogin:auth];
}

- (void)loginFromOAuthCallbackUrl:(NSString *)callbackUrl oAuthConsumerKey:(NSString *)oauthClientId{
    ZKOAuthInfo *auth = [ZKOAuthInfo oauthInfoFromCallbackUrl:[NSURL URLWithString:callbackUrl] clientId:oauthClientId];
    auth.apiVersion = preferedApiVersion;
    self.authenticationInfo = auth;
}

- (void)loginWithRefreshToken:(NSString *)refreshToken authUrl:(NSURL *)authUrl oAuthConsumerKey:(NSString *)cid {
    ZKOAuthInfo *auth = [[ZKOAuthInfo alloc] initWithRefreshToken:refreshToken authHost:authUrl sessionId:nil instanceUrl:nil clientId:cid];
    auth.apiVersion = preferedApiVersion;
    self.authenticationInfo = auth;
    [self checkSession];
}

- (ZKLoginResult *)portalLogin:(NSString *)username password:(NSString *)password orgId:(NSString *)orgId portalId:(NSString *)portalId {
    ZKSoapPortalLogin *auth = [ZKSoapPortalLogin soapPortalLoginWithUsername:username
                                                                    password:password
                                                                    authHost:[NSURL URLWithString:authEndpointUrl]
                                                                  apiVersion:preferedApiVersion
                                                                    clientId:self.clientId
                                                                    delegate:delegate
                                                                       orgId:orgId
                                                                    portalId:portalId];
    return [self soapLogin:auth];
}

-(void)setUserInfo:(ZKUserInfo *)ui {
    userInfo = ui;
}

- (BOOL)loggedIn {
    return self.authSource.sessionId.length > 0;
}

- (void)checkSession {
    if (self.authSource.refreshIfNeeded)
        self.endpointUrl = self.authSource.instanceUrl;
}

- (ZKUserInfo *)currentUserInfo {
    if (userInfo == nil)
        userInfo = [self getUserInfo];
    return userInfo;
}

- (NSURL *)serverUrl {
    return endpointUrl;
}

- (NSString *)sessionId {
    [self checkSession];
    return self.authSource.sessionId;
}

-(BOOL)updateMru {
    return self.mruHeader == nil ? FALSE : self.mruHeader.updateMru;
}

-(void)setUpdateMru:(BOOL)mru {
    if (self.mruHeader == nil)
        self.mruHeader = [[ZKMruHeader alloc] init];
    self.mruHeader.updateMru = mru;
}

-(NSString *)clientId {
    return self.callOptions.client;
}

-(void)setClientId:(NSString *)newClientId {
    if (self.callOptions == nil)
        self.callOptions = [[ZKCallOptions alloc] init];
    self.callOptions.client = newClientId;
}

-(NSNumber *)queryBatchSize {
    return @(self.queryOptions.batchSize);
}

-(void)setQueryBatchSize:(NSNumber *)newBatchSize {
    if (newBatchSize == nil)
        self.queryOptions = nil;
    else {
        if (self.queryOptions == nil)
            self.queryOptions = [[ZKQueryOptions alloc] init];
        self.queryOptions.batchSize = newBatchSize.integerValue;
    }
}

- (NSString *)serverHostAbbriviation {
    NSString *host = endpointUrl.host;
    NSString *hostLower = host.lowercaseString;
    NSArray *suffixes = @[@".salesforce.com", @".force.com"];
    for (NSString *suffix in suffixes) {
        if ([hostLower hasSuffix:suffix]) {
            // remove the expected suffix from the host name.
            host = [host substringToIndex:host.length - suffix.length];
            // remove the trailing -api if there is one.
            return [host.lowercaseString hasSuffix:@"-api"] ? [host substringToIndex:host.length - 4] : host;
        }
    }
    return host;
}

- (NSArray *)describeGlobal {
    if(!self.authSource) return NULL;
    [self checkSession];
    if (cacheDescribes) {
        NSArray *dg = describes[@"describe__global"];    // won't be an sfdc object ever called this.
        if (dg != nil) return dg;
    }
    
    NSString *payload = [self makeDescribeGlobalEnv];
    zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
    NSArray *types = [self makeDescribeGlobalResult:root];

    if (cacheDescribes)
        describes[@"describe__global"] = types;
    return types;
}

- (ZKDescribeSObject *)describeSObject:(NSString *)sobjectName {
    if (!self.authSource) return NULL;
    if (cacheDescribes) {
        ZKDescribeSObject * desc = describes[sobjectName.lowercaseString];
        if (desc != nil) return desc;
    }
    [self checkSession];
    
    NSString *payload = [self makeDescribeSObjectEnv:sobjectName];
    zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
    ZKDescribeSObject *desc = [self makeDescribeSObjectResult:root];

    if (cacheDescribes)
        describes[sobjectName.lowercaseString] = desc;
    return desc;
}

- (NSArray *)search:(NSString *)sosl {
    if (!self.authSource) return NULL;
    [self checkSession];
    
    NSString *payload = [self makeSearchEnv:sosl];
    zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
    NSArray *sobjects = [self makeSearchResult:root];

//    zkElement *sr = [self sendRequest:env.end name:NSStringFromSelector(_cmd)];
//    zkElement *searchResult = [sr childElement:@"result"];
//    NSArray *records = [searchResult childElements:@"searchRecords"];
//    NSMutableArray *sobjects = [NSMutableArray arrayWithCapacity:records.count];
//    for (zkElement *soNode in records)
//        [sobjects addObject:[ZKSObject fromXmlNode:[soNode childElement:@"record"]]];
    return sobjects;
}

- (NSArray *)create:(NSArray *)objects {
    return [self sobjectsImpl:objects name:@"create"];
}

- (NSArray *)update:(NSArray *)objects {
    return [self sobjectsImpl:objects name:@"update"];
}

- (NSArray *)sobjectsImpl:(NSArray *)objects name:(NSString *)elemName {
    if(!self.authSource) return NULL;
    [self checkSession];
    
    // if more than we can do in one go, break it up.
    if (objects.count > SAVE_BATCH_SIZE) {
        NSMutableArray *allResults = [NSMutableArray arrayWithCapacity:objects.count];
        NSRange rng = {0, MIN(SAVE_BATCH_SIZE, [objects count])};
        while (rng.location < objects.count) {
            [allResults addObjectsFromArray:[self sobjectsImpl:[objects subarrayWithRange:rng] name:elemName]];
            rng.location += rng.length;
            rng.length = MIN(SAVE_BATCH_SIZE, [objects count] - rng.location);
        }
        return allResults;
    }
    NSString *payload = nil;
    if ([elemName isEqualToString:@"update"]) {
        payload = [self makeUpdateEnv:objects];
    } else {
        payload = [self makeCreateEnv:objects];
    }
    zkElement *root = [self sendRequest:payload name:[NSString stringWithFormat:@"%@:", elemName] returnRoot:YES];
    NSArray *results = [self makeCreateResult:root];
    return results;
}

- (NSDictionary *)retrieve:(NSString *)fields sobject:(NSString *)sobjectType ids:(NSArray *)ids {
    return [self retrieve:fields sObjectType:sobjectType ids:ids];
}

-(NSDictionary *)makeRetrieveResult:(zkElement *)root {
    zkElement *body = [root childElement:@"Body" ns:NS_SOAP_ENV];
    ZKXmlDeserializer *deser = [[ZKXmlDeserializer alloc] initWithXmlElement:body.childElements[0]];
    NSMutableDictionary *sobjects = [NSMutableDictionary dictionary];
    for (ZKSObject *o in [deser complexTypeArrayFromElements:@"result" cls:[ZKSObject class]]) {
        sobjects[o.id] = o;
    }
    return sobjects;
}

-(void)updateLimitInfo:(zkElement *)soapHeaders {
    // this looks in the last response for a limit info header and if we got one, hangs onto it.
    zkElement *liElem = [soapHeaders childElement:@"LimitInfoHeader" ns:@"urn:partner.soap.sforce.com"];
    if (liElem != nil) {
        limitInfo = [[ZKLimitInfoHeader alloc] initWithXmlElement:liElem];
    }
}

-(void)handleResponseSoapHeaders:(zkElement *)soapHeaders {
    [self updateLimitInfo:soapHeaders];
}

-(void)addHeader:(NSObject<ZKXMLSerializable> *)header name:(NSString *)headerName toEnvelope:(ZKEnvelope *)env {
    if (header != nil)
        [header serializeToEnvelope:env elemName:headerName];
}

@end
