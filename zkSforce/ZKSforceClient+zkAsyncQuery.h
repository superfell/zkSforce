// Copyright (c) 2011,2013 Jonathan Hersh, Simon Fell
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

@interface ZKSforceClient (zkAsyncQuery)

typedef void (^zkCompleteUserInfoBlock)                        (ZKUserInfo *result);
typedef void (^zkCompleteSetPasswordResultBlock)               (ZKSetPasswordResult *result);
typedef void (^zkCompleteResetPasswordResultBlock)             (ZKResetPasswordResult *result);
typedef void (^zkCompleteRenderStoredEmailTemplateResultBlock) (ZKRenderStoredEmailTemplateResult *result);
typedef void (^zkCompleteQueryResultBlock)                     (ZKQueryResult *result);
typedef void (^zkCompleteLoginResultBlock)                     (ZKLoginResult *result);
typedef void (^zkCompleteKnowledgeSettingsBlock)               (ZKKnowledgeSettings *result);
typedef void (^zkCompleteGetUpdatedResultBlock)                (ZKGetUpdatedResult *result);
typedef void (^zkCompleteGetServerTimestampResultBlock)        (ZKGetServerTimestampResult *result);
typedef void (^zkCompleteGetDeletedResultBlock)                (ZKGetDeletedResult *result);
typedef void (^zkCompleteExecuteListViewResultBlock)           (ZKExecuteListViewResult *result);
typedef void (^zkCompleteDescribeVisualForceResultBlock)       (ZKDescribeVisualForceResult *result);
typedef void (^zkCompleteDescribeThemeResultBlock)             (ZKDescribeThemeResult *result);
typedef void (^zkCompleteDescribeSoqlListViewResultBlock)      (ZKDescribeSoqlListViewResult *result);
typedef void (^zkCompleteDescribeSoftphoneLayoutResultBlock)   (ZKDescribeSoftphoneLayoutResult *result);
typedef void (^zkCompleteDescribeSObjectBlock)                 (ZKDescribeSObject *result);
typedef void (^zkCompleteDescribePathAssistantsResultBlock)    (ZKDescribePathAssistantsResult *result);
typedef void (^zkCompleteDescribeLayoutResultBlock)            (ZKDescribeLayoutResult *result);
typedef void (^zkCompleteDescribeGlobalThemeBlock)             (ZKDescribeGlobalTheme *result);
typedef void (^zkCompleteDescribeCompactLayoutsResultBlock)    (ZKDescribeCompactLayoutsResult *result);
typedef void (^zkCompleteDescribeApprovalLayoutResultBlock)    (ZKDescribeApprovalLayoutResult *result);
typedef void (^zkCompleteDescribeAppMenuResultBlock)           (ZKDescribeAppMenuResult *result);
typedef void (^zkCompleteChangeOwnPasswordResultBlock)         (ZKChangeOwnPasswordResult *result);
typedef void (^zkCompleteDictionaryBlock)                      (NSDictionary *result);
typedef void (^zkCompleteArrayBlock)                           (NSArray *result);
typedef void (^zkFailWithExceptionBlock)                       (NSException *result);
typedef void (^zkCompleteVoidBlock)                            (void);

/** Login to the Salesforce.com SOAP Api */
-(void) performLogin:(NSString *)username password:(NSString *)password
           failBlock:(zkFailWithExceptionBlock)failBlock
       completeBlock:(zkCompleteLoginResultBlock)completeBlock;

/** Describe an sObject */
-(void) performDescribeSObject:(NSString *)sObjectType
                     failBlock:(zkFailWithExceptionBlock)failBlock
                 completeBlock:(zkCompleteDescribeSObjectBlock)completeBlock;

/** Describe multiple sObjects (upto 100) */
-(void) performDescribeSObjects:(NSArray *)sObjectType
                      failBlock:(zkFailWithExceptionBlock)failBlock
                  completeBlock:(zkCompleteArrayBlock)completeBlock;

