// Copyright (c) 2011,2018,2019 Simon Fell
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

#import "ZKAuthenticationInfo.h"
#import "ZKBlockTypes.h"
#import "ZKBaseClient.h"

@class ZKLoginResult;

// base class with common auth code in.
@interface ZKAuthInfoBase : NSObject {
}

@end

// Impl of ZKAuthenticationInfo that uses an OAuth2 refresh token to generate new session Ids.
@interface ZKOAuthInfo : ZKAuthInfoBase<ZKAuthenticationInfo> {
}

+(instancetype)oauthInfoFromCallbackUrl:(NSURL *)callbackUrl clientId:(NSString *)cid error:(NSError **)err;
+(instancetype)oauthInfoWithRefreshToken:(NSString *)tkn authHost:(NSURL *)auth clientId:(NSString *)cid;
+(instancetype)oauthInfoWithRefreshToken:(NSString *)tkn authHost:(NSURL *)auth sessionId:(NSString *)sid instanceUrl:(NSURL *)inst clientId:(NSString *)cid;

-(instancetype)init NS_UNAVAILABLE;
-(instancetype)initWithRefreshToken:(NSString *)tkn authHost:(NSURL *)authUrl sessionId:(NSString *)sid instanceUrl:(NSURL *)inst clientId:(NSString *)cid NS_DESIGNATED_INITIALIZER;

@property (assign) int apiVersion;
@property (readonly) NSURL *authHostUrl;
@property (readonly) NSString *refreshToken;
@end


// Impl of ZKAuthenticationInfo that uses Soap Login calls to generate new session Ids.
@interface ZKSoapLogin : ZKAuthInfoBase<ZKAuthenticationInfo> {
}

+(instancetype)soapLoginWithUsername:(NSString *)un password:(NSString *)pwd authHost:(NSURL *)auth apiVersion:(int)v clientId:(NSString *)cid delegate:(NSObject<ZKBaseClientDelegate> *)delegate;

// Starts a login request. Callbacks will be on the supplied queue.
-(void)startLoginWithQueue:(dispatch_queue_t)queue failBlock:(ZKFailWithErrorBlock)failBlock completeBlock:(ZKCompleteLoginResultBlock)cb;

@end


// Impl of ZKAuthenticationInfo that uses Soap Login calls setup for portal users to generate new session Ids.
@interface ZKSoapPortalLogin : ZKSoapLogin {
}

+(instancetype)soapPortalLoginWithUsername:(NSString *)un password:(NSString *)pwd authHost:(NSURL *)auth apiVersion:(int)v clientId:(NSString *)cid delegate:(NSObject<ZKBaseClientDelegate> *)delegate orgId:(NSString *)orgId portalId:(NSString *)portalId;

@end
