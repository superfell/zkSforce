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

#import "zkSforceClient.h"

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
@class ZKQueryResult;
@class ZKRenderStoredEmailTemplateRequest;
@class ZKRenderStoredEmailTemplateResult;
@class ZKResetPasswordResult;
@class ZKSetPasswordResult;
@class ZKUserInfo;

@interface ZKSforceClient (Operations)

/** Describe an sObject */
-(ZKDescribeSObject *)describeSObject:(NSString *)sObjectType;

/** Describe multiple sObjects (upto 100) */
-(NSArray *)describeSObjects:(NSArray *)sObjectType;

/** Describe the Global state */
-(NSArray *)describeGlobal;

/** Describe all the data category groups available for a given set of types */
-(NSArray *)describeDataCategoryGroups:(NSArray *)sObjectType;

/** Describe the data category group structures for a given set of pair of types and data category group name */
-(NSArray *)describeDataCategoryGroupStructures:(NSArray *)pairs topCategoriesOnly:(BOOL)topCategoriesOnly;

/** Describe your Data Category Mappings. */
-(NSArray *)describeDataCategoryMappings;

/** Describes your Knowledge settings, such as if knowledgeEnabled is on or off, its default language and supported languages */
-(ZKKnowledgeSettings *)describeKnowledgeSettings;

/** Describe the items in an AppMenu */
-(ZKDescribeAppMenuResult *)describeAppMenu:(NSString *)appMenuType networkId:(NSString *)networkId;

/** Describe Gloal and Themes */
-(ZKDescribeGlobalTheme *)describeGlobalTheme;

/** Describe Themes */
-(ZKDescribeThemeResult *)describeTheme:(NSArray *)sobjectType;

/** Describe the layout of the given sObject or the given actionable global page. */
-(ZKDescribeLayoutResult *)describeLayout:(NSString *)sObjectType layoutName:(NSString *)layoutName recordTypeIds:(NSArray *)recordTypeIds;

/** Describe the layout of the SoftPhone */
-(ZKDescribeSoftphoneLayoutResult *)describeSoftphoneLayout;

/** Describe the search view of an sObject */
-(NSArray *)describeSearchLayouts:(NSArray *)sObjectType;

/** Describe a list of entity names that reflects the current user's searchable entities */
-(NSArray *)describeSearchableEntities:(BOOL)includeOnlyEntitiesWithTabs;

/** Describe a list of objects representing the order and scope of objects on a users search result page */
-(NSArray *)describeSearchScopeOrder:(BOOL)includeRealTimeEntities;

/** Describe the compact layouts of the given sObject */
-(ZKDescribeCompactLayoutsResult *)describeCompactLayouts:(NSString *)sObjectType recordTypeIds:(NSArray *)recordTypeIds;

/** Describe the Path Assistants for the given sObject and optionally RecordTypes */
-(ZKDescribePathAssistantsResult *)describePathAssistants:(NSString *)sObjectType picklistValue:(NSString *)picklistValue recordTypeIds:(NSArray *)recordTypeIds;

/** Describe the approval layouts of the given sObject */
-(ZKDescribeApprovalLayoutResult *)describeApprovalLayout:(NSString *)sObjectType approvalProcessNames:(NSArray *)approvalProcessNames;

/** Describe the ListViews as SOQL metadata for the generation of SOQL. */
-(ZKDescribeSoqlListViewResult *)describeSoqlListViews:(ZKDescribeSoqlListViewsRequest *)request;

/** Execute the specified list view and return the presentation-ready results. */
-(ZKExecuteListViewResult *)executeListView:(ZKExecuteListViewRequest *)request;

/** Describe the ListViews of a SObject as SOQL metadata for the generation of SOQL. */
-(ZKDescribeSoqlListViewResult *)describeSObjectListViews:(NSString *)sObjectType recentsOnly:(BOOL)recentsOnly isSoqlCompatible:(NSString *)isSoqlCompatible limit:(NSInteger)limit offset:(NSInteger)offset;

/** Describe the tabs that appear on a users page */
-(NSArray *)describeTabs;

/** Describe all tabs available to a user */
-(NSArray *)describeAllTabs;

/** Describe the primary compact layouts for the sObjects requested */
-(NSArray *)describePrimaryCompactLayouts:(NSArray *)sObjectTypes;

/** Update or insert a set of sObjects based on object id */
-(NSArray *)upsert:(NSString *)externalIDFieldName sObjects:(NSArray *)sObjects;

/** Merge and update a set of sObjects based on object id */
-(NSArray *)merge:(NSArray *)request;

