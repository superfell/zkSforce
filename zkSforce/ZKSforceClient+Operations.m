// Copyright (c) 2013 Simon Fell
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

#import "ZKSforceClient+Operations.h"
#import "ZKPartnerEnvelope.h"
#import "ZKChangeOwnPasswordResult.h"
#import "ZKDataCategoryGroupSobjectTypePair.h"
#import "ZKDeleteByExampleResult.h"
#import "ZKDeleteResult.h"
#import "ZKDescribeAppMenuResult.h"
#import "ZKDescribeApprovalLayoutResult.h"
#import "ZKDescribeAvailableQuickActionResult.h"
#import "ZKDescribeCompactLayout.h"
#import "ZKDescribeCompactLayoutsResult.h"
#import "ZKDescribeDataCategoryGroupResult.h"
#import "ZKDescribeDataCategoryGroupStructureResult.h"
#import "ZKDescribeDataCategoryMappingResult.h"
#import "ZKDescribeGlobalSObject.h"
#import "ZKDescribeGlobalTheme.h"
#import "ZKDescribeLayoutResult.h"
#import "ZKDescribeNounResult.h"
#import "ZKDescribePathAssistantsResult.h"
#import "ZKDescribeQuickActionResult.h"
#import "ZKDescribeSObject.h"
#import "ZKDescribeSearchLayoutResult.h"
#import "ZKDescribeSearchScopeOrderResult.h"
#import "ZKDescribeSearchableEntityResult.h"
#import "ZKDescribeSoftphoneLayoutResult.h"
#import "ZKDescribeSoqlListViewResult.h"
#import "ZKDescribeSoqlListViewsRequest.h"
#import "ZKDescribeTab.h"
#import "ZKDescribeTabSetResult.h"
#import "ZKDescribeThemeResult.h"
#import "ZKDescribeVisualForceResult.h"
#import "ZKEmail.h"
#import "ZKEmptyRecycleBinResult.h"
#import "ZKExecuteListViewRequest.h"
#import "ZKExecuteListViewResult.h"
#import "ZKFindDuplicatesResult.h"
#import "ZKGetDeletedResult.h"
#import "ZKGetServerTimestampResult.h"
#import "ZKGetUpdatedResult.h"
#import "ZKInvalidateSessionsResult.h"
#import "ZKKnowledgeSettings.h"
#import "ZKLeadConvert.h"
#import "ZKLeadConvertResult.h"
#import "ZKMergeRequest.h"
#import "ZKMergeResult.h"
#import "ZKPerformQuickActionRequest.h"
#import "ZKPerformQuickActionResult.h"
#import "ZKProcessRequest.h"
#import "ZKProcessResult.h"
#import "zkQueryResult.h"
#import "ZKQuickActionTemplateResult.h"
#import "ZKRenderEmailTemplateRequest.h"
#import "ZKRenderEmailTemplateResult.h"
#import "ZKRenderStoredEmailTemplateRequest.h"
#import "ZKRenderStoredEmailTemplateResult.h"
#import "ZKResetPasswordResult.h"
#import "zkSObject.h"
#import "ZKSendEmailResult.h"
#import "ZKSetPasswordResult.h"
#import "ZKUndeleteResult.h"
#import "ZKUpsertResult.h"
#import "ZKUserInfo.h"

@implementation ZKSforceClient (Operations)

/** Describe an sObject */
-(ZKDescribeSObject *)describeSObject:(NSString *)sObjectType {
	if (!self.authSource) return nil;
	[self checkSession];
	ZKDescribeSObject *shortcut = [self preHook_describeSObject:sObjectType];
	if (shortcut != nil) return shortcut;
	NSString *payload = [self makeDescribeSObjectEnv:sObjectType];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	ZKDescribeSObject *result = [self makeDescribeSObjectResult:root];
	result = [self postHook_describeSObject:result];
	return result;
}

/** Describe multiple sObjects (upto 100) */
-(NSArray *)describeSObjects:(NSArray *)sObjectType {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeDescribeSObjectsEnv:sObjectType];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	NSArray *result = [self makeDescribeSObjectsResult:root];
	return result;
}

/** Describe the Global state */
-(NSArray *)describeGlobal {
	if (!self.authSource) return nil;
	[self checkSession];
	NSArray *shortcut = [self preHook_describeGlobal];
	if (shortcut != nil) return shortcut;
	NSString *payload = [self makeDescribeGlobalEnv];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	NSArray *result = [self makeDescribeGlobalResult:root];
	result = [self postHook_describeGlobal:result];
	return result;
}

