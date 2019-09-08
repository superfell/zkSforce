// Copyright (c) 2011,2013,2019 Jonathan Hersh, Simon Fell
//
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the "Software"),
// to deal in the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following conditions
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

#import "ZKSforceBaseClient.h"
#import "ZKBlockTypes.h"

@interface ZKSforceBaseClient (AsyncOperations)

/** @return true if we've performed a login request and it succeeded. */
@property (readonly) BOOL loggedIn;

/** Login to the Salesforce.com SOAP Api */
-(void) performLogin:(NSString *)username password:(NSString *)password
           failBlock:(ZKFailWithErrorBlock)failBlock
       completeBlock:(ZKCompleteLoginResultBlock)completeBlock;

/** Describe an sObject */
-(void) performDescribeSObject:(NSString *)sObjectType
                     failBlock:(ZKFailWithErrorBlock)failBlock
                 completeBlock:(ZKCompleteDescribeSObjectBlock)completeBlock;

/** Describe multiple sObjects (upto 100) */
-(void) performDescribeSObjects:(NSArray *)sObjectType
                      failBlock:(ZKFailWithErrorBlock)failBlock
                  completeBlock:(ZKCompleteArrayBlock)completeBlock;

/** Describe the Global state */
-(void) performDescribeGlobalWithFailBlock:(ZKFailWithErrorBlock)failBlock
                completeBlock:(ZKCompleteArrayBlock)completeBlock;

/** Describe all the data category groups available for a given set of types */
-(void) performDescribeDataCategoryGroups:(NSArray *)sObjectType
                                failBlock:(ZKFailWithErrorBlock)failBlock
                            completeBlock:(ZKCompleteArrayBlock)completeBlock;

/** Describe the data category group structures for a given set of pair of types and data category group name */
-(void) performDescribeDataCategoryGroupStructures:(NSArray *)pairs topCategoriesOnly:(BOOL)topCategoriesOnly
                                         failBlock:(ZKFailWithErrorBlock)failBlock
                                     completeBlock:(ZKCompleteArrayBlock)completeBlock;

/** Describe your Data Category Mappings. */
-(void) performDescribeDataCategoryMappingsWithFailBlock:(ZKFailWithErrorBlock)failBlock
                              completeBlock:(ZKCompleteArrayBlock)completeBlock;

/** Describes your Knowledge settings, such as if knowledgeEnabled is on or off, its default language and supported languages */
-(void) performDescribeKnowledgeSettingsWithFailBlock:(ZKFailWithErrorBlock)failBlock
                           completeBlock:(ZKCompleteKnowledgeSettingsBlock)completeBlock;

/** Describe the items in an AppMenu */
-(void) performDescribeAppMenu:(NSString *)appMenuType networkId:(NSString *)networkId
                     failBlock:(ZKFailWithErrorBlock)failBlock
                 completeBlock:(ZKCompleteDescribeAppMenuResultBlock)completeBlock;

/** Describe Gloal and Themes */
-(void) performDescribeGlobalThemeWithFailBlock:(ZKFailWithErrorBlock)failBlock
                     completeBlock:(ZKCompleteDescribeGlobalThemeBlock)completeBlock;

/** Describe Themes */
-(void) performDescribeTheme:(NSArray *)sobjectType
                   failBlock:(ZKFailWithErrorBlock)failBlock
               completeBlock:(ZKCompleteDescribeThemeResultBlock)completeBlock;

/** Describe the layout of the given sObject or the given actionable global page. */
-(void) performDescribeLayout:(NSString *)sObjectType layoutName:(NSString *)layoutName recordTypeIds:(NSArray *)recordTypeIds
                    failBlock:(ZKFailWithErrorBlock)failBlock
                completeBlock:(ZKCompleteDescribeLayoutResultBlock)completeBlock;

/** Describe the layout of the SoftPhone */
-(void) performDescribeSoftphoneLayoutWithFailBlock:(ZKFailWithErrorBlock)failBlock
                         completeBlock:(ZKCompleteDescribeSoftphoneLayoutResultBlock)completeBlock;

/** Describe the search view of an sObject */
-(void) performDescribeSearchLayouts:(NSArray *)sObjectType
                           failBlock:(ZKFailWithErrorBlock)failBlock
                       completeBlock:(ZKCompleteArrayBlock)completeBlock;

/** Describe a list of entity names that reflects the current user's searchable entities */
-(void) performDescribeSearchableEntities:(BOOL)includeOnlyEntitiesWithTabs
                                failBlock:(ZKFailWithErrorBlock)failBlock
                            completeBlock:(ZKCompleteArrayBlock)completeBlock;

