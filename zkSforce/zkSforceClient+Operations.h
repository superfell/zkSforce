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

#import "zkSforce.h"

@class ZKDescribeAppMenuResult;
@class ZKDescribeCompactLayoutsResult;
@class ZKDescribeGlobalTheme;
@class ZKDescribeLayoutResult;
@class ZKDescribeSoftphoneLayoutResult;
@class ZKDescribeThemeResult;
@class ZKGetDeletedResult;
@class ZKGetServerTimestampResult;
@class ZKGetUpdatedResult;
@class ZKQueryResult;
@class ZKResetPasswordResult;
@class ZKSetPasswordResult;
@class ZKUserInfo;

@interface ZKSforceClient (Operations)
// Describe a number sObjects
-(NSArray *)describeSObjects:(NSArray *)sObjectType;

// Describe all the data category groups available for a given set of types
-(NSArray *)describeDataCategoryGroups:(NSArray *)sObjectType;

// Describe the data category group structures for a given set of pair of types and data category group name
-(NSArray *)describeDataCategoryGroupStructures:(NSArray *)pairs topCategoriesOnly:(BOOL)topCategoriesOnly;

// Describe a list of FlexiPage and their contents
-(NSArray *)describeFlexiPages:(NSArray *)flexiPages;

// Describe the items in an AppMenu
-(ZKDescribeAppMenuResult *)describeAppMenu:(NSString *)appMenuType;

// Describe Gloal and Themes
-(ZKDescribeGlobalTheme *)describeGlobalTheme;

// Describe Themes
-(ZKDescribeThemeResult *)describeTheme:(NSArray *)sobjectType;

// Describe the layout of the given sObject or the given actionable global page.
-(ZKDescribeLayoutResult *)describeLayout:(NSString *)sObjectType recordTypeIds:(NSArray *)recordTypeIds;

// Describe the layout of the SoftPhone
-(ZKDescribeSoftphoneLayoutResult *)describeSoftphoneLayout;

// Describe the search view of an sObject
-(NSArray *)describeSearchLayouts:(NSArray *)sObjectType;

// Describe a list of objects representing the order and scope of objects on a users search result page
-(NSArray *)describeSearchScopeOrder;

// Describe the compact layouts of the given sObject
-(ZKDescribeCompactLayoutsResult *)describeCompactLayouts:(NSString *)sObjectType recordTypeIds:(NSArray *)recordTypeIds;

// Update or insert a set of sObjects based on object id
-(NSArray *)upsert:(NSString *)externalIDFieldName sObjects:(NSArray *)sObjects;

// Merge and update a set of sObjects based on object id
-(NSArray *)merge:(NSArray *)request;

// Undelete a set of sObjects
-(NSArray *)undelete:(NSArray *)ids;

// Empty a set of sObjects from the recycle bin
-(NSArray *)emptyRecycleBin:(NSArray *)ids;

// Get a set of sObjects
-(NSArray *)retrieve:(NSString *)fieldList sObjectType:(NSString *)sObjectType ids:(NSArray *)ids;

// Submit an entity to a workflow process or process a workitem
-(NSArray *)process:(NSArray *)actions;

// convert a set of leads
-(NSArray *)convertLead:(NSArray *)leadConverts;

// Logout the current user, invalidating the current session.
-(void)logout;

// Logs out and invalidates session ids
-(NSArray *)invalidateSessions:(NSArray *)sessionIds;

// Get the IDs for deleted sObjects
-(ZKGetDeletedResult *)getDeleted:(NSString *)sObjectType startDate:(NSDate *)startDate endDate:(NSDate *)endDate;

// Get the IDs for updated sObjects
-(ZKGetUpdatedResult *)getUpdated:(NSString *)sObjectType startDate:(NSDate *)startDate endDate:(NSDate *)endDate;

// Create a Query Cursor
-(ZKQueryResult *)query:(NSString *)queryString;

// Create a Query Cursor, including deleted sObjects
-(ZKQueryResult *)queryAll:(NSString *)queryString;

// Gets the next batch of sObjects from a query
-(ZKQueryResult *)queryMore:(NSString *)queryLocator;

// Gets server timestamp
-(ZKGetServerTimestampResult *)getServerTimestamp;

// Set a user's password
-(ZKSetPasswordResult *)setPassword:(NSString *)userId password:(NSString *)password;

// Reset a user's password
-(ZKResetPasswordResult *)resetPassword:(NSString *)userId;

// Returns standard information relevant to the current user
-(ZKUserInfo *)getUserInfo;

// Send existing draft EmailMessage
-(NSArray *)sendEmailMessage:(NSArray *)ids;

// Send outbound email
-(NSArray *)sendEmail:(NSArray *)messages;

// Perform a series of predefined actions such as quick create or log a task
-(NSArray *)performQuickActions:(NSArray *)quickActions;

// Describe the details of a series of quick actions
-(NSArray *)describeQuickActions:(NSArray *)quickActions;

// Describe the details of a series of quick actions available for the given contextType
-(NSArray *)describeAvailableQuickActions:(NSString *)contextType;

@end
