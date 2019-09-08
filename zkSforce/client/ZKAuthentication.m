// Copyright (c) 2011,2016,2018,2019 Simon Fell
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

#import "zkAuthentication.h"
#import "ZKPartnerEnvelope.h"
#import "zkParser.h"
#import "ZKLoginResult.h"
#import "ZKUserInfo.h"
#import "zkBaseClient.h"
#import "ZKConstants.h"

static const int DEFAULT_MAX_SESSION_AGE = 25 * 60; // 25 minutes

@interface ZKAuthInfoBase()
@property NSString *sessionId;
@property NSDate *sessionExpiresAt;
@property NSURLSession *urlSession;
@end

@implementation ZKAuthInfoBase

@synthesize sessionId, sessionExpiresAt;

-(void)refresh:(void(^)(NSException *ex))cb {
    // override me!
    cb(nil);
}

-(void)refreshIfNeeded:(void(^)(BOOL refreshed, NSException *ex))cb {
    if ((sessionExpiresAt.timeIntervalSinceNow < 0) || (sessionId == nil)) {
        [self refresh:^(NSException *ex) {
            cb(ex == nil, ex);
        }];
    } else {
        cb(FALSE, nil);
    }
}

@end

@interface ZKOAuthInfo()
@property (strong) NSURL *authHostUrl;
@property (strong) NSString *refreshToken;
@property (strong) NSURL *url;
@property (strong) NSString *clientId;
@end

@implementation ZKOAuthInfo

@synthesize apiVersion, refreshToken, authHostUrl;

+(NSDictionary *)decodeParams:(NSString *)params {
    NSMutableDictionary *results = [NSMutableDictionary dictionary];
    for (NSString *param in [params componentsSeparatedByString:@"&"]) {
        NSArray *paramParts = [param componentsSeparatedByString:@"="];
        NSString *name = [paramParts[0] stringByRemovingPercentEncoding];
        NSString *val = paramParts.count == 1 ? @"" : [paramParts[1] stringByRemovingPercentEncoding];
        results[name] = val;
    }
    if (results[@"error"] != nil)
        @throw [NSException exceptionWithName:@"OAuth Error" 
                                       reason:[NSString stringWithFormat:@"%@ : %@", results[@"error"], results[@"error_description"]]
                                     userInfo:results];
    return results;
}

+(instancetype)oauthInfoFromCallbackUrl:(NSURL *)callbackUrl clientId:(NSString *)cid {
    // callbackUrl will be something:///blah/blah#p=1&q=2&foo=bar
    // we need to get our params out of the callback fragment
    NSDictionary *params = [self decodeParams:callbackUrl.fragment];

    return [ZKOAuthInfo oauthInfoWithRefreshToken:params[@"refresh_token"]
                                         authHost:[NSURL URLWithString:params[@"id"]]
                                        sessionId:params[@"access_token"]
                                      instanceUrl:[NSURL URLWithString:params[@"instance_url"]]
                                         clientId:cid];
}

+(instancetype)oauthInfoWithRefreshToken:(NSString *)tkn authHost:(NSURL *)auth clientId:(NSString *)cid {
    return [[ZKOAuthInfo alloc] initWithRefreshToken:tkn authHost:auth sessionId:nil instanceUrl:nil clientId:cid];
}

+(instancetype)oauthInfoWithRefreshToken:(NSString *)tkn authHost:(NSURL *)auth sessionId:(NSString *)sid instanceUrl:(NSURL *)inst clientId:(NSString *)cid {
    return [[ZKOAuthInfo alloc] initWithRefreshToken:tkn authHost:auth sessionId:sid instanceUrl:inst clientId:cid];
}