/** Describe a list of objects representing the order and scope of objects on a users search result page */
-(void) performDescribeSearchScopeOrder:(BOOL)includeRealTimeEntities
                              failBlock:(ZKFailWithErrorBlock)failBlock
                          completeBlock:(ZKCompleteArrayBlock)completeBlock;

/** Describe the compact layouts of the given sObject */
-(void) performDescribeCompactLayouts:(NSString *)sObjectType recordTypeIds:(NSArray *)recordTypeIds
                            failBlock:(ZKFailWithErrorBlock)failBlock
                        completeBlock:(ZKCompleteDescribeCompactLayoutsResultBlock)completeBlock;

/** Describe the Path Assistants for the given sObject and optionally RecordTypes */
-(void) performDescribePathAssistants:(NSString *)sObjectType picklistValue:(NSString *)picklistValue recordTypeIds:(NSArray *)recordTypeIds
                            failBlock:(ZKFailWithErrorBlock)failBlock
                        completeBlock:(ZKCompleteDescribePathAssistantsResultBlock)completeBlock;

/** Describe the approval layouts of the given sObject */
-(void) performDescribeApprovalLayout:(NSString *)sObjectType approvalProcessNames:(NSArray *)approvalProcessNames
                            failBlock:(ZKFailWithErrorBlock)failBlock
                        completeBlock:(ZKCompleteDescribeApprovalLayoutResultBlock)completeBlock;

/** Describe the ListViews as SOQL metadata for the generation of SOQL. */
-(void) performDescribeSoqlListViews:(ZKDescribeSoqlListViewsRequest *)request
                           failBlock:(ZKFailWithErrorBlock)failBlock
                       completeBlock:(ZKCompleteDescribeSoqlListViewResultBlock)completeBlock;

/** Execute the specified list view and return the presentation-ready results. */
-(void) performExecuteListView:(ZKExecuteListViewRequest *)request
                     failBlock:(ZKFailWithErrorBlock)failBlock
                 completeBlock:(ZKCompleteExecuteListViewResultBlock)completeBlock;

/** Describe the ListViews of a SObject as SOQL metadata for the generation of SOQL. */
-(void) performDescribeSObjectListViews:(NSString *)sObjectType recentsOnly:(BOOL)recentsOnly isSoqlCompatible:(NSString *)isSoqlCompatible limit:(NSInteger)limit offset:(NSInteger)offset
                              failBlock:(ZKFailWithErrorBlock)failBlock
                          completeBlock:(ZKCompleteDescribeSoqlListViewResultBlock)completeBlock;

/** Describe the tabs that appear on a users page */
-(void) performDescribeTabsWithFailBlock:(ZKFailWithErrorBlock)failBlock
              completeBlock:(ZKCompleteArrayBlock)completeBlock;

/** Describe all tabs available to a user */
-(void) performDescribeAllTabsWithFailBlock:(ZKFailWithErrorBlock)failBlock
                 completeBlock:(ZKCompleteArrayBlock)completeBlock;

/** Describe the primary compact layouts for the sObjects requested */
-(void) performDescribePrimaryCompactLayouts:(NSArray *)sObjectTypes
                                   failBlock:(ZKFailWithErrorBlock)failBlock
                               completeBlock:(ZKCompleteArrayBlock)completeBlock;

/** Create a set of new sObjects */
-(void) performCreate:(NSArray *)sObjects
            failBlock:(ZKFailWithErrorBlock)failBlock
        completeBlock:(ZKCompleteArrayBlock)completeBlock;

/** Update a set of sObjects */
-(void) performUpdate:(NSArray *)sObjects
            failBlock:(ZKFailWithErrorBlock)failBlock
        completeBlock:(ZKCompleteArrayBlock)completeBlock;

/** Update or insert a set of sObjects based on object id */
-(void) performUpsert:(NSString *)externalIDFieldName sObjects:(NSArray *)sObjects
            failBlock:(ZKFailWithErrorBlock)failBlock
        completeBlock:(ZKCompleteArrayBlock)completeBlock;

/** Merge and update a set of sObjects based on object id */
-(void) performMerge:(NSArray *)request
           failBlock:(ZKFailWithErrorBlock)failBlock
       completeBlock:(ZKCompleteArrayBlock)completeBlock;

/** Delete a set of sObjects */
-(void) performDelete:(NSArray *)ids
            failBlock:(ZKFailWithErrorBlock)failBlock
        completeBlock:(ZKCompleteArrayBlock)completeBlock;