/** Describe the Global state */
-(void) performDescribeGlobalWithFailBlock:(zkFailWithExceptionBlock)failBlock
                completeBlock:(zkCompleteArrayBlock)completeBlock;

/** Describe all the data category groups available for a given set of types */
-(void) performDescribeDataCategoryGroups:(NSArray *)sObjectType
                                failBlock:(zkFailWithExceptionBlock)failBlock
                            completeBlock:(zkCompleteArrayBlock)completeBlock;

/** Describe the data category group structures for a given set of pair of types and data category group name */
-(void) performDescribeDataCategoryGroupStructures:(NSArray *)pairs topCategoriesOnly:(BOOL)topCategoriesOnly
                                         failBlock:(zkFailWithExceptionBlock)failBlock
                                     completeBlock:(zkCompleteArrayBlock)completeBlock;

/** Describes your Knowledge settings, such as if knowledgeEnabled is on or off, its default language and supported languages */
-(void) performDescribeKnowledgeSettingsWithFailBlock:(zkFailWithExceptionBlock)failBlock
                           completeBlock:(zkCompleteKnowledgeSettingsBlock)completeBlock;

/** Describe the items in an AppMenu */
-(void) performDescribeAppMenu:(NSString *)appMenuType networkId:(NSString *)networkId
                     failBlock:(zkFailWithExceptionBlock)failBlock
                 completeBlock:(zkCompleteDescribeAppMenuResultBlock)completeBlock;

/** Describe Gloal and Themes */
-(void) performDescribeGlobalThemeWithFailBlock:(zkFailWithExceptionBlock)failBlock
                     completeBlock:(zkCompleteDescribeGlobalThemeBlock)completeBlock;

/** Describe Themes */
-(void) performDescribeTheme:(NSArray *)sobjectType
                   failBlock:(zkFailWithExceptionBlock)failBlock
               completeBlock:(zkCompleteDescribeThemeResultBlock)completeBlock;

/** Describe the layout of the given sObject or the given actionable global page. */
-(void) performDescribeLayout:(NSString *)sObjectType layoutName:(NSString *)layoutName recordTypeIds:(NSArray *)recordTypeIds
                    failBlock:(zkFailWithExceptionBlock)failBlock
                completeBlock:(zkCompleteDescribeLayoutResultBlock)completeBlock;

/** Describe the layout of the SoftPhone */
-(void) performDescribeSoftphoneLayoutWithFailBlock:(zkFailWithExceptionBlock)failBlock
                         completeBlock:(zkCompleteDescribeSoftphoneLayoutResultBlock)completeBlock;

/** Describe the search view of an sObject */
-(void) performDescribeSearchLayouts:(NSArray *)sObjectType
                           failBlock:(zkFailWithExceptionBlock)failBlock
                       completeBlock:(zkCompleteArrayBlock)completeBlock;

/** Describe a list of entity names that reflects the current user's searchable entities */
-(void) performDescribeSearchableEntities:(BOOL)includeOnlyEntitiesWithTabs
                                failBlock:(zkFailWithExceptionBlock)failBlock
                            completeBlock:(zkCompleteArrayBlock)completeBlock;

/** Describe a list of objects representing the order and scope of objects on a users search result page */
-(void) performDescribeSearchScopeOrderWithFailBlock:(zkFailWithExceptionBlock)failBlock
                          completeBlock:(zkCompleteArrayBlock)completeBlock;

/** Describe the compact layouts of the given sObject */
-(void) performDescribeCompactLayouts:(NSString *)sObjectType recordTypeIds:(NSArray *)recordTypeIds
                            failBlock:(zkFailWithExceptionBlock)failBlock
                        completeBlock:(zkCompleteDescribeCompactLayoutsResultBlock)completeBlock;

/** Describe the Path Assistants for the given sObject and optionally RecordTypes */
-(void) performDescribePathAssistants:(NSString *)sObjectType picklistValue:(NSString *)picklistValue recordTypeIds:(NSArray *)recordTypeIds
                            failBlock:(zkFailWithExceptionBlock)failBlock
                        completeBlock:(zkCompleteDescribePathAssistantsResultBlock)completeBlock;

