// Copyright (c) 2006-2015 Simon Fell
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
#import "zkPartnerEnvelope.h"
#import "zkQueryResult.h"
#import "zkSaveResult.h"
#import "zkSObject.h"
#import "zkSoapException.h"
#import "zkUserInfo.h"
#import "zkDescribeSObject.h"
#import "zkLoginResult.h"
#import "zkDescribeGlobalSObject.h"
#import "zkParser.h"
#import "ZKDescribeLayoutResult.h"
#import "ZKDescribeTabSetResult.h"
#import "ZKLimitInfoHeader.h"
#import "ZKLeadConvert.h"
#import "ZKLeadConvertResult.h"
#import "ZKXMLSerializable.h"
#import "zkXmlDeserializer.h"
#import "zkSforceClient+Operations.h"
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

@interface ZKSforceClient(Private)
- (NSArray *)sobjectsImpl:(NSArray *)objects name:(NSString *)elemName;
@property (retain, getter=currentUserInfo) ZKUserInfo *userInfo;
-(void)addHeader:(NSObject<ZKXMLSerializable> *)header name:(NSString *)headerName toEnvelope:(ZKEnvelope *)env;
@end

@implementation ZKSforceClient

@synthesize preferedApiVersion, cacheDescribes, lastLimitInfoHeader=limitInfo;
@synthesize callOptions, packageVersionHeader, localeOptions, assignmentRuleHeader, mruHeader, allowFieldTruncationHeader;
@synthesize disableFeedTrackingHeader, streamingEnabledHeader, allOrNoneHeader, debuggingHeader, emailHeader, ownerChangeOptions;
@synthesize userTerritoryDeleteHeader, queryOptions, duplicateRuleHeader;

- (id)init {
	self = [super init];
	preferedApiVersion = 37;
	[self setLoginProtocolAndHost:@"https://login.salesforce.com"];
	cacheDescribes = NO;
	describes = [[NSMutableDictionary alloc] init];
	return self;
}

- (void)dealloc {
	[authEndpointUrl release];
	[userInfo release];
	[describes release];
    [authSource release];
    [limitInfo release];
    self.callOptions = nil;
    self.packageVersionHeader = nil;
    self.localeOptions = nil;
    self.assignmentRuleHeader = nil;
    self.mruHeader = nil;
    self.allowFieldTruncationHeader = nil;
    self.disableFeedTrackingHeader = nil;
    self.streamingEnabledHeader = nil;
    self.allOrNoneHeader = nil;
    self.debuggingHeader = nil;
    self.emailHeader = nil;
    self.ownerChangeOptions = nil;
    self.userTerritoryDeleteHeader = nil;
    self.queryOptions = nil;
    self.duplicateRuleHeader = nil;
	[super dealloc];
}

- (id)copyWithZone:(NSZone *)zone {
	ZKSforceClient *rhs = [[ZKSforceClient alloc] init];
	[rhs->authEndpointUrl release];
	rhs->authEndpointUrl = [authEndpointUrl copy];
	rhs->endpointUrl = [endpointUrl copy];
	rhs->userInfo = [userInfo retain];
	rhs->preferedApiVersion = preferedApiVersion;
    rhs->authSource = [authSource retain];
    rhs->limitInfo = [limitInfo retain];
	[rhs setCacheDescribes:cacheDescribes];
    rhs.callOptions = self.callOptions;
    rhs.packageVersionHeader = self.packageVersionHeader;
    rhs.localeOptions = self.localeOptions;
    rhs.assignmentRuleHeader = self.assignmentRuleHeader;
    rhs.mruHeader = self.mruHeader;
    rhs.allowFieldTruncationHeader = self.allowFieldTruncationHeader;
    rhs.disableFeedTrackingHeader = self.disableFeedTrackingHeader;
    rhs.streamingEnabledHeader = self.streamingEnabledHeader;
    rhs.allOrNoneHeader = self.allOrNoneHeader;
    rhs.debuggingHeader = self.debuggingHeader;
    rhs.emailHeader = self.emailHeader;
    rhs.ownerChangeOptions = self.ownerChangeOptions;
    rhs.userTerritoryDeleteHeader = self.userTerritoryDeleteHeader;
    rhs.queryOptions = self.queryOptions;
    rhs.duplicateRuleHeader = self.duplicateRuleHeader;
    rhs.delegate = delegate;
	return rhs;
}

