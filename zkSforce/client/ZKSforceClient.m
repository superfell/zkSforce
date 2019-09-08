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
#import "ZKSObject.h"
#import "ZKDescribeSObject.h"
#import "ZKLoginResult.h"
#import "ZKParser.h"
#import "ZKConstants.h"
#import "ZKLimitInfoHeader.h"
#import "ZKXMLSerializable.h"
#import "ZKXmlDeserializer.h"
#import "ZKCallOptions.h"
#import "ZKMruHeader.h"
#import "ZKQueryOptions.h"
#import "NSArray+Extras.h"

static const int SAVE_BATCH_SIZE = 25;
static const int DEFAULT_API_VERSION = 46;

@interface ZKSforceClient(Private)
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
       failBlock:(ZKFailWithErrorBlock)failBlock
   completeBlock:(ZKCompleteLoginResultBlock)completeBlock {
    
    [auth startLoginWithFailBlock:failBlock completeBlock:^(ZKLoginResult *result) {
        self.authenticationInfo = auth;
        self.userInfo = result.userInfo;
        completeBlock(result);
    }];
}

/** Login to the Salesforce API with username & password */
-(void) performLogin:(NSString *)username password:(NSString *)password
           failBlock:(ZKFailWithErrorBlock)failBlock
       completeBlock:(ZKCompleteLoginResultBlock)completeBlock {

    ZKSoapLogin *auth = [ZKSoapLogin soapLoginWithUsername:username
                                                  password:password
                                                  authHost:[NSURL URLWithString:authEndpointUrl]
                                                apiVersion:preferedApiVersion
                                                  clientId:self.clientId
                                                  delegate:self.delegate];
    [self soapLogin:auth failBlock:failBlock completeBlock:completeBlock];
}

- (NSError *)loginFromOAuthCallbackUrl:(NSString *)callbackUrl oAuthConsumerKey:(NSString *)oauthClientId {
    NSError *err = nil;
    ZKOAuthInfo *auth = [ZKOAuthInfo oauthInfoFromCallbackUrl:[NSURL URLWithString:callbackUrl] clientId:oauthClientId error:&err];
    if (err != nil) {
        return err;
    }
    auth.apiVersion = preferedApiVersion;
    self.authenticationInfo = auth;
    return nil;
}

- (void)loginWithRefreshToken:(NSString *)refreshToken authUrl:(NSURL *)authUrl oAuthConsumerKey:(NSString *)cid
                    failBlock:(ZKFailWithErrorBlock)failBlock
                completeBlock:(ZKCompleteVoidBlock)completeBlock {
    
    ZKOAuthInfo *auth = [[ZKOAuthInfo alloc] initWithRefreshToken:refreshToken authHost:authUrl sessionId:nil instanceUrl:nil clientId:cid];
    auth.apiVersion = preferedApiVersion;
    [auth refresh:^(NSError *ex) {
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
                     failBlock:(ZKFailWithErrorBlock)failBlock
                 completeBlock:(ZKCompleteLoginResultBlock)completeBlock {
    
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

-(void)currentUserInfoWithFailBlock:(ZKFailWithErrorBlock)failBlock
                      completeBlock:(ZKCompleteUserInfoBlock)completeBlock {
    ZKUserInfo *i = self.userInfo;
    if (i != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completeBlock(i);
        });
        return;
    }
    [self getUserInfoWithFailBlock:failBlock completeBlock:^(ZKUserInfo *result) {
        self.userInfo = result;
        completeBlock(result);
    }];
}

- (NSURL *)serverUrl {
    return self.endpointUrl;
}

- (NSString *)sessionId {
    return self.authSource.sessionId;
}

-(BOOL)updateMru {
    return [self.mruHeader updateMru];
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

/** Update a set of sObjects, chunks in SAVE_BATCH_SIZE chunks if needed */
-(void) update:(NSArray *)sObjects
     failBlock:(ZKFailWithErrorBlock)failBlock
 completeBlock:(ZKCompleteArrayBlock)completeBlock {
    
    if (sObjects.count <= SAVE_BATCH_SIZE) {
        [super update:sObjects failBlock:failBlock completeBlock:completeBlock];
        return;
    }
    NSMutableArray *results = [NSMutableArray arrayWithCapacity:sObjects.count];
    NSArray *chunks = [sObjects ZKPartitionWithSize:SAVE_BATCH_SIZE];
    NSUInteger __block idx = 0;
    
    ZKCompleteArrayBlock cb;
    cb = ^void(NSArray *result) {
        [results addObjectsFromArray:result];
        idx++;
        if (idx >= chunks.count) {
            completeBlock(results);
        } else {
            // next chunk
            [super update:chunks[idx] failBlock:failBlock completeBlock:cb];
        }
    };
    [super update:chunks[0] failBlock:failBlock completeBlock:cb];
}

/** Create a set of sObjects, chunks in SAVE_BATCH_SIZE chunks if needed */
-(void) create:(NSArray *)sObjects
     failBlock:(ZKFailWithErrorBlock)failBlock
 completeBlock:(ZKCompleteArrayBlock)completeBlock {
    
    if (sObjects.count <= SAVE_BATCH_SIZE) {
        [super create:sObjects failBlock:failBlock completeBlock:completeBlock];
        return;
    }
    NSMutableArray *results = [NSMutableArray arrayWithCapacity:sObjects.count];
    NSArray *chunks = [sObjects ZKPartitionWithSize:SAVE_BATCH_SIZE];
    NSUInteger __block idx = 0;
    
    ZKCompleteArrayBlock cb;
    cb = ^void(NSArray *result) {
        [results addObjectsFromArray:result];
        idx++;
        if (idx >= chunks.count) {
            completeBlock(results);
        } else {
            // next chunk
            [super create:chunks[idx] failBlock:failBlock completeBlock:cb];
        }
    };
    [super create:chunks[0] failBlock:failBlock completeBlock:cb];
}

-(NSDictionary *)makeRetrieveResult:(ZKElement *)root {
    ZKElement *body = [root childElement:@"Body" ns:NS_SOAP_ENV];
    ZKXmlDeserializer *deser = [[ZKXmlDeserializer alloc] initWithXmlElement:body.childElements[0]];
    NSMutableDictionary *sobjects = [NSMutableDictionary dictionary];
    for (ZKSObject *o in [deser complexTypeArrayFromElements:@"result" cls:[ZKSObject class]]) {
        sobjects[o.id] = o;
    }
    return sobjects;
}

-(void)handleResponseSoapHeaders:(ZKElement *)soapHeaders {
    // this looks in the supplied headers for a limit info header and if we got one, hangs onto it.
    ZKElement *liElem = [soapHeaders childElement:@"LimitInfoHeader" ns:NS_SFORCE_PARTNER];
    if (liElem != nil) {
        limitInfo = [[ZKLimitInfoHeader alloc] initWithXmlElement:liElem];
    }
}

@end