/** Describe the approval layouts of the given sObject */
-(void) performDescribeApprovalLayout:(NSString *)sObjectType approvalProcessNames:(NSArray *)approvalProcessNames
                            failBlock:(zkFailWithExceptionBlock)failBlock
                        completeBlock:(zkCompleteDescribeApprovalLayoutResultBlock)completeBlock;

/** Describe the ListViews as SOQL metadata for the generation of SOQL. */
-(void) performDescribeSoqlListViews:(ZKDescribeSoqlListViewsRequest *)request
                           failBlock:(zkFailWithExceptionBlock)failBlock
                       completeBlock:(zkCompleteDescribeSoqlListViewResultBlock)completeBlock;

/** Execute the specified list view and return the presentation-ready results. */
-(void) performExecuteListView:(ZKExecuteListViewRequest *)request
                     failBlock:(zkFailWithExceptionBlock)failBlock
                 completeBlock:(zkCompleteExecuteListViewResultBlock)completeBlock;

/** Describe the ListViews of a SObject as SOQL metadata for the generation of SOQL. */
-(void) performDescribeSObjectListViews:(NSString *)sObjectType recentsOnly:(BOOL)recentsOnly isSoqlCompatible:(NSString *)isSoqlCompatible limit:(NSInteger)limit offset:(NSInteger)offset
                              failBlock:(zkFailWithExceptionBlock)failBlock
                          completeBlock:(zkCompleteDescribeSoqlListViewResultBlock)completeBlock;

/** Describe the tabs that appear on a users page */
-(void) performDescribeTabsWithFailBlock:(zkFailWithExceptionBlock)failBlock
              completeBlock:(zkCompleteArrayBlock)completeBlock;

/** Describe all tabs available to a user */
-(void) performDescribeAllTabsWithFailBlock:(zkFailWithExceptionBlock)failBlock
                 completeBlock:(zkCompleteArrayBlock)completeBlock;

/** Describe the primary compact layouts for the sObjects requested */
-(void) performDescribePrimaryCompactLayouts:(NSArray *)sObjectTypes
                                   failBlock:(zkFailWithExceptionBlock)failBlock
                               completeBlock:(zkCompleteArrayBlock)completeBlock;

/** Create a set of new sObjects */
-(void) performCreate:(NSArray *)sObjects
            failBlock:(zkFailWithExceptionBlock)failBlock
        completeBlock:(zkCompleteArrayBlock)completeBlock;

/** Update a set of sObjects */
-(void) performUpdate:(NSArray *)sObjects
            failBlock:(zkFailWithExceptionBlock)failBlock
        completeBlock:(zkCompleteArrayBlock)completeBlock;

/** Update or insert a set of sObjects based on object id */
-(void) performUpsert:(NSString *)externalIDFieldName sObjects:(NSArray *)sObjects
            failBlock:(zkFailWithExceptionBlock)failBlock
        completeBlock:(zkCompleteArrayBlock)completeBlock;

/** Merge and update a set of sObjects based on object id */
-(void) performMerge:(NSArray *)request
           failBlock:(zkFailWithExceptionBlock)failBlock
       completeBlock:(zkCompleteArrayBlock)completeBlock;

/** Delete a set of sObjects */
-(void) performDelete:(NSArray *)ids
            failBlock:(zkFailWithExceptionBlock)failBlock
        completeBlock:(zkCompleteArrayBlock)completeBlock;

/** Undelete a set of sObjects */
-(void) performUndelete:(NSArray *)ids
              failBlock:(zkFailWithExceptionBlock)failBlock
          completeBlock:(zkCompleteArrayBlock)completeBlock;

/** Empty a set of sObjects from the recycle bin */
-(void) performEmptyRecycleBin:(NSArray *)ids
                     failBlock:(zkFailWithExceptionBlock)failBlock
                 completeBlock:(zkCompleteArrayBlock)completeBlock;

