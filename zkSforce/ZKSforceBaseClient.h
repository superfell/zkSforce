// Copyright (c) 2019 Simon Fell
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
// 
// Note: This file was generated by WSDL2ZKSforce. 
//		  see https://github.com/superfell/WSDL2ZKSforce
//       DO NOT HAND EDIT.
//


#import "zkBaseClient.h"

@protocol ZKAuthenticationInfo;
@class zkElement;
@class ZKAllOrNoneHeader;
@class ZKAllowFieldTruncationHeader;
@class ZKAssignmentRuleHeader;
@class ZKCallOptions;
@class ZKDebuggingHeader;
@class ZKDisableFeedTrackingHeader;
@class ZKDuplicateRuleHeader;
@class ZKEmailHeader;
@class ZKLocaleOptions;
@class ZKLoginScopeHeader;
@class ZKMruHeader;
@class ZKOwnerChangeOptions;
@class ZKPackageVersionHeader;
@class ZKQueryOptions;
@class ZKSessionHeader;
@class ZKStreamingEnabledHeader;
@class ZKUserTerritoryDeleteHeader;
@class ZKChangeOwnPasswordResult;
@class ZKDescribeAppMenuResult;
@class ZKDescribeApprovalLayoutResult;
@class ZKDescribeCompactLayoutsResult;
@class ZKDescribeGlobalTheme;
@class ZKDescribeLayoutResult;
@class ZKDescribePathAssistantsResult;
@class ZKDescribeSObject;
@class ZKDescribeSoftphoneLayoutResult;
@class ZKDescribeSoqlListViewResult;
@class ZKDescribeSoqlListViewsRequest;
@class ZKDescribeThemeResult;
@class ZKDescribeVisualForceResult;
@class ZKExecuteListViewRequest;
@class ZKExecuteListViewResult;
@class ZKGetDeletedResult;
@class ZKGetServerTimestampResult;
@class ZKGetUpdatedResult;
@class ZKKnowledgeSettings;
@class ZKLoginResult;
@class ZKQueryResult;
@class ZKRenderStoredEmailTemplateRequest;
@class ZKRenderStoredEmailTemplateResult;
@class ZKResetPasswordResult;
@class ZKSearchResult;
@class ZKSetPasswordResult;
@class ZKUserInfo;

@interface ZKSforceBaseClient : ZKBaseClient <NSCopying>

@property (strong) NSObject<ZKAuthenticationInfo> *authSource;

@property (strong) ZKAllOrNoneHeader             *allOrNoneHeader; 
@property (strong) ZKAllowFieldTruncationHeader  *allowFieldTruncationHeader; 
@property (strong) ZKAssignmentRuleHeader        *assignmentRuleHeader; 
@property (strong) ZKCallOptions                 *callOptions; 
@property (strong) ZKDebuggingHeader             *debuggingHeader; 
@property (strong) ZKDisableFeedTrackingHeader   *disableFeedTrackingHeader; 
@property (strong) ZKDuplicateRuleHeader         *duplicateRuleHeader; 
@property (strong) ZKEmailHeader                 *emailHeader; 
@property (strong) ZKLocaleOptions               *localeOptions; 
@property (strong) ZKLoginScopeHeader            *loginScopeHeader; 
@property (strong) ZKMruHeader                   *mruHeader; 
@property (strong) ZKOwnerChangeOptions          *ownerChangeOptions; 
@property (strong) ZKPackageVersionHeader        *packageVersionHeader; 
@property (strong) ZKQueryOptions                *queryOptions; 
@property (strong) ZKSessionHeader               *sessionHeader; 
@property (strong) ZKStreamingEnabledHeader      *streamingEnabledHeader; 
@property (strong) ZKUserTerritoryDeleteHeader   *userTerritoryDeleteHeader; 

-(NSString *)makeLoginEnv:(NSString *)username password:(NSString *)password;
-(ZKLoginResult *)makeLoginResult:(zkElement *)root;