-(NSObject<ZKAuthenticationInfo> *)authenticationInfo {
    return authSource;
}

-(void)setAuthenticationInfo:(NSObject<ZKAuthenticationInfo> *)authenticationInfo {
    [authSource autorelease];
    authSource = [authenticationInfo retain];
    self.endpointUrl = [authSource instanceUrl];
    self.userInfo = nil;
}

- (void)flushCachedDescribes {
	[describes release];
	describes = nil;
	if (cacheDescribes)
		describes = [[NSMutableDictionary alloc] init];
}

- (void)setLoginProtocolAndHost:(NSString *)protocolAndHost {
	[self setLoginProtocolAndHost:protocolAndHost andVersion:preferedApiVersion];
}

- (void)setLoginProtocolAndHost:(NSString *)protocolAndHost andVersion:(int)version {
	[authEndpointUrl release];
    // www.salesforce.com is no longer going to be support for login, so map requests for that
    // to login.salesforce.com
    NSString *www = @"://www.salesforce.com";
    NSString *login = @"://login.salesforce.com";
    protocolAndHost = [protocolAndHost stringByReplacingOccurrencesOfString:www withString:login options:NSCaseInsensitiveSearch range:NSMakeRange(0, protocolAndHost.length)];
	authEndpointUrl = [[NSString stringWithFormat:@"%@/services/Soap/u/%d.0", protocolAndHost, version] retain];
    preferedApiVersion = version;
}

- (NSURL *)authEndpointUrl {
	return [NSURL URLWithString:authEndpointUrl];
}

-(ZKLoginResult *)soapLogin:(ZKSoapLogin *)auth {
	ZKLoginResult *lr = [auth login];
    [self setAuthenticationInfo:auth];
    self.userInfo = lr.userInfo;
    return lr;
}

- (ZKLoginResult *)login:(NSString *)un password:(NSString *)pwd {
    ZKSoapLogin *auth = [ZKSoapLogin soapLoginWithUsername:un password:pwd authHost:[NSURL URLWithString:authEndpointUrl] apiVersion:preferedApiVersion clientId:self.clientId delegate:delegate];
    return [self soapLogin:auth];
}

- (void)loginFromOAuthCallbackUrl:(NSString *)callbackUrl oAuthConsumerKey:(NSString *)oauthClientId{
    ZKOAuthInfo *auth = [ZKOAuthInfo oauthInfoFromCallbackUrl:[NSURL URLWithString:callbackUrl] clientId:oauthClientId];
    [auth setApiVersion:preferedApiVersion];
    [self setAuthenticationInfo:auth];
}

- (void)loginWithRefreshToken:(NSString *)refreshToken authUrl:(NSURL *)authUrl oAuthConsumerKey:(NSString *)cid {
    ZKOAuthInfo *auth = [[[ZKOAuthInfo alloc] initWithRefreshToken:refreshToken authHost:authUrl sessionId:nil instanceUrl:nil clientId:cid] autorelease];
    [auth setApiVersion:preferedApiVersion];
    [self setAuthenticationInfo:auth];
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
    [userInfo autorelease];
    userInfo = [ui retain];
}

- (BOOL)loggedIn {
	return [[authSource sessionId] length] > 0;
}

- (void)checkSession {
    if ([authSource refreshIfNeeded])
        self.endpointUrl = [authSource instanceUrl];
}

- (ZKUserInfo *)currentUserInfo {
    if (userInfo == nil)
        userInfo = [[self getUserInfo] retain];
	return userInfo;
}

- (NSURL *)serverUrl {
	return endpointUrl;
}

- (NSString *)sessionId {
	[self checkSession];
	return [authSource sessionId];
}