/** Get a set of sObjects */
-(void) performRetrieve:(NSString *)fieldList sObjectType:(NSString *)sObjectType ids:(NSArray *)ids
              failBlock:(zkFailWithExceptionBlock)failBlock
          completeBlock:(zkCompleteDictionaryBlock)completeBlock;

/** Submit an entity to a workflow process or process a workitem */
-(void) performProcess:(NSArray *)actions
             failBlock:(zkFailWithExceptionBlock)failBlock
         completeBlock:(zkCompleteArrayBlock)completeBlock;

/** convert a set of leads */
-(void) performConvertLead:(NSArray *)leadConverts
                 failBlock:(zkFailWithExceptionBlock)failBlock
             completeBlock:(zkCompleteArrayBlock)completeBlock;

/** Logout the current user, invalidating the current session. */
-(void) performLogoutWithFailBlock:(zkFailWithExceptionBlock)failBlock
        completeBlock:(zkCompleteVoidBlock)completeBlock;

/** Logs out and invalidates session ids */
-(void) performInvalidateSessions:(NSArray *)sessionIds
                        failBlock:(zkFailWithExceptionBlock)failBlock
                    completeBlock:(zkCompleteArrayBlock)completeBlock;

/** Get the IDs for deleted sObjects */
-(void) performGetDeleted:(NSString *)sObjectType startDate:(NSDate *)startDate endDate:(NSDate *)endDate
                failBlock:(zkFailWithExceptionBlock)failBlock
            completeBlock:(zkCompleteGetDeletedResultBlock)completeBlock;

/** Get the IDs for updated sObjects */
-(void) performGetUpdated:(NSString *)sObjectType startDate:(NSDate *)startDate endDate:(NSDate *)endDate
                failBlock:(zkFailWithExceptionBlock)failBlock
            completeBlock:(zkCompleteGetUpdatedResultBlock)completeBlock;

/** Create a Query Cursor */
-(void) performQuery:(NSString *)queryString
           failBlock:(zkFailWithExceptionBlock)failBlock
       completeBlock:(zkCompleteQueryResultBlock)completeBlock;

/** Create a Query Cursor, including deleted sObjects */
-(void) performQueryAll:(NSString *)queryString
              failBlock:(zkFailWithExceptionBlock)failBlock
          completeBlock:(zkCompleteQueryResultBlock)completeBlock;

/** Gets the next batch of sObjects from a query */
-(void) performQueryMore:(NSString *)queryLocator
               failBlock:(zkFailWithExceptionBlock)failBlock
           completeBlock:(zkCompleteQueryResultBlock)completeBlock;

/** Search for sObjects */
-(void) performSearch:(NSString *)searchString
            failBlock:(zkFailWithExceptionBlock)failBlock
        completeBlock:(zkCompleteArrayBlock)completeBlock;

/** Gets server timestamp */
-(void) performGetServerTimestampWithFailBlock:(zkFailWithExceptionBlock)failBlock
                    completeBlock:(zkCompleteGetServerTimestampResultBlock)completeBlock;

/** Set a user's password */
-(void) performSetPassword:(NSString *)userId password:(NSString *)password
                 failBlock:(zkFailWithExceptionBlock)failBlock
             completeBlock:(zkCompleteSetPasswordResultBlock)completeBlock;

/** Change the current user's password */
-(void) performChangeOwnPassword:(NSString *)oldPassword newPassword:(NSString *)newPassword
                       failBlock:(zkFailWithExceptionBlock)failBlock
                   completeBlock:(zkCompleteChangeOwnPasswordResultBlock)completeBlock;

/** Reset a user's password */
-(void) performResetPassword:(NSString *)userId
                   failBlock:(zkFailWithExceptionBlock)failBlock
               completeBlock:(zkCompleteResetPasswordResultBlock)completeBlock;

/** Returns standard information relevant to the current user */
-(void) performGetUserInfoWithFailBlock:(zkFailWithExceptionBlock)failBlock
             completeBlock:(zkCompleteUserInfoBlock)completeBlock;