-(instancetype)initWithRefreshToken:(NSString *)tkn authHost:(NSURL *)auth sessionId:(NSString *)sid instanceUrl:(NSURL *)inst clientId:(NSString *)cid {
    self = [super init];
    self.clientId = cid;
    self.sessionId = sid;
    self.refreshToken = tkn;
    self.url = inst;
    self.authHostUrl = [NSURL URLWithString:@"/" relativeToURL:auth];
    self.sessionExpiresAt = [NSDate dateWithTimeIntervalSinceNow:DEFAULT_MAX_SESSION_AGE];
    return self;
}

-(NSURL *)instanceUrl {
    return [NSURL URLWithString:[NSString stringWithFormat:@"/services/Soap/u/%d.0", apiVersion] relativeToURL:self.url];
}

-(void)refresh:(void(^)(NSException *ex))cb {
    NSURL *token = [NSURL URLWithString:@"/services/oauth2/token" relativeToURL:self.authHostUrl];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:token];
    req.HTTPMethod = @"POST";
    NSString *params = [NSString stringWithFormat:@"grant_type=refresh_token&refresh_token=%@&client_id=%@&format=urlencoded",
                      [self.refreshToken stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                      [self.clientId stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    req.HTTPBody = [params dataUsingEncoding:NSUTF8StringEncoding];
    [req addValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];

    NSURLSession *s = self.urlSession;
    if (s == nil) {
        s = [NSURLSession sharedSession];
    }
    NSURLSessionDataTask *t = [s dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != nil) {
            cb([NSException exceptionWithName:@"Http error"
                                       reason:[NSString stringWithFormat:@"Unable to complete OAuth token refresh request: %@", error]
                                     userInfo:nil]);
            return;
        }
        NSString *respBody = [[NSString alloc] initWithBytes:data.bytes length:data.length encoding:NSUTF8StringEncoding];
        @try {
            NSDictionary *results = [ZKOAuthInfo decodeParams:respBody];
            self.sessionId = results[@"access_token"];
            self.url = [NSURL URLWithString:results[@"instance_url"]];
            self.sessionExpiresAt = [NSDate dateWithTimeIntervalSinceNow:DEFAULT_MAX_SESSION_AGE];
            cb(nil);
        } @catch (NSException *ex) {
            cb(ex);
        }
    }];
    [t resume];
}

-(void)refreshIfNeeded:(void(^)(BOOL refreshed, NSException *ex))cb {
    [super refreshIfNeeded:^(BOOL refreshed, NSException *ex) {
        if (refreshed) {
            self.sessionExpiresAt = [NSDate dateWithTimeIntervalSinceNow:DEFAULT_MAX_SESSION_AGE];
        }
        cb(refreshed, ex);
    }];
}

@end

@interface ZKSoapLogin()
@property (strong) NSString *username;
@property (strong) NSString *password;
@property (strong) NSString *clientId;
@property (strong) ZKBaseClient *client;
@property (strong) NSURL *instanceUrl;
@end

@implementation ZKSoapLogin

@synthesize  username, password, clientId, client;

-(instancetype)initWithUsername:(NSString *)un password:(NSString *)pwd authHost:(NSURL *)auth apiVersion:(int)v clientId:(NSString *)cid delegate:(NSObject<ZKBaseClientDelegate> *)delegate {
    self = [super init];
    self.username = un;
    self.password = pwd;
    self.clientId = cid;
    self.client = [[ZKBaseClient alloc] init];
    self.client.endpointUrl = [NSURL URLWithString:[NSString stringWithFormat:@"/services/Soap/u/%d.0", v] relativeToURL:auth];
    self.client.delegate = delegate;
    return self;
}


-(void)refresh:(void(^)(NSException *ex))cb {
    [self startLoginWithFailBlock:^(NSException *result) {
        cb(result);
    } completeBlock:^(ZKLoginResult *result) {
        cb(nil);
    }];
}

- (void)refreshIfNeeded:(void (^)(BOOL, NSException *))cb {
    [super refreshIfNeeded:cb];
}