-(NSString *)makeDescribeSObjectEnv:(NSString *)sObjectType;
-(ZKDescribeSObject *)makeDescribeSObjectResult:(zkElement *)root;

-(NSString *)makeDescribeSObjectsEnv:(NSArray *)sObjectType;
-(NSArray *)makeDescribeSObjectsResult:(zkElement *)root;

-(NSString *)makeDescribeGlobalEnv;
-(NSArray *)makeDescribeGlobalResult:(zkElement *)root;

-(NSString *)makeDescribeDataCategoryGroupsEnv:(NSArray *)sObjectType;
-(NSArray *)makeDescribeDataCategoryGroupsResult:(zkElement *)root;

-(NSString *)makeDescribeDataCategoryGroupStructuresEnv:(NSArray *)pairs topCategoriesOnly:(BOOL)topCategoriesOnly;
-(NSArray *)makeDescribeDataCategoryGroupStructuresResult:(zkElement *)root;

-(NSString *)makeDescribeDataCategoryMappingsEnv;
-(NSArray *)makeDescribeDataCategoryMappingsResult:(zkElement *)root;

-(NSString *)makeDescribeKnowledgeSettingsEnv;
-(ZKKnowledgeSettings *)makeDescribeKnowledgeSettingsResult:(zkElement *)root;

-(NSString *)makeDescribeAppMenuEnv:(NSString *)appMenuType networkId:(NSString *)networkId;
-(ZKDescribeAppMenuResult *)makeDescribeAppMenuResult:(zkElement *)root;

-(NSString *)makeDescribeGlobalThemeEnv;
-(ZKDescribeGlobalTheme *)makeDescribeGlobalThemeResult:(zkElement *)root;

-(NSString *)makeDescribeThemeEnv:(NSArray *)sobjectType;
-(ZKDescribeThemeResult *)makeDescribeThemeResult:(zkElement *)root;

-(NSString *)makeDescribeLayoutEnv:(NSString *)sObjectType layoutName:(NSString *)layoutName recordTypeIds:(NSArray *)recordTypeIds;
-(ZKDescribeLayoutResult *)makeDescribeLayoutResult:(zkElement *)root;

-(NSString *)makeDescribeSoftphoneLayoutEnv;
-(ZKDescribeSoftphoneLayoutResult *)makeDescribeSoftphoneLayoutResult:(zkElement *)root;

-(NSString *)makeDescribeSearchLayoutsEnv:(NSArray *)sObjectType;
-(NSArray *)makeDescribeSearchLayoutsResult:(zkElement *)root;

-(NSString *)makeDescribeSearchableEntitiesEnv:(BOOL)includeOnlyEntitiesWithTabs;
-(NSArray *)makeDescribeSearchableEntitiesResult:(zkElement *)root;

-(NSString *)makeDescribeSearchScopeOrderEnv:(BOOL)includeRealTimeEntities;
-(NSArray *)makeDescribeSearchScopeOrderResult:(zkElement *)root;

-(NSString *)makeDescribeCompactLayoutsEnv:(NSString *)sObjectType recordTypeIds:(NSArray *)recordTypeIds;
-(ZKDescribeCompactLayoutsResult *)makeDescribeCompactLayoutsResult:(zkElement *)root;

-(NSString *)makeDescribePathAssistantsEnv:(NSString *)sObjectType picklistValue:(NSString *)picklistValue recordTypeIds:(NSArray *)recordTypeIds;
-(ZKDescribePathAssistantsResult *)makeDescribePathAssistantsResult:(zkElement *)root;

-(NSString *)makeDescribeApprovalLayoutEnv:(NSString *)sObjectType approvalProcessNames:(NSArray *)approvalProcessNames;
-(ZKDescribeApprovalLayoutResult *)makeDescribeApprovalLayoutResult:(zkElement *)root;

-(NSString *)makeDescribeSoqlListViewsEnv:(ZKDescribeSoqlListViewsRequest *)request;
-(ZKDescribeSoqlListViewResult *)makeDescribeSoqlListViewsResult:(zkElement *)root;