-(BOOL)updateMru {
    return self.mruHeader == nil ? FALSE : self.mruHeader.updateMru;
}

-(void)setUpdateMru:(BOOL)mru {
    if (self.mruHeader == nil)
        self.mruHeader = [[[ZKMruHeader alloc] init] autorelease];
    self.mruHeader.updateMru = mru;
}

-(NSString *)clientId {
    return self.callOptions.client;
}

-(void)setClientId:(NSString *)newClientId {
    if (self.callOptions == nil)
        self.callOptions = [[[ZKCallOptions alloc] init] autorelease];
    self.callOptions.client = newClientId;
}

-(NSNumber *)queryBatchSize {
    return [NSNumber numberWithInteger:self.queryOptions.batchSize];
}

-(void)setQueryBatchSize:(NSNumber *)newBatchSize {
    if (newBatchSize == nil)
        self.queryOptions = nil;
    else {
        if (self.queryOptions == nil)
            self.queryOptions = [[[ZKQueryOptions alloc] init] autorelease];
        self.queryOptions.batchSize = [newBatchSize integerValue];
    }
}

- (NSString *)serverHostAbbriviation {
    NSString *host = [endpointUrl host];
    NSString *hostLower = [host lowercaseString];
    NSArray *suffixes = [NSArray arrayWithObjects:@".salesforce.com", @".force.com", nil];
    for (NSString *suffix in suffixes) {
        if ([hostLower hasSuffix:suffix]) {
            // remove the expected suffix from the host name.
            host = [host substringToIndex:[host length] - [suffix length]];
            // remove the trailing -api if there is one.
            return [[host lowercaseString] hasSuffix:@"-api"] ? [host substringToIndex:[host length] - 4] : host;
        }
    }
    return host;
}

-(void)addCallOptions:(ZKEnvelope *)env {
    [self addHeader:self.callOptions name:@"CallOptions" toEnvelope:env];
}

-(void)addPackageVersionHeader:(ZKEnvelope *)env {
    [self addHeader:self.packageVersionHeader name:@"PackageVersionHeader" toEnvelope:env];
}

-(void)addLocaleOptions:(ZKEnvelope *)env {
    [self addHeader:self.localeOptions name:@"LocaleHeader" toEnvelope:env];
}

-(void)addAssignmentRuleHeader:(ZKEnvelope *)env {
    [self addHeader:self.assignmentRuleHeader name:@"AssignmentRuleHeader" toEnvelope:env];
}

-(void)addMruHeader:(ZKEnvelope *)env {
    [self addHeader:self.mruHeader name:@"MruHeader" toEnvelope:env];
}

-(void)addAllowFieldTruncationHeader:(ZKEnvelope *)env {
    [self addHeader:self.allowFieldTruncationHeader name:@"AllowFieldTruncationHeader" toEnvelope:env];
}

-(void)addDisableFeedTrackingHeader:(ZKEnvelope *)env {
    [self addHeader:self.disableFeedTrackingHeader name:@"DisableFeedTrackingHeader" toEnvelope:env];
}

-(void)addStreamingEnabledHeader:(ZKEnvelope *)env {
    [self addHeader:self.streamingEnabledHeader name:@"StreamingEnabledHeader" toEnvelope:env];
}

-(void)addAllOrNoneHeader:(ZKEnvelope *)env {
    [self addHeader:self.allOrNoneHeader name:@"AllOrNoneHeader" toEnvelope:env];
}

-(void)addDebuggingHeader:(ZKEnvelope *)env {
    [self addHeader:self.debuggingHeader name:@"DebuggingHeader" toEnvelope:env];
}

-(void)addEmailHeader:(ZKEnvelope *)env {
    [self addHeader:self.emailHeader name:@"EmailHeader" toEnvelope:env];
}

-(void)addOwnerChangeOptions:(ZKEnvelope *)env {
    [self addHeader:self.ownerChangeOptions name:@"OwnerChangeOptions" toEnvelope:env];
}