/** Describe all the data category groups available for a given set of types */
-(NSArray *)describeDataCategoryGroups:(NSArray *)sObjectType {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeDescribeDataCategoryGroupsEnv:sObjectType];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	NSArray *result = [self makeDescribeDataCategoryGroupsResult:root];
	return result;
}

/** Describe the data category group structures for a given set of pair of types and data category group name */
-(NSArray *)describeDataCategoryGroupStructures:(NSArray *)pairs topCategoriesOnly:(BOOL)topCategoriesOnly {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeDescribeDataCategoryGroupStructuresEnv:pairs topCategoriesOnly:topCategoriesOnly];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	NSArray *result = [self makeDescribeDataCategoryGroupStructuresResult:root];
	return result;
}

/** Describe your Data Category Mappings. */
-(NSArray *)describeDataCategoryMappings {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeDescribeDataCategoryMappingsEnv];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	NSArray *result = [self makeDescribeDataCategoryMappingsResult:root];
	return result;
}

/** Describes your Knowledge settings, such as if knowledgeEnabled is on or off, its default language and supported languages */
-(ZKKnowledgeSettings *)describeKnowledgeSettings {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeDescribeKnowledgeSettingsEnv];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	ZKKnowledgeSettings *result = [self makeDescribeKnowledgeSettingsResult:root];
	return result;
}

/** Describe the items in an AppMenu */
-(ZKDescribeAppMenuResult *)describeAppMenu:(NSString *)appMenuType networkId:(NSString *)networkId {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeDescribeAppMenuEnv:appMenuType networkId:networkId];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	ZKDescribeAppMenuResult *result = [self makeDescribeAppMenuResult:root];
	return result;
}

/** Describe Gloal and Themes */
-(ZKDescribeGlobalTheme *)describeGlobalTheme {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeDescribeGlobalThemeEnv];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	ZKDescribeGlobalTheme *result = [self makeDescribeGlobalThemeResult:root];
	return result;
}

/** Describe Themes */
-(ZKDescribeThemeResult *)describeTheme:(NSArray *)sobjectType {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeDescribeThemeEnv:sobjectType];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	ZKDescribeThemeResult *result = [self makeDescribeThemeResult:root];
	return result;
}

/** Describe the layout of the given sObject or the given actionable global page. */
-(ZKDescribeLayoutResult *)describeLayout:(NSString *)sObjectType layoutName:(NSString *)layoutName recordTypeIds:(NSArray *)recordTypeIds {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeDescribeLayoutEnv:sObjectType layoutName:layoutName recordTypeIds:recordTypeIds];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	ZKDescribeLayoutResult *result = [self makeDescribeLayoutResult:root];
	return result;
}

/** Describe the layout of the SoftPhone */
-(ZKDescribeSoftphoneLayoutResult *)describeSoftphoneLayout {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeDescribeSoftphoneLayoutEnv];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	ZKDescribeSoftphoneLayoutResult *result = [self makeDescribeSoftphoneLayoutResult:root];
	return result;
}

/** Describe the search view of an sObject */
-(NSArray *)describeSearchLayouts:(NSArray *)sObjectType {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeDescribeSearchLayoutsEnv:sObjectType];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	NSArray *result = [self makeDescribeSearchLayoutsResult:root];
	return result;
}

/** Describe a list of entity names that reflects the current user's searchable entities */
-(NSArray *)describeSearchableEntities:(BOOL)includeOnlyEntitiesWithTabs {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeDescribeSearchableEntitiesEnv:includeOnlyEntitiesWithTabs];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	NSArray *result = [self makeDescribeSearchableEntitiesResult:root];
	return result;
}

/** Describe a list of objects representing the order and scope of objects on a users search result page */
-(NSArray *)describeSearchScopeOrder:(BOOL)includeRealTimeEntities {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeDescribeSearchScopeOrderEnv:includeRealTimeEntities];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	NSArray *result = [self makeDescribeSearchScopeOrderResult:root];
	return result;
}

/** Describe the compact layouts of the given sObject */
-(ZKDescribeCompactLayoutsResult *)describeCompactLayouts:(NSString *)sObjectType recordTypeIds:(NSArray *)recordTypeIds {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeDescribeCompactLayoutsEnv:sObjectType recordTypeIds:recordTypeIds];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	ZKDescribeCompactLayoutsResult *result = [self makeDescribeCompactLayoutsResult:root];
	return result;
}