-(NSString *)makeExecuteListViewEnv:(ZKExecuteListViewRequest *)request;
-(ZKExecuteListViewResult *)makeExecuteListViewResult:(zkElement *)root;

-(NSString *)makeDescribeSObjectListViewsEnv:(NSString *)sObjectType recentsOnly:(BOOL)recentsOnly isSoqlCompatible:(NSString *)isSoqlCompatible limit:(NSInteger)limit offset:(NSInteger)offset;
-(ZKDescribeSoqlListViewResult *)makeDescribeSObjectListViewsResult:(zkElement *)root;

-(NSString *)makeDescribeTabsEnv;
-(NSArray *)makeDescribeTabsResult:(zkElement *)root;

-(NSString *)makeDescribeAllTabsEnv;
-(NSArray *)makeDescribeAllTabsResult:(zkElement *)root;

-(NSString *)makeDescribePrimaryCompactLayoutsEnv:(NSArray *)sObjectTypes;
-(NSArray *)makeDescribePrimaryCompactLayoutsResult:(zkElement *)root;

-(NSString *)makeCreateEnv:(NSArray *)sObjects;
-(NSArray *)makeCreateResult:(zkElement *)root;

-(NSString *)makeUpdateEnv:(NSArray *)sObjects;
-(NSArray *)makeUpdateResult:(zkElement *)root;

-(NSString *)makeUpsertEnv:(NSString *)externalIDFieldName sObjects:(NSArray *)sObjects;
-(NSArray *)makeUpsertResult:(zkElement *)root;

-(NSString *)makeMergeEnv:(NSArray *)request;
-(NSArray *)makeMergeResult:(zkElement *)root;

-(NSString *)makeDeleteEnv:(NSArray *)ids;
-(NSArray *)makeDeleteResult:(zkElement *)root;

-(NSString *)makeUndeleteEnv:(NSArray *)ids;
-(NSArray *)makeUndeleteResult:(zkElement *)root;

-(NSString *)makeEmptyRecycleBinEnv:(NSArray *)ids;
-(NSArray *)makeEmptyRecycleBinResult:(zkElement *)root;

-(NSString *)makeRetrieveEnv:(NSString *)fieldList sObjectType:(NSString *)sObjectType ids:(NSArray *)ids;
-(NSDictionary *)makeRetrieveResult:(zkElement *)root;

-(NSString *)makeProcessEnv:(NSArray *)actions;
-(NSArray *)makeProcessResult:(zkElement *)root;

-(NSString *)makeConvertLeadEnv:(NSArray *)leadConverts;
-(NSArray *)makeConvertLeadResult:(zkElement *)root;

-(NSString *)makeLogoutEnv;
-(void)makeLogoutResult:(zkElement *)root;

-(NSString *)makeInvalidateSessionsEnv:(NSArray *)sessionIds;
-(NSArray *)makeInvalidateSessionsResult:(zkElement *)root;

-(NSString *)makeGetDeletedEnv:(NSString *)sObjectType startDate:(NSDate *)startDate endDate:(NSDate *)endDate;
-(ZKGetDeletedResult *)makeGetDeletedResult:(zkElement *)root;

-(NSString *)makeGetUpdatedEnv:(NSString *)sObjectType startDate:(NSDate *)startDate endDate:(NSDate *)endDate;
-(ZKGetUpdatedResult *)makeGetUpdatedResult:(zkElement *)root;

-(NSString *)makeQueryEnv:(NSString *)queryString;
-(ZKQueryResult *)makeQueryResult:(zkElement *)root;

-(NSString *)makeQueryAllEnv:(NSString *)queryString;
-(ZKQueryResult *)makeQueryAllResult:(zkElement *)root;

-(NSString *)makeQueryMoreEnv:(NSString *)queryLocator;
-(ZKQueryResult *)makeQueryMoreResult:(zkElement *)root;

