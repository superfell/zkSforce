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

#import "ZKSforceClient+Operations.h"
#import "ZKPartnerEnvelope.h"
#import "ZKDataCategoryGroupSobjectTypePair.h"
#import "ZKDescribeAppMenuResult.h"
#import "ZKDescribeAvailableQuickActionResult.h"
#import "ZKDescribeCompactLayoutsResult.h"
#import "ZKDescribeDataCategoryGroupResult.h"
#import "ZKDescribeDataCategoryGroupStructureResult.h"
#import "ZKDescribeFlexiPageResult.h"
#import "ZKDescribeGlobalTheme.h"
#import "ZKDescribeLayoutResult.h"
#import "ZKDescribeQuickActionResult.h"
#import "ZKDescribeSObjectResult.h"
#import "ZKDescribeSearchLayoutResult.h"
#import "ZKDescribeSearchScopeOrderResult.h"
#import "ZKDescribeSoftphoneLayoutResult.h"
#import "ZKDescribeThemeResult.h"
#import "ZKEmail.h"
#import "ZKEmptyRecycleBinResult.h"
#import "ZKGetDeletedResult.h"
#import "ZKGetServerTimestampResult.h"
#import "ZKGetUpdatedResult.h"
#import "ZKInvalidateSessionsResult.h"
#import "ZKLeadConvert.h"
#import "ZKLeadConvertResult.h"
#import "ZKMergeRequest.h"
#import "ZKMergeResult.h"
#import "ZKPerformQuickActionRequest.h"
#import "ZKPerformQuickActionResult.h"
#import "ZKProcessRequest.h"
#import "ZKProcessResult.h"
#import "ZKQueryResult.h"
#import "ZKResetPasswordResult.h"
#import "ZKSObject.h"
#import "ZKSendEmailResult.h"
#import "ZKSetPasswordResult.h"
#import "ZKUndeleteResult.h"
#import "ZKUpsertResult.h"
#import "ZKUserInfo.h"

@implementation ZKSforceClient (Operations)
// Describe a number sObjects
-(NSArray *)describeSObjects:(NSArray *)sObjectType {
	if (!authSource) return nil;
	[self checkSession];
	ZKEnvelope *env = [[[ZKPartnerEnvelope alloc] initWithSessionHeader:[authSource sessionId] clientId:clientId] autorelease];
	[env startElement:@"describeSObjects"];
	[env addElement:@"sObjectType" elemValue:sObjectType];
	[env endElement:@"describeSObjects"];
	[env endElement:@"s:Body"];
	zkElement *rn = [self sendRequest:[env end]];
	ZKXmlDeserializer *deser = [[[ZKXmlDeserializer alloc] initWithXmlElement:rn] autorelease];
	return [deser complexTypeArrayFromElements:@"result" cls:[ZKDescribeSObjectResult class]];
}

// Describe all the data category groups available for a given set of types
-(NSArray *)describeDataCategoryGroups:(NSArray *)sObjectType {
	if (!authSource) return nil;
	[self checkSession];
	ZKEnvelope *env = [[[ZKPartnerEnvelope alloc] initWithSessionHeader:[authSource sessionId] clientId:clientId] autorelease];
	[env startElement:@"describeDataCategoryGroups"];
	[env addElement:@"sObjectType" elemValue:sObjectType];
	[env endElement:@"describeDataCategoryGroups"];
	[env endElement:@"s:Body"];
	zkElement *rn = [self sendRequest:[env end]];
	ZKXmlDeserializer *deser = [[[ZKXmlDeserializer alloc] initWithXmlElement:rn] autorelease];
	return [deser complexTypeArrayFromElements:@"result" cls:[ZKDescribeDataCategoryGroupResult class]];
}