/** Undelete a set of sObjects */
-(void) performUndelete:(NSArray *)ids
              failBlock:(ZKFailWithErrorBlock)failBlock
          completeBlock:(ZKCompleteArrayBlock)completeBlock;

/** Empty a set of sObjects from the recycle bin */
-(void) performEmptyRecycleBin:(NSArray *)ids
                     failBlock:(ZKFailWithErrorBlock)failBlock
                 completeBlock:(ZKCompleteArrayBlock)completeBlock;

/** Get a set of sObjects */
-(void) performRetrieve:(NSString *)fieldList sObjectType:(NSString *)sObjectType ids:(NSArray *)ids
              failBlock:(ZKFailWithErrorBlock)failBlock
          completeBlock:(ZKCompleteDictionaryBlock)completeBlock;

/** Submit an entity to a workflow process or process a workitem */
-(void) performProcess:(NSArray *)actions
             failBlock:(ZKFailWithErrorBlock)failBlock
         completeBlock:(ZKCompleteArrayBlock)completeBlock;

/** convert a set of leads */
-(void) performConvertLead:(NSArray *)leadConverts
                 failBlock:(ZKFailWithErrorBlock)failBlock
             completeBlock:(ZKCompleteArrayBlock)completeBlock;

/** Logout the current user, invalidating the current session. */
-(void) performLogoutWithFailBlock:(ZKFailWithErrorBlock)failBlock
        completeBlock:(ZKCompleteVoidBlock)completeBlock;

/** Logs out and invalidates session ids */
-(void) performInvalidateSessions:(NSArray *)sessionIds
                        failBlock:(ZKFailWithErrorBlock)failBlock
                    completeBlock:(ZKCompleteArrayBlock)completeBlock;

/** Get the IDs for deleted sObjects */
-(void) performGetDeleted:(NSString *)sObjectType startDate:(NSDate *)startDate endDate:(NSDate *)endDate
                failBlock:(ZKFailWithErrorBlock)failBlock
            completeBlock:(ZKCompleteGetDeletedResultBlock)completeBlock;

/** Get the IDs for updated sObjects */
-(void) performGetUpdated:(NSString *)sObjectType startDate:(NSDate *)startDate endDate:(NSDate *)endDate
                failBlock:(ZKFailWithErrorBlock)failBlock
            completeBlock:(ZKCompleteGetUpdatedResultBlock)completeBlock;

/** Create a Query Cursor */
-(void) performQuery:(NSString *)queryString
           failBlock:(ZKFailWithErrorBlock)failBlock
       completeBlock:(ZKCompleteQueryResultBlock)completeBlock;

/** Create a Query Cursor, including deleted sObjects */
-(void) performQueryAll:(NSString *)queryString
              failBlock:(ZKFailWithErrorBlock)failBlock
          completeBlock:(ZKCompleteQueryResultBlock)completeBlock;

/** Gets the next batch of sObjects from a query */
-(void) performQueryMore:(NSString *)queryLocator
               failBlock:(ZKFailWithErrorBlock)failBlock
           completeBlock:(ZKCompleteQueryResultBlock)completeBlock;

/** Search for sObjects */
-(void) performSearch:(NSString *)searchString
            failBlock:(ZKFailWithErrorBlock)failBlock
        completeBlock:(ZKCompleteSearchResultBlock)completeBlock;

/** Gets server timestamp */
-(void) performGetServerTimestampWithFailBlock:(ZKFailWithErrorBlock)failBlock
                    completeBlock:(ZKCompleteGetServerTimestampResultBlock)completeBlock;

/** Set a user's password */
-(void) performSetPassword:(NSString *)userId password:(NSString *)password
                 failBlock:(ZKFailWithErrorBlock)failBlock
             completeBlock:(ZKCompleteSetPasswordResultBlock)completeBlock;

/** Change the current user's password */
-(void) performChangeOwnPassword:(NSString *)oldPassword newPassword:(NSString *)newPassword
                       failBlock:(ZKFailWithErrorBlock)failBlock
                   completeBlock:(ZKCompleteChangeOwnPasswordResultBlock)completeBlock;

/** Reset a user's password */
-(void) performResetPassword:(NSString *)userId
                   failBlock:(ZKFailWithErrorBlock)failBlock
               completeBlock:(ZKCompleteResetPasswordResultBlock)completeBlock;

/** Returns standard information relevant to the current user */
-(void) performGetUserInfoWithFailBlock:(ZKFailWithErrorBlock)failBlock
             completeBlock:(ZKCompleteUserInfoBlock)completeBlock;