-(NSString *)makeSearchEnv:(NSString *)searchString;
-(ZKSearchResult *)makeSearchResult:(zkElement *)root;

-(NSString *)makeGetServerTimestampEnv;
-(ZKGetServerTimestampResult *)makeGetServerTimestampResult:(zkElement *)root;

-(NSString *)makeSetPasswordEnv:(NSString *)userId password:(NSString *)password;
-(ZKSetPasswordResult *)makeSetPasswordResult:(zkElement *)root;

-(NSString *)makeChangeOwnPasswordEnv:(NSString *)oldPassword newPassword:(NSString *)newPassword;
-(ZKChangeOwnPasswordResult *)makeChangeOwnPasswordResult:(zkElement *)root;

-(NSString *)makeResetPasswordEnv:(NSString *)userId;
-(ZKResetPasswordResult *)makeResetPasswordResult:(zkElement *)root;

-(NSString *)makeGetUserInfoEnv;
-(ZKUserInfo *)makeGetUserInfoResult:(zkElement *)root;

-(NSString *)makeDeleteByExampleEnv:(NSArray *)sObjects;
-(NSArray *)makeDeleteByExampleResult:(zkElement *)root;

-(NSString *)makeSendEmailMessageEnv:(NSArray *)ids;
-(NSArray *)makeSendEmailMessageResult:(zkElement *)root;

-(NSString *)makeSendEmailEnv:(NSArray *)messages;
-(NSArray *)makeSendEmailResult:(zkElement *)root;

-(NSString *)makeRenderEmailTemplateEnv:(NSArray *)renderRequests;
-(NSArray *)makeRenderEmailTemplateResult:(zkElement *)root;

-(NSString *)makeRenderStoredEmailTemplateEnv:(ZKRenderStoredEmailTemplateRequest *)request;
-(ZKRenderStoredEmailTemplateResult *)makeRenderStoredEmailTemplateResult:(zkElement *)root;

-(NSString *)makePerformQuickActionsEnv:(NSArray *)quickActions;
-(NSArray *)makePerformQuickActionsResult:(zkElement *)root;

-(NSString *)makeDescribeQuickActionsEnv:(NSArray *)quickActions;
-(NSArray *)makeDescribeQuickActionsResult:(zkElement *)root;

-(NSString *)makeDescribeQuickActionsForRecordTypeEnv:(NSArray *)quickActions recordTypeId:(NSString *)recordTypeId;
-(NSArray *)makeDescribeQuickActionsForRecordTypeResult:(zkElement *)root;

-(NSString *)makeDescribeAvailableQuickActionsEnv:(NSString *)contextType;
-(NSArray *)makeDescribeAvailableQuickActionsResult:(zkElement *)root;

-(NSString *)makeRetrieveQuickActionTemplatesEnv:(NSArray *)quickActionNames contextId:(NSString *)contextId;
-(NSArray *)makeRetrieveQuickActionTemplatesResult:(zkElement *)root;

-(NSString *)makeRetrieveMassQuickActionTemplatesEnv:(NSString *)quickActionName contextIds:(NSArray *)contextIds;
-(NSArray *)makeRetrieveMassQuickActionTemplatesResult:(zkElement *)root;

-(NSString *)makeDescribeVisualForceEnv:(BOOL)includeAllDetails namespacePrefix:(NSString *)namespacePrefix;
-(ZKDescribeVisualForceResult *)makeDescribeVisualForceResult:(zkElement *)root;

-(NSString *)makeFindDuplicatesEnv:(NSArray *)sObjects;
-(NSArray *)makeFindDuplicatesResult:(zkElement *)root;

-(NSString *)makeFindDuplicatesByIdsEnv:(NSArray *)ids;
-(NSArray *)makeFindDuplicatesByIdsResult:(zkElement *)root;

-(NSString *)makeDescribeNounsEnv:(NSArray *)nouns onlyRenamed:(BOOL)onlyRenamed includeFields:(BOOL)includeFields;
-(NSArray *)makeDescribeNounsResult:(zkElement *)root;

@end