// Describe the data category group structures for a given set of pair of types and data category group name
-(NSArray *)describeDataCategoryGroupStructures:(NSArray *)pairs topCategoriesOnly:(BOOL)topCategoriesOnly {
	if (!authSource) return nil;
	[self checkSession];
	ZKEnvelope *env = [[[ZKPartnerEnvelope alloc] initWithSessionHeader:[authSource sessionId] clientId:clientId] autorelease];
	[env startElement:@"describeDataCategoryGroupStructures"];
	[env addElement:@"pairs" elemValue:pairs];
	[env addBoolElement:@"topCategoriesOnly" elemValue:topCategoriesOnly];
	[env endElement:@"describeDataCategoryGroupStructures"];
	[env endElement:@"s:Body"];
	zkElement *rn = [self sendRequest:[env end]];
	ZKXmlDeserializer *deser = [[[ZKXmlDeserializer alloc] initWithXmlElement:rn] autorelease];
	return [deser complexTypeArrayFromElements:@"result" cls:[ZKDescribeDataCategoryGroupStructureResult class]];
}

// Describe a list of FlexiPage and their contents
-(NSArray *)describeFlexiPages:(NSArray *)flexiPages {
	if (!authSource) return nil;
	[self checkSession];
	ZKEnvelope *env = [[[ZKPartnerEnvelope alloc] initWithSessionHeader:[authSource sessionId] clientId:clientId] autorelease];
	[env startElement:@"describeFlexiPages"];
	[env addElement:@"flexiPages" elemValue:flexiPages];
	[env endElement:@"describeFlexiPages"];
	[env endElement:@"s:Body"];
	zkElement *rn = [self sendRequest:[env end]];
	ZKXmlDeserializer *deser = [[[ZKXmlDeserializer alloc] initWithXmlElement:rn] autorelease];
	return [deser complexTypeArrayFromElements:@"result" cls:[ZKDescribeFlexiPageResult class]];
}

// Describe the items in an AppMenu
-(ZKDescribeAppMenuResult *)describeAppMenu:(NSString *)appMenuType {
	if (!authSource) return nil;
	[self checkSession];
	ZKEnvelope *env = [[[ZKPartnerEnvelope alloc] initWithSessionHeader:[authSource sessionId] clientId:clientId] autorelease];
	[env startElement:@"describeAppMenu"];
	[env addElement:@"appMenuType" elemValue:appMenuType];
	[env endElement:@"describeAppMenu"];
	[env endElement:@"s:Body"];
	zkElement *rn = [self sendRequest:[env end]];
	ZKXmlDeserializer *deser = [[[ZKXmlDeserializer alloc] initWithXmlElement:rn] autorelease];
	return [[deser complexTypeArrayFromElements:@"result" cls:[ZKDescribeAppMenuResult class]] lastObject];
}

// Describe Gloal and Themes
-(ZKDescribeGlobalTheme *)describeGlobalTheme {
	if (!authSource) return nil;
	[self checkSession];
	ZKEnvelope *env = [[[ZKPartnerEnvelope alloc] initWithSessionHeader:[authSource sessionId] clientId:clientId] autorelease];
	[env startElement:@"describeGlobalTheme"];
	[env endElement:@"describeGlobalTheme"];
	[env endElement:@"s:Body"];
	zkElement *rn = [self sendRequest:[env end]];
	ZKXmlDeserializer *deser = [[[ZKXmlDeserializer alloc] initWithXmlElement:rn] autorelease];
	return [[deser complexTypeArrayFromElements:@"result" cls:[ZKDescribeGlobalTheme class]] lastObject];
}

// Describe Themes
-(ZKDescribeThemeResult *)describeTheme:(NSArray *)sobjectType {
	if (!authSource) return nil;
	[self checkSession];
	ZKEnvelope *env = [[[ZKPartnerEnvelope alloc] initWithSessionHeader:[authSource sessionId] clientId:clientId] autorelease];
	[env startElement:@"describeTheme"];
	[env addElement:@"sobjectType" elemValue:sobjectType];
	[env endElement:@"describeTheme"];
	[env endElement:@"s:Body"];
	zkElement *rn = [self sendRequest:[env end]];
	ZKXmlDeserializer *deser = [[[ZKXmlDeserializer alloc] initWithXmlElement:rn] autorelease];
	return [[deser complexTypeArrayFromElements:@"result" cls:[ZKDescribeThemeResult class]] lastObject];
}