/** Describe the Path Assistants for the given sObject and optionally RecordTypes */
-(ZKDescribePathAssistantsResult *)describePathAssistants:(NSString *)sObjectType picklistValue:(NSString *)picklistValue recordTypeIds:(NSArray *)recordTypeIds {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeDescribePathAssistantsEnv:sObjectType picklistValue:picklistValue recordTypeIds:recordTypeIds];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	ZKDescribePathAssistantsResult *result = [self makeDescribePathAssistantsResult:root];
	return result;
}

/** Describe the approval layouts of the given sObject */
-(ZKDescribeApprovalLayoutResult *)describeApprovalLayout:(NSString *)sObjectType approvalProcessNames:(NSArray *)approvalProcessNames {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeDescribeApprovalLayoutEnv:sObjectType approvalProcessNames:approvalProcessNames];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	ZKDescribeApprovalLayoutResult *result = [self makeDescribeApprovalLayoutResult:root];
	return result;
}

/** Describe the ListViews as SOQL metadata for the generation of SOQL. */
-(ZKDescribeSoqlListViewResult *)describeSoqlListViews:(ZKDescribeSoqlListViewsRequest *)request {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeDescribeSoqlListViewsEnv:request];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	ZKDescribeSoqlListViewResult *result = [self makeDescribeSoqlListViewsResult:root];
	return result;
}

/** Execute the specified list view and return the presentation-ready results. */
-(ZKExecuteListViewResult *)executeListView:(ZKExecuteListViewRequest *)request {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeExecuteListViewEnv:request];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	ZKExecuteListViewResult *result = [self makeExecuteListViewResult:root];
	return result;
}

/** Describe the ListViews of a SObject as SOQL metadata for the generation of SOQL. */
-(ZKDescribeSoqlListViewResult *)describeSObjectListViews:(NSString *)sObjectType recentsOnly:(BOOL)recentsOnly isSoqlCompatible:(NSString *)isSoqlCompatible limit:(NSInteger)limit offset:(NSInteger)offset {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeDescribeSObjectListViewsEnv:sObjectType recentsOnly:recentsOnly isSoqlCompatible:isSoqlCompatible limit:limit offset:offset];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	ZKDescribeSoqlListViewResult *result = [self makeDescribeSObjectListViewsResult:root];
	return result;
}

/** Describe the tabs that appear on a users page */
-(NSArray *)describeTabs {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeDescribeTabsEnv];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	NSArray *result = [self makeDescribeTabsResult:root];
	return result;
}

/** Describe all tabs available to a user */
-(NSArray *)describeAllTabs {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeDescribeAllTabsEnv];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	NSArray *result = [self makeDescribeAllTabsResult:root];
	return result;
}

/** Describe the primary compact layouts for the sObjects requested */
-(NSArray *)describePrimaryCompactLayouts:(NSArray *)sObjectTypes {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeDescribePrimaryCompactLayoutsEnv:sObjectTypes];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	NSArray *result = [self makeDescribePrimaryCompactLayoutsResult:root];
	return result;
}

/** Update or insert a set of sObjects based on object id */
-(NSArray *)upsert:(NSString *)externalIDFieldName sObjects:(NSArray *)sObjects {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeUpsertEnv:externalIDFieldName sObjects:sObjects];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	NSArray *result = [self makeUpsertResult:root];
	return result;
}

/** Merge and update a set of sObjects based on object id */
-(NSArray *)merge:(NSArray *)request {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeMergeEnv:request];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	NSArray *result = [self makeMergeResult:root];
	return result;
}

/** Delete a set of sObjects */
-(NSArray *)delete:(NSArray *)ids {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeDeleteEnv:ids];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	NSArray *result = [self makeDeleteResult:root];
	return result;
}

/** Undelete a set of sObjects */
-(NSArray *)undelete:(NSArray *)ids {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeUndeleteEnv:ids];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	NSArray *result = [self makeUndeleteResult:root];
	return result;
}

/** Empty a set of sObjects from the recycle bin */
-(NSArray *)emptyRecycleBin:(NSArray *)ids {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeEmptyRecycleBinEnv:ids];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	NSArray *result = [self makeEmptyRecycleBinResult:root];
	return result;
}

