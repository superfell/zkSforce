// Copyright (c) 2006-2013 Simon Fell
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


#import "zkBaseClient.h"
#import "zkAuthentication.h"

@class ZKUserInfo;
@class ZKDescribeSObject;
@class ZKQueryResult;
@class ZKLoginResult;
@class ZKDescribeLayoutResult;
@class ZKLimitInfoHeader;
@class ZKEnvelope;
@class ZKCallOptions;
@class ZKPackageVersionHeader;
@class ZKLocaleOptions;
@class ZKAssignmentRuleHeader;
@class ZKMruHeader;
@class ZKAllowFieldTruncationHeader;
@class ZKDisableFeedTrackingHeader;
@class ZKStreamingEnabledHeader;
@class ZKAllOrNoneHeader;
@class ZKDebuggingHeader;
@class ZKEmailHeader;
@class ZKOwnerChangeOptions;
@class ZKUserTerritoryDeleteHeader;
@class ZKQueryOptions;
@class ZKDuplicateRuleHeader;

/**
  This is the primary entry point into the library, you'd create one of these
  call login, then use it to make other API calls. Your session is automatically
  kept alive, and login will be called again for you if needed.
 
*/
@interface ZKSforceClient : ZKBaseClient <NSCopying> {
	NSString	*authEndpointUrl;
	ZKUserInfo	*userInfo;
	BOOL		cacheDescribes;
	NSMutableDictionary	*describes;
	int			preferedApiVersion;

    NSObject<ZKAuthenticationInfo>  *authSource;
    ZKLimitInfoHeader *limitInfo;
    
    // Soap Headers on requests
    ZKCallOptions           *callOptions;
    ZKPackageVersionHeader  *packageVersionHeader;
    ZKLocaleOptions         *localeOptions;
    ZKAssignmentRuleHeader  *assignmentRuleHeader;
    ZKMruHeader             *mruHeader;
    ZKAllowFieldTruncationHeader *allowFieldTruncationHeader;
    ZKDisableFeedTrackingHeader  *disableFeedTrackingHeader;
    ZKStreamingEnabledHeader     *streamingEnabledHeader;
    ZKAllOrNoneHeader            *allOrNoneHeader;
    ZKDebuggingHeader            *debuggingHeader;
    ZKEmailHeader                *emailHeader;
    ZKOwnerChangeOptions         *ownerChangeOptions;
    ZKUserTerritoryDeleteHeader  *userTerritoryDeleteHeader;
    ZKQueryOptions               *queryOptions;
    ZKDuplicateRuleHeader        *duplicateRuleHeader;
}

/** @name configuration for where to connect to and what api version to use */

/** Set the default API version to connect to. (defaults to v35.0)
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
-(NSURL *)authEndpointUrl;


/** @name Start an API session, need to call one of these before making any api call */

/** Attempt a login request. If a security token is required to be used you need to
    append it to the password parameter.
    @param username the salesforce username to try and authenticate
    @param password the password [and possibly api security token] of the user
*/
- (ZKLoginResult *)login:(NSString *)username password:(NSString *)password;

/** Initialize the authentication info from the parameters contained in the OAuth
    completion callback Uri passed in.
    call this when the oauth flow is complete, this doesn't start the oauth flow.
    @param callbackUrl the oauth callback URL received from the OS
    @param oauthClientId the oauth consumerKey for your applications oauth configuration
 */
- (void)loginFromOAuthCallbackUrl:(NSString *)callbackUrl oAuthConsumerKey:(NSString *)oauthClientId;

/** Login by making a refresh token request with this refresh Token to the specifed
    authentication host. oAuthConsumerKey is the oauth client_id / consumer key
 
    @param refreshToken  a refresh token previously obtained from the oauth login flow
    @param authUrl       the URL to the token service to send the refresh token to
    @param oauthClientId the OAuth consumer key for your applications oauth configuration
 */
- (void)loginWithRefreshToken:(NSString *)refreshToken authUrl:(NSURL *)authUrl oAuthConsumerKey:(NSString *)oauthClientId;

/** Attempt a login for a portal User.
 
    In the case of self service portals, you can ony authenticate users, they don't have access
    to the rest of the API, attempts to call other API methods will return an error.
 
    @param username  the portal users username
    @param password  the portal users password
    @param orgId     OrgId is required, and should be the Id of the organization that owns the portal.
    @param portalid  PortalId is required for new generation portals, can be null for old style self service portals.
*/
- (ZKLoginResult *)portalLogin:(NSString *)username password:(NSString *)password orgId:(NSString *)orgId portalId:(NSString *)portalId;

/** Authentication Management
    This lets you manage different authentication schemes, like oauth
    Normally you'd just call login:password or loginFromOAuthCallbackUrl:
    which will create a ZKAuthenticationInfo object for you.
*/
@property (retain) NSObject<ZKAuthenticationInfo> *authenticationInfo;


/** @name basic Web Service operations
    
    these set of methods pretty much map directly onto their Web Services counterparts.
    These methods will throw a ZKSoapException if there's an error.
*/


/** make a desribeGlobal call and @return an array of ZKDescribeGlobalSobject instances.
    if describeCaching is enabled, subsequent calls to this will use the locally cached
    copy.
*/
- (NSArray *)describeGlobal;

/** make a describeSObject call and @return a ZKDescribeSObject instance, if describe
    caching is enabled, subsequent requests for the same sobject will return the locally
    cached copy.
*/
- (ZKDescribeSObject *)describeSObject:(NSString *)sobjectName;

/** make a search call with the passed in SOSL expression, @return an array of ZKSObject instances.*/
- (NSArray *)search:(NSString *)sosl;