// Describe the layout of the given sObject or the given actionable global page.
-(ZKDescribeLayoutResult *)describeLayout:(NSString *)sObjectType recordTypeIds:(NSArray *)recordTypeIds {
	if (!authSource) return nil;
	[self checkSession];
	ZKEnvelope *env = [[[ZKPartnerEnvelope alloc] initWithSessionHeader:[authSource sessionId] clientId:clientId] autorelease];
	[env startElement:@"describeLayout"];
	[env addElement:@"sObjectType" elemValue:sObjectType];
	[env addElement:@"recordTypeIds" elemValue:recordTypeIds];
	[env endElement:@"describeLayout"];
	[env endElement:@"s:Body"];
	zkElement *rn = [self sendRequest:[env end]];
	ZKXmlDeserializer *deser = [[[ZKXmlDeserializer alloc] initWithXmlElement:rn] autorelease];
	return [[deser complexTypeArrayFromElements:@"result" cls:[ZKDescribeLayoutResult class]] lastObject];
}

// Describe the layout of the SoftPhone
-(ZKDescribeSoftphoneLayoutResult *)describeSoftphoneLayout {
	if (!authSource) return nil;
	[self checkSession];
	ZKEnvelope *env = [[[ZKPartnerEnvelope alloc] initWithSessionHeader:[authSource sessionId] clientId:clientId] autorelease];
	[env startElement:@"describeSoftphoneLayout"];
	[env endElement:@"describeSoftphoneLayout"];
	[env endElement:@"s:Body"];
	zkElement *rn = [self sendRequest:[env end]];
	ZKXmlDeserializer *deser = [[[ZKXmlDeserializer alloc] initWithXmlElement:rn] autorelease];
	return [[deser complexTypeArrayFromElements:@"result" cls:[ZKDescribeSoftphoneLayoutResult class]] lastObject];
}

// Describe the search view of an sObject
-(NSArray *)describeSearchLayouts:(NSArray *)sObjectType {
	if (!authSource) return nil;
	[self checkSession];
	ZKEnvelope *env = [[[ZKPartnerEnvelope alloc] initWithSessionHeader:[authSource sessionId] clientId:clientId] autorelease];
	[env startElement:@"describeSearchLayouts"];
	[env addElement:@"sObjectType" elemValue:sObjectType];
	[env endElement:@"describeSearchLayouts"];
	[env endElement:@"s:Body"];
	zkElement *rn = [self sendRequest:[env end]];
	ZKXmlDeserializer *deser = [[[ZKXmlDeserializer alloc] initWithXmlElement:rn] autorelease];
	return [deser complexTypeArrayFromElements:@"result" cls:[ZKDescribeSearchLayoutResult class]];
}

// Describe a list of objects representing the order and scope of objects on a users search result page
-(NSArray *)describeSearchScopeOrder {
	if (!authSource) return nil;
	[self checkSession];
	ZKEnvelope *env = [[[ZKPartnerEnvelope alloc] initWithSessionHeader:[authSource sessionId] clientId:clientId] autorelease];
	[env startElement:@"describeSearchScopeOrder"];
	[env endElement:@"describeSearchScopeOrder"];
	[env endElement:@"s:Body"];
	zkElement *rn = [self sendRequest:[env end]];
	ZKXmlDeserializer *deser = [[[ZKXmlDeserializer alloc] initWithXmlElement:rn] autorelease];
	return [deser complexTypeArrayFromElements:@"result" cls:[ZKDescribeSearchScopeOrderResult class]];
}

