// Copyright (c) 2006-2013,2019 Simon Fell
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


#import "ZKSforceBaseClient.h"
#import "ZKSforceBaseClient+Operations.h"
#import "ZKAuthentication.h"

@class ZKEnvelope;
@class ZKLimitInfoHeader;

/**
  This is the primary entry point into the library, you'd create one of these
  call login, then use it to make other API calls. Your session is automatically
  kept alive, and login will be called again for you if needed.
 
*/
@interface ZKSforceClient : ZKSforceBaseClient {
    NSString            *authEndpointUrl;
    ZKUserInfo          *userInfo;
    BOOL                cacheDescribes;
    NSMutableDictionary *describes;
    int                 preferedApiVersion;

    ZKLimitInfoHeader   *limitInfo;
    
    // Soap Headers were here, are now in ZKSforceBaseClient
}

/** @name configuration for where to connect to and what api version to use */

/** Set the default API version to connect to. (defaults to v46.0)
 login will detect if the endpoint doesn't have this
 version and automatically retry on a lower API version.
*/
@property (assign) int preferedApiVersion;

/** What endpoint to connect to? this should just be the protocol and host
    part of the URL, e.g. https://test.salesforce.com
*/
-(void)setLoginProtocolAndHost:(NSString *)protocolAndHost;

/** set both the endpoint to connect to, and an explicit API version to use. */
-(void)setLoginProtocolAndHost:(NSString *)protocolAndHost andVersion:(int)version;

/** returns an NSURL of where authentication will currently go. */
@property (readonly) NSURL *authEndpointUrl;


/** @name Start an API session, need to call one of these before making any api call */

/** Attempt a login request. If a security token is required to be used you need to
    append it to the password parameter.
    The callbacks will be executed on the main queue

    @param username the salesforce username to try and authenticate
    @param password the password [and possibly api security token] of the user
*/
-(void) login:(NSString *)username password:(NSString *)password
    failBlock:(ZKFailWithErrorBlock)failBlock
completeBlock:(ZKCompleteLoginResultBlock)completeBlock;

/** Initialize the authentication info from the parameters contained in the OAuth
    completion callback Uri passed in. Call this when the oauth flow is complete,
    this doesn't start the oauth flow.

    @param callbackUrl the oauth callback URL received from the OS
    @param oauthClientId the oauth consumerKey for your applications oauth configuration
    @return an error if it can't parse the callback fragment, or it indicates an error
 */
- (NSError *)loginFromOAuthCallbackUrl:(NSString *)callbackUrl oAuthConsumerKey:(NSString *)oauthClientId;

/** Login by making a refresh token request with this refresh Token to the specifed
    authentication host. oAuthConsumerKey is the oauth client_id / consumer key
    The callbacks will be executed on the main queue
 
    @param refreshToken  a refresh token previously obtained from the oauth login flow
    @param authUrl       the URL to the token service to send the refresh token to
    @param oauthClientId the OAuth consumer key for your applications oauth configuration
 */
- (void)loginWithRefreshToken:(NSString *)refreshToken authUrl:(NSURL *)authUrl oAuthConsumerKey:(NSString *)oauthClientId
                    failBlock:(ZKFailWithErrorBlock)failBlock
                completeBlock:(ZKCompleteVoidBlock)completeBlock;


/** Attempt a login for a portal User.
 
    In the case of self service portals, you can ony authenticate users, they don't have access
    to the rest of the API, attempts to call other API methods will return an error.
    The callbacks will be executed on the main queue

    @param username  the portal users username
    @param password  the portal users password
    @param orgId     OrgId is required, and should be the Id of the organization that owns the portal.
    @param portalId  PortalId is required for new generation portals, can be null for old style self service portals.
*/
- (void)portalLogin:(NSString *)username password:(NSString *)password orgId:(NSString *)orgId portalId:(NSString *)portalId
          failBlock:(ZKFailWithErrorBlock)failBlock
      completeBlock:(ZKCompleteLoginResultBlock)completeBlock;


/** Authentication Management
    This lets you manage different authentication schemes, like OAuth.
    Normally you'd just call login:password or loginFromOAuthCallbackUrl:
    which will create a ZKAuthenticationInfo object for you.
*/
@property (strong) NSObject<ZKAuthenticationInfo> *authenticationInfo;


//////////////////////////////////////////////////////////////////////////////////////
// Methods from the WSDL such as delete, query, merge, etc are all declared in
// ZKSforceBaseClient+Operations.h
//////////////////////////////////////////////////////////////////////////////////////


/** @name SessionInfo - Information about the current session */

/** @return the currently cached userInfo. May be nil if there's yet to be an API
    interaction that would generate a userInfo response */
-(ZKUserInfo *)cachedUserInfo;

/** @return the last cached UserInfo result, either from a LoginResult or by calling
    getUserInfo to get a copy to cache. */
-(void)currentUserInfoWithFailBlock:(ZKFailWithErrorBlock)failBlock
                      completeBlock:(ZKCompleteUserInfoBlock)completeBlock;

/** @return the current endpoint URL where requests are being sent. */
@property (readonly) NSURL *serverUrl;

/** @return the current API session Id being used to make requests,
    nil if we don't currently have one */
@property (readonly) NSString *sessionId;

/** @return the short name of the current serverUrl, e.g. na1, eu0, cs5 etc, if the short name ends in -api, the -api part will be removed. */
@property (readonly) NSString *serverHostAbbriviation;

/** @name SOAP Headers - properties that represent soap headers that are sent in conjuction with relevant requests. */

/** contains the last received LimitInfoHeader we got from the server. */
@property (readonly) ZKLimitInfoHeader *lastLimitInfoHeader;


// These 3 are for backwards compat, they will update the relevant header property

/** Should create/update calls also update the users MRU info? (defaults false) */
@property (assign) BOOL updateMru;

/** If you have a clientId for a certifed partner application, you can set it here. */
@property (strong) NSString *clientId;

/** If you want to change the batch size for queries, you can set this to 200-2000, the default is null. (uses the server side default) */
@property (strong) NSNumber *queryBatchSize;


/** @name Caching for describeSObject/describeGlobal results. **/

/** describe caching support, if true, describeGlobal & describeSObject call results are cached. */
@property (assign) BOOL cacheDescribes;
 
/** will discard any current cached describes, any future describe request will fetch fresh info from salesforce */
- (void)flushCachedDescribes;

@end

/** These methods allow the generated operation code to be customized */
@interface ZKSforceClient (Hooks)

-(NSArray *)preHook_describeGlobal;
-(NSArray *)postHook_describeGlobal:(NSArray *)r;

-(ZKDescribeSObject *)preHook_describeSObject:(NSString *)sobjectName;
-(ZKDescribeSObject *)postHook_describeSObject:(ZKDescribeSObject *)r;

@end