/** Get a set of sObjects */
-(NSDictionary *)retrieve:(NSString *)fieldList sObjectType:(NSString *)sObjectType ids:(NSArray *)ids {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeRetrieveEnv:fieldList sObjectType:sObjectType ids:ids];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	NSDictionary *result = [self makeRetrieveResult:root];
	return result;
}

/** Submit an entity to a workflow process or process a workitem */
-(NSArray *)process:(NSArray *)actions {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeProcessEnv:actions];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	NSArray *result = [self makeProcessResult:root];
	return result;
}

/** convert a set of leads */
-(NSArray *)convertLead:(NSArray *)leadConverts {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeConvertLeadEnv:leadConverts];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	NSArray *result = [self makeConvertLeadResult:root];
	return result;
}

/** Logout the current user, invalidating the current session. */
-(void)logout {
	if (!self.authSource) return ;
	[self checkSession];
	NSString *payload = [self makeLogoutEnv];
	[self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
}
/** Logs out and invalidates session ids */
-(NSArray *)invalidateSessions:(NSArray *)sessionIds {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeInvalidateSessionsEnv:sessionIds];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	NSArray *result = [self makeInvalidateSessionsResult:root];
	return result;
}

/** Get the IDs for deleted sObjects */
-(ZKGetDeletedResult *)getDeleted:(NSString *)sObjectType startDate:(NSDate *)startDate endDate:(NSDate *)endDate {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeGetDeletedEnv:sObjectType startDate:startDate endDate:endDate];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	ZKGetDeletedResult *result = [self makeGetDeletedResult:root];
	return result;
}

/** Get the IDs for updated sObjects */
-(ZKGetUpdatedResult *)getUpdated:(NSString *)sObjectType startDate:(NSDate *)startDate endDate:(NSDate *)endDate {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeGetUpdatedEnv:sObjectType startDate:startDate endDate:endDate];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	ZKGetUpdatedResult *result = [self makeGetUpdatedResult:root];
	return result;
}

/** Create a Query Cursor */
-(ZKQueryResult *)query:(NSString *)queryString {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeQueryEnv:queryString];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	ZKQueryResult *result = [self makeQueryResult:root];
	return result;
}

/** Create a Query Cursor, including deleted sObjects */
-(ZKQueryResult *)queryAll:(NSString *)queryString {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeQueryAllEnv:queryString];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	ZKQueryResult *result = [self makeQueryAllResult:root];
	return result;
}

/** Gets the next batch of sObjects from a query */
-(ZKQueryResult *)queryMore:(NSString *)queryLocator {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeQueryMoreEnv:queryLocator];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	ZKQueryResult *result = [self makeQueryMoreResult:root];
	return result;
}

/** Gets server timestamp */
-(ZKGetServerTimestampResult *)getServerTimestamp {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeGetServerTimestampEnv];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	ZKGetServerTimestampResult *result = [self makeGetServerTimestampResult:root];
	return result;
}

/** Set a user's password */
-(ZKSetPasswordResult *)setPassword:(NSString *)userId password:(NSString *)password {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeSetPasswordEnv:userId password:password];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	ZKSetPasswordResult *result = [self makeSetPasswordResult:root];
	return result;
}

/** Change the current user's password */
-(ZKChangeOwnPasswordResult *)changeOwnPassword:(NSString *)oldPassword newPassword:(NSString *)newPassword {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeChangeOwnPasswordEnv:oldPassword newPassword:newPassword];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	ZKChangeOwnPasswordResult *result = [self makeChangeOwnPasswordResult:root];
	return result;
}

/** Reset a user's password */
-(ZKResetPasswordResult *)resetPassword:(NSString *)userId {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeResetPasswordEnv:userId];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	ZKResetPasswordResult *result = [self makeResetPasswordResult:root];
	return result;
}

/** Returns standard information relevant to the current user */
-(ZKUserInfo *)getUserInfo {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeGetUserInfoEnv];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	ZKUserInfo *result = [self makeGetUserInfoResult:root];
	return result;
}

/** Delete a set of sObjects by example. The passed SOBject is a template for the object to delete */
-(NSArray *)deleteByExample:(NSArray *)sObjects {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeDeleteByExampleEnv:sObjects];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	NSArray *result = [self makeDeleteByExampleResult:root];
	return result;
}

/** Send existing draft EmailMessage */
-(NSArray *)sendEmailMessage:(NSArray *)ids {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeSendEmailMessageEnv:ids];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	NSArray *result = [self makeSendEmailMessageResult:root];
	return result;
}