// Describe the compact layouts of the given sObject
-(ZKDescribeCompactLayoutsResult *)describeCompactLayouts:(NSString *)sObjectType recordTypeIds:(NSArray *)recordTypeIds {
	if (!authSource) return nil;
	[self checkSession];
	ZKEnvelope *env = [[[ZKPartnerEnvelope alloc] initWithSessionHeader:[authSource sessionId] clientId:clientId] autorelease];
	[env startElement:@"describeCompactLayouts"];
	[env addElement:@"sObjectType" elemValue:sObjectType];
	[env addElement:@"recordTypeIds" elemValue:recordTypeIds];
	[env endElement:@"describeCompactLayouts"];
	[env endElement:@"s:Body"];
	zkElement *rn = [self sendRequest:[env end]];
	ZKXmlDeserializer *deser = [[[ZKXmlDeserializer alloc] initWithXmlElement:rn] autorelease];
	return [[deser complexTypeArrayFromElements:@"result" cls:[ZKDescribeCompactLayoutsResult class]] lastObject];
}

// Update or insert a set of sObjects based on object id
-(NSArray *)upsert:(NSString *)externalIDFieldName sObjects:(NSArray *)sObjects {
	if (!authSource) return nil;
	[self checkSession];
	ZKEnvelope *env = [[[ZKPartnerEnvelope alloc] initWithSessionHeader:[authSource sessionId] clientId:clientId] autorelease];
	[env startElement:@"upsert"];
	[env addElement:@"externalIDFieldName" elemValue:externalIDFieldName];
	[env addElement:@"sObjects" elemValue:sObjects];
	[env endElement:@"upsert"];
	[env endElement:@"s:Body"];
	zkElement *rn = [self sendRequest:[env end]];
	ZKXmlDeserializer *deser = [[[ZKXmlDeserializer alloc] initWithXmlElement:rn] autorelease];
	return [deser complexTypeArrayFromElements:@"result" cls:[ZKUpsertResult class]];
}

// Merge and update a set of sObjects based on object id
-(NSArray *)merge:(NSArray *)request {
	if (!authSource) return nil;
	[self checkSession];
	ZKEnvelope *env = [[[ZKPartnerEnvelope alloc] initWithSessionHeader:[authSource sessionId] clientId:clientId] autorelease];
	[env startElement:@"merge"];
	[env addElement:@"request" elemValue:request];
	[env endElement:@"merge"];
	[env endElement:@"s:Body"];
	zkElement *rn = [self sendRequest:[env end]];
	ZKXmlDeserializer *deser = [[[ZKXmlDeserializer alloc] initWithXmlElement:rn] autorelease];
	return [deser complexTypeArrayFromElements:@"result" cls:[ZKMergeResult class]];
}

// Undelete a set of sObjects
-(NSArray *)undelete:(NSArray *)ids {
	if (!authSource) return nil;
	[self checkSession];
	ZKEnvelope *env = [[[ZKPartnerEnvelope alloc] initWithSessionHeader:[authSource sessionId] clientId:clientId] autorelease];
	[env startElement:@"undelete"];
	[env addElement:@"ids" elemValue:ids];
	[env endElement:@"undelete"];
	[env endElement:@"s:Body"];
	zkElement *rn = [self sendRequest:[env end]];
	ZKXmlDeserializer *deser = [[[ZKXmlDeserializer alloc] initWithXmlElement:rn] autorelease];
	return [deser complexTypeArrayFromElements:@"result" cls:[ZKUndeleteResult class]];
}

// Empty a set of sObjects from the recycle bin
-(NSArray *)emptyRecycleBin:(NSArray *)ids {
	if (!authSource) return nil;
	[self checkSession];
	ZKEnvelope *env = [[[ZKPartnerEnvelope alloc] initWithSessionHeader:[authSource sessionId] clientId:clientId] autorelease];
	[env startElement:@"emptyRecycleBin"];
	[env addElement:@"ids" elemValue:ids];
	[env endElement:@"emptyRecycleBin"];
	[env endElement:@"s:Body"];
	zkElement *rn = [self sendRequest:[env end]];
	ZKXmlDeserializer *deser = [[[ZKXmlDeserializer alloc] initWithXmlElement:rn] autorelease];
	return [deser complexTypeArrayFromElements:@"result" cls:[ZKEmptyRecycleBinResult class]];
}