/** retreives a set of records, 
 
    @param fields       is a comma separated list of fields to fetch values for
    @param sobjectType  is the API name of the SObject type that we're fetching records for
    @param ids          is an array of record Ids, can be upto 200.
 
    @return a diction of record Id -> ZKSObject instance. If a specified record doesn't exist
    it won't appear in the returned dictionary
 */
- (NSDictionary *)retrieve:(NSString *)fields sObjectType:(NSString *)sobjectType ids:(NSArray *)ids;

/** retreives a set of records,
 
 @param fields       is a comma separated list of fields to fetch values for
 @param sobjectType  is the API name of the SObject type that we're fetching records for
 @param ids          is an array of record Ids, can be upto 200.
 
 @return a diction of record Id -> ZKSObject instance. If a specified record doesn't exist
 it won't appear in the returned dictionary
 */
- (NSDictionary *)retrieve:(NSString *)fields sobject:(NSString *)sobjectType ids:(NSArray *)ids;

/** create 1 or more new records in Salseforce.
 
    @param objects an array of ZKSObject's to create.
    @return a matching array of ZKSaveResults
*/
- (NSArray *)create:(NSArray *)objects;

/** update 1 or more records in Salseforce.
 
 @param objects an array of ZKSObject's to update.
 @return a matching array of ZKSaveResults
 */
- (NSArray *)update:(NSArray *)objects;


//////////////////////////////////////////////////////////////////////////////////////
// Other methods from the WSDL such as delete, query, merge, etc are all declared in
// ZKSforceClient+Operations.h
//////////////////////////////////////////////////////////////////////////////////////


/** @name SessionInfo - Information about the current session */

/** @return true if we've performed a login request and it succeeded. */
- (BOOL)loggedIn;

/** @return the UserInfo returned by the last call to login. */
- (ZKUserInfo *)currentUserInfo;

/** @return the current endpoint URL where requests are being sent. */
- (NSURL *)serverUrl;

/** @return the current API session Id being used to make requests */
- (NSString *)sessionId;

/** @return the short name of the current serverUrl, e.g. na1, eu0, cs5 etc, if the short name ends in -api, the -api part will be removed. */
- (NSString *)serverHostAbbriviation;

/** @name SOAP Headers - properties that represent soap headers that are sent in conjuction with relevant requests. */

/** contains the last received LimitInfoHeader we got from the server. */
@property (readonly) ZKLimitInfoHeader *lastLimitInfoHeader;

// These 3 are for backwards compat, they will update the relevant header property

/** Should create/update calls also update the users MRU info? (defaults false) */
@property (assign) BOOL updateMru;

/** If you have a clientId for a certifed partner application, you can set it here. */
@property (retain) NSString *clientId;

/** If you want to change the batch size for queries, you can set this to 200-2000, the default is null. (uses the server side default) */
@property (retain) NSNumber *queryBatchSize;

@property (retain) ZKCallOptions                *callOptions;
@property (retain) ZKPackageVersionHeader       *packageVersionHeader;
@property (retain) ZKLocaleOptions              *localeOptions;
@property (retain) ZKAssignmentRuleHeader       *assignmentRuleHeader;
@property (retain) ZKMruHeader                  *mruHeader;
@property (retain) ZKAllowFieldTruncationHeader *allowFieldTruncationHeader;
@property (retain) ZKDisableFeedTrackingHeader  *disableFeedTrackingHeader;
@property (retain) ZKStreamingEnabledHeader     *streamingEnabledHeader;
@property (retain) ZKAllOrNoneHeader            *allOrNoneHeader;
@property (retain) ZKDebuggingHeader            *debuggingHeader;
@property (retain) ZKEmailHeader                *emailHeader;
@property (retain) ZKOwnerChangeOptions         *ownerChangeOptions;
@property (retain) ZKUserTerritoryDeleteHeader  *userTerritoryDeleteHeader;
@property (retain) ZKQueryOptions               *queryOptions;
@property (retain) ZKDuplicateRuleHeader        *duplicateRuleHeader;

/** describe caching support, if true, describeGlobal & describeSObject call results are cached. */
@property (assign) BOOL cacheDescribes;
 
/** will discard any current cached describes, any future describe request will fetch fresh info from salesforce */
- (void)flushCachedDescribes;

@end


/** These are helper methods used by the Operations category, you shouldn't need to call these directly */
@interface ZKSforceClient (Helpers)
-(void)checkSession;
-(void)updateLimitInfo;
-(void)addCallOptions:(ZKEnvelope *)env;
-(void)addPackageVersionHeader:(ZKEnvelope *)env;
-(void)addLocaleOptions:(ZKEnvelope *)env;
-(void)addAssignmentRuleHeader:(ZKEnvelope *)env;
-(void)addMruHeader:(ZKEnvelope *)env;
-(void)addAllowFieldTruncationHeader:(ZKEnvelope *)env;
-(void)addDisableFeedTrackingHeader:(ZKEnvelope *)env;
-(void)addStreamingEnabledHeader:(ZKEnvelope *)env;
-(void)addAllOrNoneHeader:(ZKEnvelope *)env;
-(void)addDebuggingHeader:(ZKEnvelope *)env;
-(void)addEmailHeader:(ZKEnvelope *)env;
-(void)addOwnerChangeOptions:(ZKEnvelope *)env;
-(void)addUserTerritoryDeleteHeader:(ZKEnvelope *)env;
-(void)addQueryOptions:(ZKEnvelope *)env;
-(void)addDuplicateRuleHeader:(ZKEnvelope *)env;
@end