-(ZKPartnerEnvelope *)newEnvelope {
    ZKPartnerEnvelope *env = [[ZKPartnerEnvelope alloc] initWithSessionHeader:nil];
    [env writeCallOptionsHeader:self.clientId];
    [env moveToBody];
    return env;
}

-(void)startLoginWithFailBlock:(zkFailWithExceptionBlock)failBlock completeBlock:(zkCompleteLoginResultBlock)completeBlock {
    ZKEnvelope *env = [self newEnvelope];
    [env startElement:@"login"];
    [env addElement:@"username" elemValue:username];
    [env addElement:@"password" elemValue:password];
    [env endElement:@"login"];
    NSString *xml = env.end;

    client.urlSession = self.urlSession;
    [client startRequest:xml name:@"login" handler:^(zkElement *root, NSException *ex) {
        if (ex != nil) {
            failBlock(ex);
            return;
        }
        zkElement *body = [root childElement:@"Body" ns:NS_SOAP_ENV];
        zkElement *result = [body childElements:@"result"][0];
        ZKLoginResult *lr = [[ZKLoginResult alloc] initWithXmlElement:result];
        
        self.instanceUrl = [NSURL URLWithString:lr.serverUrl];
        self.sessionId = lr.sessionId;
        
        // if we have a sessionSecondsValid in the UserInfo, use that to control when we re-authenticate, otherwise take the default.
        NSInteger sessionAge = lr.userInfo.sessionSecondsValid > 0 ? lr.userInfo.sessionSecondsValid - 60 : DEFAULT_MAX_SESSION_AGE;
        self.sessionExpiresAt = [NSDate dateWithTimeIntervalSinceNow:sessionAge];
        completeBlock(lr);
    }];
}

+(instancetype)soapLoginWithUsername:(NSString *)un password:(NSString *)pwd authHost:(NSURL *)auth apiVersion:(int)v clientId:(NSString *)cid delegate:(NSObject<ZKBaseClientDelegate> *)delegate {
    return [[ZKSoapLogin alloc] initWithUsername:un password:pwd authHost:auth apiVersion:v clientId:cid delegate:delegate];
}

@end

@interface ZKSoapPortalLogin()
@property (strong) NSString *orgId;
@property (strong) NSString *portalId;
@end

@implementation ZKSoapPortalLogin

@synthesize orgId, portalId;

-(instancetype)initWithUsername:(NSString *)un password:(NSString *)pwd authHost:(NSURL *)auth apiVersion:(int)v clientId:(NSString *)cid delegate:(NSObject<ZKBaseClientDelegate> *)delegate orgId:(NSString *)oid portalId:(NSString *)pid {
    self = [super initWithUsername:un password:pwd authHost:auth apiVersion:v clientId:cid delegate:delegate];
    self.orgId = oid;
    self.portalId = pid;
    return self;
}

-(ZKPartnerEnvelope *)newEnvelope {
    ZKPartnerEnvelope *env = [[ZKPartnerEnvelope alloc] initWithSessionHeader:nil];
    [env moveToHeaders];
    [env writeCallOptionsHeader:self.clientId];
    [env startElement:@"LoginScopeHeader"];
    [env addElement:@"organizationId" elemValue:self.orgId];
    if (self.portalId.length > 0)
        [env addElement:@"portalId" elemValue:self.portalId];
    [env endElement:@"LoginScopeHeader"];
    [env moveToBody];
    return env;
}

+(instancetype)soapPortalLoginWithUsername:(NSString *)un password:(NSString *)pwd authHost:(NSURL *)auth apiVersion:(int)v clientId:(NSString *)cid delegate:(NSObject<ZKBaseClientDelegate> *)delegate orgId:(NSString *)orgId portalId:(NSString *)portalId {
    
    return [[ZKSoapPortalLogin alloc] initWithUsername:un password:pwd authHost:auth apiVersion:v clientId:cid delegate:delegate orgId:orgId portalId:portalId];
}

@end