// Get a set of sObjects
-(NSArray *)retrieve:(NSString *)fieldList sObjectType:(NSString *)sObjectType ids:(NSArray *)ids {
	if (!authSource) return nil;
	[self checkSession];
	ZKEnvelope *env = [[[ZKPartnerEnvelope alloc] initWithSessionHeader:[authSource sessionId] clientId:clientId] autorelease];
	[env startElement:@"retrieve"];
	[env addElement:@"fieldList" elemValue:fieldList];
	[env addElement:@"sObjectType" elemValue:sObjectType];
	[env addElement:@"ids" elemValue:ids];
	[env endElement:@"retrieve"];
	[env endElement:@"s:Body"];
	zkElement *rn = [self sendRequest:[env end]];
	ZKXmlDeserializer *deser = [[[ZKXmlDeserializer alloc] initWithXmlElement:rn] autorelease];
	return [deser complexTypeArrayFromElements:@"result" cls:[ZKSObject class]];
}

// Submit an entity to a workflow process or process a workitem
-(NSArray *)process:(NSArray *)actions {
	if (!authSource) return nil;
	[self checkSession];
	ZKEnvelope *env = [[[ZKPartnerEnvelope alloc] initWithSessionHeader:[authSource sessionId] clientId:clientId] autorelease];
	[env startElement:@"process"];
	[env addElement:@"actions" elemValue:actions];
	[env endElement:@"process"];
	[env endElement:@"s:Body"];
	zkElement *rn = [self sendRequest:[env end]];
	ZKXmlDeserializer *deser = [[[ZKXmlDeserializer alloc] initWithXmlElement:rn] autorelease];
	return [deser complexTypeArrayFromElements:@"result" cls:[ZKProcessResult class]];
}

// convert a set of leads
-(NSArray *)convertLead:(NSArray *)leadConverts {
	if (!authSource) return nil;
	[self checkSession];
	ZKEnvelope *env = [[[ZKPartnerEnvelope alloc] initWithSessionHeader:[authSource sessionId] clientId:clientId] autorelease];
	[env startElement:@"convertLead"];
	[env addElement:@"leadConverts" elemValue:leadConverts];
	[env endElement:@"convertLead"];
	[env endElement:@"s:Body"];
	zkElement *rn = [self sendRequest:[env end]];
	ZKXmlDeserializer *deser = [[[ZKXmlDeserializer alloc] initWithXmlElement:rn] autorelease];
	return [deser complexTypeArrayFromElements:@"result" cls:[ZKLeadConvertResult class]];
}

// Logout the current user, invalidating the current session.
-(void)logout {
	if (!authSource) return ;
	[self checkSession];
	ZKEnvelope *env = [[[ZKPartnerEnvelope alloc] initWithSessionHeader:[authSource sessionId] clientId:clientId] autorelease];
	[env startElement:@"logout"];
	[env endElement:@"logout"];
	[env endElement:@"s:Body"];
	[self sendRequest:[env end]];
}

// Logs out and invalidates session ids
-(NSArray *)invalidateSessions:(NSArray *)sessionIds {
	if (!authSource) return nil;
	[self checkSession];
	ZKEnvelope *env = [[[ZKPartnerEnvelope alloc] initWithSessionHeader:[authSource sessionId] clientId:clientId] autorelease];
	[env startElement:@"invalidateSessions"];
	[env addElement:@"sessionIds" elemValue:sessionIds];
	[env endElement:@"invalidateSessions"];
	[env endElement:@"s:Body"];
	zkElement *rn = [self sendRequest:[env end]];
	ZKXmlDeserializer *deser = [[[ZKXmlDeserializer alloc] initWithXmlElement:rn] autorelease];
	return [deser complexTypeArrayFromElements:@"result" cls:[ZKInvalidateSessionsResult class]];
}