/** Delete a set of sObjects by example. The passed SOBject is a template for the object to delete */
-(void) performDeleteByExample:(NSArray *)sObjects
                     failBlock:(ZKFailWithErrorBlock)failBlock
                 completeBlock:(ZKCompleteArrayBlock)completeBlock;

/** Send existing draft EmailMessage */
-(void) performSendEmailMessage:(NSArray *)ids
                      failBlock:(ZKFailWithErrorBlock)failBlock
                  completeBlock:(ZKCompleteArrayBlock)completeBlock;

/** Send outbound email */
-(void) performSendEmail:(NSArray *)messages
               failBlock:(ZKFailWithErrorBlock)failBlock
           completeBlock:(ZKCompleteArrayBlock)completeBlock;

/** Perform a template merge on one or more blocks of text. */
-(void) performRenderEmailTemplate:(NSArray *)renderRequests
                         failBlock:(ZKFailWithErrorBlock)failBlock
                     completeBlock:(ZKCompleteArrayBlock)completeBlock;

/** Perform a template merge using an email template stored in the database. */
-(void) performRenderStoredEmailTemplate:(ZKRenderStoredEmailTemplateRequest *)request
                               failBlock:(ZKFailWithErrorBlock)failBlock
                           completeBlock:(ZKCompleteRenderStoredEmailTemplateResultBlock)completeBlock;

/** Perform a series of predefined actions such as quick create or log a task */
-(void) performPerformQuickActions:(NSArray *)quickActions
                         failBlock:(ZKFailWithErrorBlock)failBlock
                     completeBlock:(ZKCompleteArrayBlock)completeBlock;

/** Describe the details of a series of quick actions */
-(void) performDescribeQuickActions:(NSArray *)quickActions
                          failBlock:(ZKFailWithErrorBlock)failBlock
                      completeBlock:(ZKCompleteArrayBlock)completeBlock;

/** Describe the details of a series of quick actions in context of requested recordType id for Update actions */
-(void) performDescribeQuickActionsForRecordType:(NSArray *)quickActions recordTypeId:(NSString *)recordTypeId
                                       failBlock:(ZKFailWithErrorBlock)failBlock
                                   completeBlock:(ZKCompleteArrayBlock)completeBlock;

/** Describe the details of a series of quick actions available for the given contextType */
-(void) performDescribeAvailableQuickActions:(NSString *)contextType
                                   failBlock:(ZKFailWithErrorBlock)failBlock
                               completeBlock:(ZKCompleteArrayBlock)completeBlock;

/** Retrieve the template sobjects, if appropriate, for the given quick action names in a given context */
-(void) performRetrieveQuickActionTemplates:(NSArray *)quickActionNames contextId:(NSString *)contextId
                                  failBlock:(ZKFailWithErrorBlock)failBlock
                              completeBlock:(ZKCompleteArrayBlock)completeBlock;

/** Retrieve the template sobjects, if appropriate, for the given quick action names in a given contexts when used a mass quick action */
-(void) performRetrieveMassQuickActionTemplates:(NSString *)quickActionName contextIds:(NSArray *)contextIds
                                      failBlock:(ZKFailWithErrorBlock)failBlock
                                  completeBlock:(ZKCompleteArrayBlock)completeBlock;

/** Describe visualforce for an org */
-(void) performDescribeVisualForce:(BOOL)includeAllDetails namespacePrefix:(NSString *)namespacePrefix
                         failBlock:(ZKFailWithErrorBlock)failBlock
                     completeBlock:(ZKCompleteDescribeVisualForceResultBlock)completeBlock;

/** Find duplicates for a set of sObjects */
-(void) performFindDuplicates:(NSArray *)sObjects
                    failBlock:(ZKFailWithErrorBlock)failBlock
                completeBlock:(ZKCompleteArrayBlock)completeBlock;

/** Find duplicates for a set of ids */
-(void) performFindDuplicatesByIds:(NSArray *)ids
                         failBlock:(ZKFailWithErrorBlock)failBlock
                     completeBlock:(ZKCompleteArrayBlock)completeBlock;

/** Return the renameable nouns from the server for use in presentation using the salesforce grammar engine */
-(void) performDescribeNouns:(NSArray *)nouns onlyRenamed:(BOOL)onlyRenamed includeFields:(BOOL)includeFields
                   failBlock:(ZKFailWithErrorBlock)failBlock
               completeBlock:(ZKCompleteArrayBlock)completeBlock;

@end