/** Delete a set of sObjects by example. The passed SOBject is a template for the object to delete */
-(void) performDeleteByExample:(NSArray *)sObjects
                     failBlock:(zkFailWithExceptionBlock)failBlock
                 completeBlock:(zkCompleteArrayBlock)completeBlock;

/** Send existing draft EmailMessage */
-(void) performSendEmailMessage:(NSArray *)ids
                      failBlock:(zkFailWithExceptionBlock)failBlock
                  completeBlock:(zkCompleteArrayBlock)completeBlock;

/** Send outbound email */
-(void) performSendEmail:(NSArray *)messages
               failBlock:(zkFailWithExceptionBlock)failBlock
           completeBlock:(zkCompleteArrayBlock)completeBlock;

/** Perform a template merge on one or more blocks of text. */
-(void) performRenderEmailTemplate:(NSArray *)renderRequests
                         failBlock:(zkFailWithExceptionBlock)failBlock
                     completeBlock:(zkCompleteArrayBlock)completeBlock;

/** Perform a template merge using an email template stored in the database. */
-(void) performRenderStoredEmailTemplate:(ZKRenderStoredEmailTemplateRequest *)request
                               failBlock:(zkFailWithExceptionBlock)failBlock
                           completeBlock:(zkCompleteRenderStoredEmailTemplateResultBlock)completeBlock;

/** Perform a series of predefined actions such as quick create or log a task */
-(void) performPerformQuickActions:(NSArray *)quickActions
                         failBlock:(zkFailWithExceptionBlock)failBlock
                     completeBlock:(zkCompleteArrayBlock)completeBlock;

/** Describe the details of a series of quick actions */
-(void) performDescribeQuickActions:(NSArray *)quickActions
                          failBlock:(zkFailWithExceptionBlock)failBlock
                      completeBlock:(zkCompleteArrayBlock)completeBlock;

/** Describe the details of a series of quick actions available for the given contextType */
-(void) performDescribeAvailableQuickActions:(NSString *)contextType
                                   failBlock:(zkFailWithExceptionBlock)failBlock
                               completeBlock:(zkCompleteArrayBlock)completeBlock;

/** Retrieve the template sobjects, if appropriate, for the given quick action names in a given context */
-(void) performRetrieveQuickActionTemplates:(NSArray *)quickActionNames contextId:(NSString *)contextId
                                  failBlock:(zkFailWithExceptionBlock)failBlock
                              completeBlock:(zkCompleteArrayBlock)completeBlock;

/** Retrieve the template sobjects, if appropriate, for the given quick action names in a given contexts when used a mass quick action */
-(void) performRetrieveMassQuickActionTemplates:(NSString *)quickActionName contextIds:(NSArray *)contextIds
                                      failBlock:(zkFailWithExceptionBlock)failBlock
                                  completeBlock:(zkCompleteArrayBlock)completeBlock;

/** Describe visualforce for an org */
-(void) performDescribeVisualForce:(BOOL)includeAllDetails namespacePrefix:(NSString *)namespacePrefix
                         failBlock:(zkFailWithExceptionBlock)failBlock
                     completeBlock:(zkCompleteDescribeVisualForceResultBlock)completeBlock;

/** Find duplicates for a set of sObjects */
-(void) performFindDuplicates:(NSArray *)sObjects
                    failBlock:(zkFailWithExceptionBlock)failBlock
                completeBlock:(zkCompleteArrayBlock)completeBlock;

/** Find duplicates for a set of ids */
-(void) performFindDuplicatesByIds:(NSArray *)ids
                         failBlock:(zkFailWithExceptionBlock)failBlock
                     completeBlock:(zkCompleteArrayBlock)completeBlock;

/** Return the renameable nouns from the server for use in presentation using the salesforce grammar engine */
-(void) performDescribeNouns:(NSArray *)nouns onlyRenamed:(BOOL)onlyRenamed includeFields:(BOOL)includeFields
                   failBlock:(zkFailWithExceptionBlock)failBlock
               completeBlock:(zkCompleteArrayBlock)completeBlock;

@end