// Get the IDs for deleted sObjects
-(ZKGetDeletedResult *)getDeleted:(NSString *)sObjectType startDate:(NSDate *)startDate endDate:(NSDate *)endDate {
	if (!authSource) return nil;
	[self checkSession];
	ZKEnvelope *env = [[[ZKPartnerEnvelope alloc] initWithSessionHeader:[authSource sessionId] clientId:clientId] autorelease];
	[env startElement:@"getDeleted"];
	[env addElement:@"sObjectType" elemValue:sObjectType];
	[env addElement:@"startDate" elemValue:startDate];
	[env addElement:@"endDate" elemValue:endDate];
	[env endElement:@"getDeleted"];
	[env endElement:@"s:Body"];
	zkElement *rn = [self sendRequest:[env end]];
	ZKXmlDeserializer *deser = [[[ZKXmlDeserializer alloc] initWithXmlElement:rn] autorelease];
	return [[deser complexTypeArrayFromElements:@"result" cls:[ZKGetDeletedResult class]] lastObject];
}

// Get the IDs for updated sObjects
-(ZKGetUpdatedResult *)getUpdated:(NSString *)sObjectType startDate:(NSDate *)startDate endDate:(NSDate *)endDate {
	if (!authSource) return nil;
	[self checkSession];
	ZKEnvelope *env = [[[ZKPartnerEnvelope alloc] initWithSessionHeader:[authSource sessionId] clientId:clientId] autorelease];
	[env startElement:@"getUpdated"];
	[env addElement:@"sObjectType" elemValue:sObjectType];
	[env addElement:@"startDate" elemValue:startDate];
	[env addElement:@"endDate" elemValue:endDate];
	[env endElement:@"getUpdated"];
	[env endElement:@"s:Body"];
	zkElement *rn = [self sendRequest:[env end]];
	ZKXmlDeserializer *deser = [[[ZKXmlDeserializer alloc] initWithXmlElement:rn] autorelease];
	return [[deser complexTypeArrayFromElements:@"result" cls:[ZKGetUpdatedResult class]] lastObject];
}

// Create a Query Cursor
-(ZKQueryResult *)query:(NSString *)queryString {
	if (!authSource) return nil;
	[self checkSession];
	ZKEnvelope *env = [[[ZKPartnerEnvelope alloc] initWithSessionHeader:[authSource sessionId] clientId:clientId] autorelease];
	[env startElement:@"query"];
	[env addElement:@"queryString" elemValue:queryString];
	[env endElement:@"query"];
	[env endElement:@"s:Body"];
	zkElement *rn = [self sendRequest:[env end]];
	ZKXmlDeserializer *deser = [[[ZKXmlDeserializer alloc] initWithXmlElement:rn] autorelease];
	return [deser queryResult:@"result"];
}

// Create a Query Cursor, including deleted sObjects
-(ZKQueryResult *)queryAll:(NSString *)queryString {
	if (!authSource) return nil;
	[self checkSession];
	ZKEnvelope *env = [[[ZKPartnerEnvelope alloc] initWithSessionHeader:[authSource sessionId] clientId:clientId] autorelease];
	[env startElement:@"queryAll"];
	[env addElement:@"queryString" elemValue:queryString];
	[env endElement:@"queryAll"];
	[env endElement:@"s:Body"];
	zkElement *rn = [self sendRequest:[env end]];
	ZKXmlDeserializer *deser = [[[ZKXmlDeserializer alloc] initWithXmlElement:rn] autorelease];
	return [deser queryResult:@"result"];
}

