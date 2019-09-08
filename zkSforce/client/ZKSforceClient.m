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

#import "ZKSforceClient.h"
#import "ZKPartnerEnvelope.h"
#import "zkQueryResult.h"
#import "ZKSaveResult.h"
#import "ZKSObject.h"
#import "ZKSoapException.h"
#import "ZKUserInfo.h"
#import "ZKDescribeSObject.h"
#import "ZKLoginResult.h"
#import "ZKDescribeGlobalSObject.h"
#import "zkParser.h"
#import "ZKConstants.h"
#import "ZKDescribeLayoutResult.h"
#import "ZKDescribeTabSetResult.h"
#import "ZKLimitInfoHeader.h"
#import "ZKLeadConvert.h"
#import "ZKLeadConvertResult.h"
#import "ZKXMLSerializable.h"
#import "ZKXmlDeserializer.h"
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
#import "NSArray+Extras.h"

static const int SAVE_BATCH_SIZE = 25;
static const int DEFAULT_API_VERSION = 46;

@interface ZKSforceClient(Private)
- (NSArray *)sobjectsImpl:(NSArray *)objects name:(NSString *)elemName;
@property (retain, getter=currentUserInfo) ZKUserInfo *userInfo;
@end

@implementation ZKSforceClient

@synthesize preferedApiVersion, lastLimitInfoHeader=limitInfo;

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
    rhs->describes = [[NSMutableDictionary alloc] init];
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

-(BOOL)cacheDescribes {
    @synchronized (describes) {
        return cacheDescribes;
    }
}

-(void)setCacheDescribes:(BOOL)shouldCache {
    @synchronized (describes) {
        cacheDescribes = shouldCache;
        if (!shouldCache) {
            [describes removeAllObjects];
        }
    }
}

- (void)flushCachedDescribes {
    @synchronized (describes) {
        [describes removeAllObjects];
    }
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

-(void)soapLogin:(ZKSoapLogin *)auth
       failBlock:(zkFailWithExceptionBlock)failBlock
   completeBlock:(zkCompleteLoginResultBlock)completeBlock {
    
    [auth startLoginWithFailBlock:failBlock completeBlock:^(ZKLoginResult *result) {
        self.authenticationInfo = auth;
        self.userInfo = result.userInfo;
        completeBlock(result);
    }];
}

/** Login to the Salesforce API with username & password */
-(void) performLogin:(NSString *)username password:(NSString *)password
           failBlock:(zkFailWithExceptionBlock)failBlock
       completeBlock:(zkCompleteLoginResultBlock)completeBlock {

    ZKSoapLogin *auth = [ZKSoapLogin soapLoginWithUsername:username
                                                  password:password
                                                  authHost:[NSURL URLWithString:authEndpointUrl]
                                                apiVersion:preferedApiVersion
                                                  clientId:self.clientId
                                                  delegate:self.delegate];
    [self soapLogin:auth failBlock:failBlock completeBlock:completeBlock];
}

- (void)loginFromOAuthCallbackUrl:(NSString *)callbackUrl oAuthConsumerKey:(NSString *)oauthClientId{
    ZKOAuthInfo *auth = [ZKOAuthInfo oauthInfoFromCallbackUrl:[NSURL URLWithString:callbackUrl] clientId:oauthClientId];
    auth.apiVersion = preferedApiVersion;
    self.authenticationInfo = auth;
}

- (void)loginWithRefreshToken:(NSString *)refreshToken authUrl:(NSURL *)authUrl oAuthConsumerKey:(NSString *)cid
                    failBlock:(zkFailWithExceptionBlock)failBlock
                completeBlock:(zkCompleteVoidBlock)completeBlock {
    
    ZKOAuthInfo *auth = [[ZKOAuthInfo alloc] initWithRefreshToken:refreshToken authHost:authUrl sessionId:nil instanceUrl:nil clientId:cid];
    auth.apiVersion = preferedApiVersion;
    [auth refresh:^(NSException *ex) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (ex != nil) {
                failBlock(ex);
            } else {
                self.authenticationInfo = auth;
                completeBlock();
            }
        });
    }];
}

- (void)portalLogin:(NSString *)username
                      password:(NSString *)password
                         orgId:(NSString *)orgId
                      portalId:(NSString *)portalId
                     failBlock:(zkFailWithExceptionBlock)failBlock
                 completeBlock:(zkCompleteLoginResultBlock)completeBlock {
    
    ZKSoapPortalLogin *auth = [ZKSoapPortalLogin soapPortalLoginWithUsername:username
                                                                    password:password
                                                                    authHost:[NSURL URLWithString:authEndpointUrl]
                                                                  apiVersion:preferedApiVersion
                                                                    clientId:self.clientId
                                                                    delegate:self.delegate
                                                                       orgId:orgId
                                                                    portalId:portalId];
    [self soapLogin:auth failBlock:failBlock completeBlock:completeBlock];
}

-(void)setUserInfo:(ZKUserInfo *)ui {
    userInfo = ui;
}

- (BOOL)loggedIn {
    return self.authSource.sessionId.length > 0;
}

// refresh the session if needed, then call the supplied block.
- (void)checkSession:(void(^)(NSException *ex))cb {
    [self.authSource refreshIfNeeded:^(BOOL refreshed, NSException *ex) {
        if (refreshed) {
            self.endpointUrl = self.authSource.instanceUrl;
        }
        cb(ex);
    }];
}

-(void)currentUserInfoWithFailBlock:(zkFailWithExceptionBlock)failBlock
                      completeBlock:(zkCompleteUserInfoBlock)completeBlock {
    ZKUserInfo *i = self.userInfo;
    if (i != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completeBlock(i);
        });
        return;
    }
    [self performGetUserInfoWithFailBlock:failBlock completeBlock:^(ZKUserInfo *result) {
        self.userInfo = result;
        completeBlock(result);
    }];
}