-(void)addUserTerritoryDeleteHeader:(ZKEnvelope *)env {
    [self addHeader:self.userTerritoryDeleteHeader name:@"UserTerritoryDeleteHeader" toEnvelope:env];
}

-(void)addQueryOptions:(ZKEnvelope *)env {
    [self addHeader:self.queryOptions name:@"QueryOptions" toEnvelope:env];
}

-(void)addDuplicateRuleHeader:(ZKEnvelope *)env {
    [self addHeader:self.duplicateRuleHeader name:@"DuplicateRuleHeader" toEnvelope:env];
}

- (NSArray *)describeGlobal {
	if(!authSource) return NULL;
	[self checkSession];
	if (cacheDescribes) {
		NSArray *dg = [describes objectForKey:@"describe__global"];	// won't be an sfdc object ever called this.
		if (dg != nil) return dg;
	}
	
	ZKEnvelope * env = [[ZKPartnerEnvelope alloc] initWithSessionHeader:[authSource sessionId]];
    [self addCallOptions:env];
    [self addPackageVersionHeader:env];
    [self addLocaleOptions:env];
    [env moveToBody];
	[env startElement:@"describeGlobal"];
	[env endElement:@"describeGlobal"];
	
    zkElement * rr = [self sendRequest:[env end] name:NSStringFromSelector(_cmd)];
	NSArray *results = [[rr childElement:@"result"] childElements:@"sobjects"];
	NSMutableArray *types = [NSMutableArray arrayWithCapacity:[results count]];
    for (zkElement *res in results) {
		ZKDescribeGlobalSObject * d = [[ZKDescribeGlobalSObject alloc] initWithXmlElement:res];
		[types addObject:d];
		[d release];
	}
	[env release];
	if (cacheDescribes)
		[describes setObject:types forKey:@"describe__global"];
	return types;
}

- (ZKDescribeSObject *)describeSObject:(NSString *)sobjectName {
	if (!authSource) return NULL;
	if (cacheDescribes) {
		ZKDescribeSObject * desc = [describes objectForKey:[sobjectName lowercaseString]];
		if (desc != nil) return desc;
	}
	[self checkSession];
	
	ZKEnvelope * env = [[ZKPartnerEnvelope alloc] initWithSessionHeader:[authSource sessionId]];
    [self addCallOptions:env];
    [self addPackageVersionHeader:env];
    [self addLocaleOptions:env];
    [env moveToBody];
	[env startElement:@"describeSObject"];
	[env addElement:@"SobjectType" elemValue:sobjectName];
	[env endElement:@"describeSObject"];
	
	zkElement *dr = [self sendRequest:[env end] name:NSStringFromSelector(_cmd)];
	zkElement *descResult = [dr childElement:@"result"];
	ZKDescribeSObject *desc = [[[ZKDescribeSObject alloc] initWithXmlElement:descResult] autorelease];
	[env release];
	if (cacheDescribes) 
		[describes setObject:desc forKey:[sobjectName lowercaseString]];
	return desc;
}

- (NSArray *)search:(NSString *)sosl {
	if (!authSource) return NULL;
	[self checkSession];
	ZKEnvelope * env = [[ZKPartnerEnvelope alloc] initWithSessionHeader:[authSource sessionId]];
    [self addCallOptions:env];
    [self addPackageVersionHeader:env];
    [env moveToBody];
	[env startElement:@"search"];
	[env addElement:@"searchString" elemValue:sosl];
	[env endElement:@"search"];
	
	zkElement *sr = [self sendRequest:[env end] name:NSStringFromSelector(_cmd)];
	zkElement *searchResult = [sr childElement:@"result"];
	NSArray *records = [searchResult childElements:@"searchRecords"];
	NSMutableArray *sobjects = [NSMutableArray arrayWithCapacity:[records count]];
	for (zkElement *soNode in records)
		[sobjects addObject:[ZKSObject fromXmlNode:[soNode childElement:@"record"]]];
	[env release];
	return sobjects;
}

- (NSArray *)create:(NSArray *)objects {
	return [self sobjectsImpl:objects name:@"create"];
}