// Gets the next batch of sObjects from a query
-(ZKQueryResult *)queryMore:(NSString *)queryLocator {
	if (!authSource) return nil;
	[self checkSession];
	ZKEnvelope *env = [[[ZKPartnerEnvelope alloc] initWithSessionHeader:[authSource sessionId] clientId:clientId] autorelease];
	[env startElement:@"queryMore"];
	[env addElement:@"queryLocator" elemValue:queryLocator];
	[env endElement:@"queryMore"];
	[env endElement:@"s:Body"];
	zkElement *rn = [self sendRequest:[env end]];
	ZKXmlDeserializer *deser = [[[ZKXmlDeserializer alloc] initWithXmlElement:rn] autorelease];
	return [deser queryResult:@"result"];
}

// Gets server timestamp
-(ZKGetServerTimestampResult *)getServerTimestamp {
	if (!authSource) return nil;
	[self checkSession];
	ZKEnvelope *env = [[[ZKPartnerEnvelope alloc] initWithSessionHeader:[authSource sessionId] clientId:clientId] autorelease];
	[env startElement:@"getServerTimestamp"];
	[env endElement:@"getServerTimestamp"];
	[env endElement:@"s:Body"];
	zkElement *rn = [self sendRequest:[env end]];
	ZKXmlDeserializer *deser = [[[ZKXmlDeserializer alloc] initWithXmlElement:rn] autorelease];
	return [[deser complexTypeArrayFromElements:@"result" cls:[ZKGetServerTimestampResult class]] lastObject];
}

// Set a user's password
-(ZKSetPasswordResult *)setPassword:(NSString *)userId password:(NSString *)password {
	if (!authSource) return nil;
	[self checkSession];
	ZKEnvelope *env = [[[ZKPartnerEnvelope alloc] initWithSessionHeader:[authSource sessionId] clientId:clientId] autorelease];
	[env startElement:@"setPassword"];
	[env addElement:@"userId" elemValue:userId];
	[env addElement:@"password" elemValue:password];
	[env endElement:@"setPassword"];
	[env endElement:@"s:Body"];
	zkElement *rn = [self sendRequest:[env end]];
	ZKXmlDeserializer *deser = [[[ZKXmlDeserializer alloc] initWithXmlElement:rn] autorelease];
	return [[deser complexTypeArrayFromElements:@"result" cls:[ZKSetPasswordResult class]] lastObject];
}

// Reset a user's password
-(ZKResetPasswordResult *)resetPassword:(NSString *)userId {
	if (!authSource) return nil;
	[self checkSession];
	ZKEnvelope *env = [[[ZKPartnerEnvelope alloc] initWithSessionHeader:[authSource sessionId] clientId:clientId] autorelease];
	[env startElement:@"resetPassword"];
	[env addElement:@"userId" elemValue:userId];
	[env endElement:@"resetPassword"];
	[env endElement:@"s:Body"];
	zkElement *rn = [self sendRequest:[env end]];
	ZKXmlDeserializer *deser = [[[ZKXmlDeserializer alloc] initWithXmlElement:rn] autorelease];
	return [[deser complexTypeArrayFromElements:@"result" cls:[ZKResetPasswordResult class]] lastObject];
}

// Returns standard information relevant to the current user
-(ZKUserInfo *)getUserInfo {
	if (!authSource) return nil;
	[self checkSession];
	ZKEnvelope *env = [[[ZKPartnerEnvelope alloc] initWithSessionHeader:[authSource sessionId] clientId:clientId] autorelease];
	[env startElement:@"getUserInfo"];
	[env endElement:@"getUserInfo"];
	[env endElement:@"s:Body"];
	zkElement *rn = [self sendRequest:[env end]];
	ZKXmlDeserializer *deser = [[[ZKXmlDeserializer alloc] initWithXmlElement:rn] autorelease];
	return [[deser complexTypeArrayFromElements:@"result" cls:[ZKUserInfo class]] lastObject];
}