- (NSURL *)serverUrl {
    return self.endpointUrl;
}

- (NSString *)sessionId {
    [self checkSession];
    return self.authSource.sessionId;
}

// Override method in ZKSforceBaseClient
-(BOOL)confirmLoggedIn {
    if (![self loggedIn]) {
        NSLog(@"ZKSforceClient does not have a valid session. request not executed");
        return NO;
    }
    return YES;
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
    NSString *host = self.endpointUrl.host;
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

-(NSArray *)preHook_describeGlobal {
    @synchronized (describes) {
        return describes[@"describe__global"];    // won't be an sfdc object ever called this.
    }
}

-(NSArray *)postHook_describeGlobal:(NSArray *)r {
    @synchronized (describes) {
        if (cacheDescribes) {
            describes[@"describe__global"] = r;
        }
    }
    return r;
}

-(ZKDescribeSObject *)preHook_describeSObject:(NSString *)sobjectName {
    @synchronized (describes) {
        return describes[sobjectName.lowercaseString];
    }
}

-(ZKDescribeSObject *)postHook_describeSObject:(ZKDescribeSObject *)r {
    @synchronized (describes) {
        if (cacheDescribes) {
            describes[r.name.lowercaseString] = r;
        }
    }
    return r;
}

- (NSArray *)search:(NSString *)sosl {
    if (!self.authSource) return NULL;
    [self checkSession];
    
    NSString *payload = [self makeSearchEnv:sosl];
    zkElement *sr = [self sendRequest:payload name:NSStringFromSelector(_cmd)];
    zkElement *searchResult = [sr childElement:@"result"];
    NSArray *records = [searchResult childElements:@"searchRecords"];
    NSMutableArray *sobjects = [NSMutableArray arrayWithCapacity:records.count];
    for (zkElement *soNode in records)
        [sobjects addObject:[ZKSObject fromXmlNode:[soNode childElement:@"record"]]];
    return sobjects;
}

- (NSArray *)create:(NSArray *)objects {
    return [self sobjectsImpl:objects name:@"create"];
}

- (NSArray *)update:(NSArray *)objects {
    return [self sobjectsImpl:objects name:@"update"];
}

-(NSArray *)sobjectsImpl:(NSArray *)objects name:(NSString *)elemName {
    if(!self.authSource) return NULL;
    [self checkSession];
    
    // if more than we can do in one go, break it up.
    if (objects.count > SAVE_BATCH_SIZE) {
        NSArray *chunks = [objects ZKPartitionWithSize:SAVE_BATCH_SIZE];
        NSMutableArray *allResults = [NSMutableArray arrayWithCapacity:objects.count];
        for (NSArray *chunk in chunks) {
            [allResults addObjectsFromArray:[self sobjectsImpl:chunk name:elemName]];
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

/** Update a set of sObjects, chunks in SAVE_BATCH_SIZE chunks if needed */
-(void) performUpdate:(NSArray *)sObjects
            failBlock:(zkFailWithExceptionBlock)failBlock
        completeBlock:(zkCompleteArrayBlock)completeBlock {
    
    if (sObjects.count <= SAVE_BATCH_SIZE) {
        [super performUpdate:sObjects failBlock:failBlock completeBlock:completeBlock];
        return;
    }
    NSMutableArray *results = [NSMutableArray arrayWithCapacity:sObjects.count];
    NSArray *chunks = [sObjects ZKPartitionWithSize:SAVE_BATCH_SIZE];
    NSUInteger __block idx = 0;
    
    zkCompleteArrayBlock cb;
    cb = ^void(NSArray *result) {
        [results addObjectsFromArray:result];
        idx++;
        if (idx >= chunks.count) {
            completeBlock(results);
        } else {
            // next chunk
            [super performUpdate:chunks[idx] failBlock:failBlock completeBlock:cb];
        }
    };
    [super performUpdate:chunks[0] failBlock:failBlock completeBlock:cb];
}

/** Create a set of sObjects, chunks in SAVE_BATCH_SIZE chunks if needed */
-(void) performCreate:(NSArray *)sObjects
            failBlock:(zkFailWithExceptionBlock)failBlock
        completeBlock:(zkCompleteArrayBlock)completeBlock {
    
    if (sObjects.count <= SAVE_BATCH_SIZE) {
        [super performCreate:sObjects failBlock:failBlock completeBlock:completeBlock];
        return;
    }
    NSMutableArray *results = [NSMutableArray arrayWithCapacity:sObjects.count];
    NSArray *chunks = [sObjects ZKPartitionWithSize:SAVE_BATCH_SIZE];
    NSUInteger __block idx = 0;
    
    zkCompleteArrayBlock cb;
    cb = ^void(NSArray *result) {
        [results addObjectsFromArray:result];
        idx++;
        if (idx >= chunks.count) {
            completeBlock(results);
        } else {
            // next chunk
            [super performCreate:chunks[idx] failBlock:failBlock completeBlock:cb];
        }
    };
    [super performCreate:chunks[0] failBlock:failBlock completeBlock:cb];
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

-(void)handleResponseSoapHeaders:(zkElement *)soapHeaders {
    // this looks in the supplied headers for a limit info header and if we got one, hangs onto it.
    zkElement *liElem = [soapHeaders childElement:@"LimitInfoHeader" ns:@"urn:partner.soap.sforce.com"];
    if (liElem != nil) {
        limitInfo = [[ZKLimitInfoHeader alloc] initWithXmlElement:liElem];
    }
}

@end