/** Send outbound email */
-(NSArray *)sendEmail:(NSArray *)messages {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeSendEmailEnv:messages];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	NSArray *result = [self makeSendEmailResult:root];
	return result;
}

/** Perform a template merge on one or more blocks of text. */
-(NSArray *)renderEmailTemplate:(NSArray *)renderRequests {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeRenderEmailTemplateEnv:renderRequests];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	NSArray *result = [self makeRenderEmailTemplateResult:root];
	return result;
}

/** Perform a template merge using an email template stored in the database. */
-(ZKRenderStoredEmailTemplateResult *)renderStoredEmailTemplate:(ZKRenderStoredEmailTemplateRequest *)request {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeRenderStoredEmailTemplateEnv:request];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	ZKRenderStoredEmailTemplateResult *result = [self makeRenderStoredEmailTemplateResult:root];
	return result;
}

/** Perform a series of predefined actions such as quick create or log a task */
-(NSArray *)performQuickActions:(NSArray *)quickActions {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makePerformQuickActionsEnv:quickActions];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	NSArray *result = [self makePerformQuickActionsResult:root];
	return result;
}

/** Describe the details of a series of quick actions */
-(NSArray *)describeQuickActions:(NSArray *)quickActions {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeDescribeQuickActionsEnv:quickActions];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	NSArray *result = [self makeDescribeQuickActionsResult:root];
	return result;
}

/** Describe the details of a series of quick actions in context of requested recordType id for Update actions */
-(NSArray *)describeQuickActionsForRecordType:(NSArray *)quickActions recordTypeId:(NSString *)recordTypeId {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeDescribeQuickActionsForRecordTypeEnv:quickActions recordTypeId:recordTypeId];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	NSArray *result = [self makeDescribeQuickActionsForRecordTypeResult:root];
	return result;
}

/** Describe the details of a series of quick actions available for the given contextType */
-(NSArray *)describeAvailableQuickActions:(NSString *)contextType {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeDescribeAvailableQuickActionsEnv:contextType];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	NSArray *result = [self makeDescribeAvailableQuickActionsResult:root];
	return result;
}

/** Retrieve the template sobjects, if appropriate, for the given quick action names in a given context */
-(NSArray *)retrieveQuickActionTemplates:(NSArray *)quickActionNames contextId:(NSString *)contextId {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeRetrieveQuickActionTemplatesEnv:quickActionNames contextId:contextId];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	NSArray *result = [self makeRetrieveQuickActionTemplatesResult:root];
	return result;
}

/** Retrieve the template sobjects, if appropriate, for the given quick action names in a given contexts when used a mass quick action */
-(NSArray *)retrieveMassQuickActionTemplates:(NSString *)quickActionName contextIds:(NSArray *)contextIds {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeRetrieveMassQuickActionTemplatesEnv:quickActionName contextIds:contextIds];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	NSArray *result = [self makeRetrieveMassQuickActionTemplatesResult:root];
	return result;
}

/** Describe visualforce for an org */
-(ZKDescribeVisualForceResult *)describeVisualForce:(BOOL)includeAllDetails namespacePrefix:(NSString *)namespacePrefix {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeDescribeVisualForceEnv:includeAllDetails namespacePrefix:namespacePrefix];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	ZKDescribeVisualForceResult *result = [self makeDescribeVisualForceResult:root];
	return result;
}

/** Find duplicates for a set of sObjects */
-(NSArray *)findDuplicates:(NSArray *)sObjects {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeFindDuplicatesEnv:sObjects];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	NSArray *result = [self makeFindDuplicatesResult:root];
	return result;
}

/** Find duplicates for a set of ids */
-(NSArray *)findDuplicatesByIds:(NSArray *)ids {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeFindDuplicatesByIdsEnv:ids];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	NSArray *result = [self makeFindDuplicatesByIdsResult:root];
	return result;
}

/** Return the renameable nouns from the server for use in presentation using the salesforce grammar engine */
-(NSArray *)describeNouns:(NSArray *)nouns onlyRenamed:(BOOL)onlyRenamed includeFields:(BOOL)includeFields {
	if (!self.authSource) return nil;
	[self checkSession];
	NSString *payload = [self makeDescribeNounsEnv:nouns onlyRenamed:onlyRenamed includeFields:includeFields];
	zkElement *root = [self sendRequest:payload name:NSStringFromSelector(_cmd) returnRoot:YES];
	NSArray *result = [self makeDescribeNounsResult:root];
	return result;
}

@end