// Send existing draft EmailMessage
-(NSArray *)sendEmailMessage:(NSArray *)ids {
	if (!authSource) return nil;
	[self checkSession];
	ZKEnvelope *env = [[[ZKPartnerEnvelope alloc] initWithSessionHeader:[authSource sessionId] clientId:clientId] autorelease];
	[env startElement:@"sendEmailMessage"];
	[env addElement:@"ids" elemValue:ids];
	[env endElement:@"sendEmailMessage"];
	[env endElement:@"s:Body"];
	zkElement *rn = [self sendRequest:[env end]];
	ZKXmlDeserializer *deser = [[[ZKXmlDeserializer alloc] initWithXmlElement:rn] autorelease];
	return [deser complexTypeArrayFromElements:@"result" cls:[ZKSendEmailResult class]];
}

// Send outbound email
-(NSArray *)sendEmail:(NSArray *)messages {
	if (!authSource) return nil;
	[self checkSession];
	ZKEnvelope *env = [[[ZKPartnerEnvelope alloc] initWithSessionHeader:[authSource sessionId] clientId:clientId] autorelease];
	[env startElement:@"sendEmail"];
	[env addElement:@"messages" elemValue:messages];
	[env endElement:@"sendEmail"];
	[env endElement:@"s:Body"];
	zkElement *rn = [self sendRequest:[env end]];
	ZKXmlDeserializer *deser = [[[ZKXmlDeserializer alloc] initWithXmlElement:rn] autorelease];
	return [deser complexTypeArrayFromElements:@"result" cls:[ZKSendEmailResult class]];
}

// Perform a series of predefined actions such as quick create or log a task
-(NSArray *)performQuickActions:(NSArray *)quickActions {
	if (!authSource) return nil;
	[self checkSession];
	ZKEnvelope *env = [[[ZKPartnerEnvelope alloc] initWithSessionHeader:[authSource sessionId] clientId:clientId] autorelease];
	[env startElement:@"performQuickActions"];
	[env addElement:@"quickActions" elemValue:quickActions];
	[env endElement:@"performQuickActions"];
	[env endElement:@"s:Body"];
	zkElement *rn = [self sendRequest:[env end]];
	ZKXmlDeserializer *deser = [[[ZKXmlDeserializer alloc] initWithXmlElement:rn] autorelease];
	return [deser complexTypeArrayFromElements:@"result" cls:[ZKPerformQuickActionResult class]];
}

// Describe the details of a series of quick actions
-(NSArray *)describeQuickActions:(NSArray *)quickActions {
	if (!authSource) return nil;
	[self checkSession];
	ZKEnvelope *env = [[[ZKPartnerEnvelope alloc] initWithSessionHeader:[authSource sessionId] clientId:clientId] autorelease];
	[env startElement:@"describeQuickActions"];
	[env addElement:@"quickActions" elemValue:quickActions];
	[env endElement:@"describeQuickActions"];
	[env endElement:@"s:Body"];
	zkElement *rn = [self sendRequest:[env end]];
	ZKXmlDeserializer *deser = [[[ZKXmlDeserializer alloc] initWithXmlElement:rn] autorelease];
	return [deser complexTypeArrayFromElements:@"result" cls:[ZKDescribeQuickActionResult class]];
}

// Describe the details of a series of quick actions available for the given contextType
-(NSArray *)describeAvailableQuickActions:(NSString *)contextType {
	if (!authSource) return nil;
	[self checkSession];
	ZKEnvelope *env = [[[ZKPartnerEnvelope alloc] initWithSessionHeader:[authSource sessionId] clientId:clientId] autorelease];
	[env startElement:@"describeAvailableQuickActions"];
	[env addElement:@"contextType" elemValue:contextType];
	[env endElement:@"describeAvailableQuickActions"];
	[env endElement:@"s:Body"];
	zkElement *rn = [self sendRequest:[env end]];
	ZKXmlDeserializer *deser = [[[ZKXmlDeserializer alloc] initWithXmlElement:rn] autorelease];
	return [deser complexTypeArrayFromElements:@"result" cls:[ZKDescribeAvailableQuickActionResult class]];
}

@end