/** Delete a set of sObjects */
-(NSArray *)delete:(NSArray *)ids;

/** Undelete a set of sObjects */
-(NSArray *)undelete:(NSArray *)ids;

/** Empty a set of sObjects from the recycle bin */
-(NSArray *)emptyRecycleBin:(NSArray *)ids;

/** Get a set of sObjects */
-(NSDictionary *)retrieve:(NSString *)fieldList sObjectType:(NSString *)sObjectType ids:(NSArray *)ids;

/** Submit an entity to a workflow process or process a workitem */
-(NSArray *)process:(NSArray *)actions;

/** convert a set of leads */
-(NSArray *)convertLead:(NSArray *)leadConverts;

/** Logout the current user, invalidating the current session. */
-(void)logout;

/** Logs out and invalidates session ids */
-(NSArray *)invalidateSessions:(NSArray *)sessionIds;

/** Get the IDs for deleted sObjects */
-(ZKGetDeletedResult *)getDeleted:(NSString *)sObjectType startDate:(NSDate *)startDate endDate:(NSDate *)endDate;

/** Get the IDs for updated sObjects */
-(ZKGetUpdatedResult *)getUpdated:(NSString *)sObjectType startDate:(NSDate *)startDate endDate:(NSDate *)endDate;

/** Create a Query Cursor */
-(ZKQueryResult *)query:(NSString *)queryString;

/** Create a Query Cursor, including deleted sObjects */
-(ZKQueryResult *)queryAll:(NSString *)queryString;

/** Gets the next batch of sObjects from a query */
-(ZKQueryResult *)queryMore:(NSString *)queryLocator;

/** Gets server timestamp */
-(ZKGetServerTimestampResult *)getServerTimestamp;

/** Set a user's password */
-(ZKSetPasswordResult *)setPassword:(NSString *)userId password:(NSString *)password;

/** Change the current user's password */
-(ZKChangeOwnPasswordResult *)changeOwnPassword:(NSString *)oldPassword newPassword:(NSString *)newPassword;

/** Reset a user's password */
-(ZKResetPasswordResult *)resetPassword:(NSString *)userId;

/** Returns standard information relevant to the current user */
-(ZKUserInfo *)getUserInfo;

/** Delete a set of sObjects by example. The passed SOBject is a template for the object to delete */
-(NSArray *)deleteByExample:(NSArray *)sObjects;

/** Send existing draft EmailMessage */
-(NSArray *)sendEmailMessage:(NSArray *)ids;

/** Send outbound email */
-(NSArray *)sendEmail:(NSArray *)messages;

/** Perform a template merge on one or more blocks of text. */
-(NSArray *)renderEmailTemplate:(NSArray *)renderRequests;

/** Perform a template merge using an email template stored in the database. */
-(ZKRenderStoredEmailTemplateResult *)renderStoredEmailTemplate:(ZKRenderStoredEmailTemplateRequest *)request;

/** Perform a series of predefined actions such as quick create or log a task */
-(NSArray *)performQuickActions:(NSArray *)quickActions;

/** Describe the details of a series of quick actions */
-(NSArray *)describeQuickActions:(NSArray *)quickActions;

/** Describe the details of a series of quick actions in context of requested recordType id for Update actions */
-(NSArray *)describeQuickActionsForRecordType:(NSArray *)quickActions recordTypeId:(NSString *)recordTypeId;

/** Describe the details of a series of quick actions available for the given contextType */
-(NSArray *)describeAvailableQuickActions:(NSString *)contextType;

/** Retrieve the template sobjects, if appropriate, for the given quick action names in a given context */
-(NSArray *)retrieveQuickActionTemplates:(NSArray *)quickActionNames contextId:(NSString *)contextId;

/** Retrieve the template sobjects, if appropriate, for the given quick action names in a given contexts when used a mass quick action */
-(NSArray *)retrieveMassQuickActionTemplates:(NSString *)quickActionName contextIds:(NSArray *)contextIds;

/** Describe visualforce for an org */
-(ZKDescribeVisualForceResult *)describeVisualForce:(BOOL)includeAllDetails namespacePrefix:(NSString *)namespacePrefix;

/** Find duplicates for a set of sObjects */
-(NSArray *)findDuplicates:(NSArray *)sObjects;

/** Find duplicates for a set of ids */
-(NSArray *)findDuplicatesByIds:(NSArray *)ids;

/** Return the renameable nouns from the server for use in presentation using the salesforce grammar engine */
-(NSArray *)describeNouns:(NSArray *)nouns onlyRenamed:(BOOL)onlyRenamed includeFields:(BOOL)includeFields;

@end