- (NSArray *)update:(NSArray *)objects {
	return [self sobjectsImpl:objects name:@"update"];
}

- (NSArray *)sobjectsImpl:(NSArray *)objects name:(NSString *)elemName {
	if(!authSource) return NULL;
	[self checkSession];
	
	// if more than we can do in one go, break it up.
	if ([objects count] > SAVE_BATCH_SIZE) {
		NSMutableArray *allResults = [NSMutableArray arrayWithCapacity:[objects count]];
		NSRange rng = {0, MIN(SAVE_BATCH_SIZE, [objects count])};
		while (rng.location < [objects count]) {
			[allResults addObjectsFromArray:[self sobjectsImpl:[objects subarrayWithRange:rng] name:elemName]];
			rng.location += rng.length;
			rng.length = MIN(SAVE_BATCH_SIZE, [objects count] - rng.location);
		}
		return allResults;
	}
	ZKEnvelope * env = [[ZKPartnerEnvelope alloc] initWithSessionHeader:[authSource sessionId]];
    [self addCallOptions:env];
    [self addAssignmentRuleHeader:env];
    [self addMruHeader:env];
    [self addAllowFieldTruncationHeader:env];
    [self addDisableFeedTrackingHeader:env];
    [self addStreamingEnabledHeader:env];
    [self addAllOrNoneHeader:env];
    [self addDebuggingHeader:env];
    [self addPackageVersionHeader:env];
    [self addEmailHeader:env];
    if ([elemName isEqualToString:@"update"])
        [self addOwnerChangeOptions:env];
    [env moveToBody];
	[env startElement:elemName];
    for (ZKSObject *o in objects) 
		[env addElement:@"sobject" elemValue:o];
	[env endElement:elemName];

	zkElement *cr = [self sendRequest:[env end] name:[NSString stringWithFormat:@"%@:", elemName]];
	NSArray *resultsArr = [cr childElements:@"result"];
	NSMutableArray *results = [NSMutableArray arrayWithCapacity:[resultsArr count]];
	for (zkElement *cr in resultsArr) {
		ZKSaveResult * sr = [[ZKSaveResult alloc] initWithXmlElement:cr];
		[results addObject:sr];
		[sr release];
	}
	[env release];
	return results;
}

- (NSDictionary *)retrieve:(NSString *)fields sobject:(NSString *)sobjectType ids:(NSArray *)ids {
    return [self retrieve:fields sObjectType:sobjectType ids:ids];
}

- (NSDictionary *)retrieve:(NSString *)fields sObjectType:(NSString *)sobjectType ids:(NSArray *)ids {
	if(!authSource) return NULL;
	[self checkSession];
	
	ZKEnvelope * env = [[ZKPartnerEnvelope alloc] initWithSessionHeader:[authSource sessionId]];
    [self addCallOptions:env];
    [self addQueryOptions:env];
    [self addMruHeader:env];
    [self addPackageVersionHeader:env];
    [env moveToBody];
	[env startElement:@"retrieve"];
	[env addElement:@"fieldList" elemValue:fields];
	[env addElement:@"sObjectType" elemValue:sobjectType];
	[env addElementArray:@"ids" elemValue:ids];
	[env endElement:@"retrieve"];
	
	zkElement *rr = [self sendRequest:[env end] name:NSStringFromSelector(_cmd)];
	NSMutableDictionary *sobjects = [NSMutableDictionary dictionary]; 
	NSArray *results = [rr childElements:@"result"];
	for (zkElement *res in results) {
		ZKSObject *o = [[ZKSObject alloc] initWithXmlElement:res];
		[sobjects setObject:o forKey:[o id]];
		[o release];
	}
	[env release];
	return sobjects;
}

-(void)updateLimitInfo:(zkElement *)soapHeaders {
    // this looks in the last response for a limit info header and if we got one, hangs onto it.
    zkElement *liElem = [soapHeaders childElement:@"LimitInfoHeader" ns:@"urn:partner.soap.sforce.com"];
    if (liElem != nil) {
        [limitInfo autorelease];
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
