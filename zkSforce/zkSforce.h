// Copyright (c) 2006,2011 Simon Fell
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
#import "zkSObject.h"
#import "zkSoapException.h"
#import "ZKLimitInfoHeader.h"
#import "ZKLimitInfo.h"
#import "ZKActionOverride.h"
#import "ZKAdditionalInformationMap.h"
#import "ZKAddress.h"
#import "ZKAllOrNoneHeader.h"
#import "ZKAllowFieldTruncationHeader.h"
#import "ZKAnalyticsCloudComponent.h"
#import "ZKAssignmentRuleHeader.h"
#import "ZKCallOptions.h"
#import "ZKCanvas.h"
#import "ZKChangeOwnPasswordResult.h"
#import "ZKChildRelationship.h"
#import "ZKCustomLinkComponent.h"
#import "ZKDataCategory.h"
#import "ZKDataCategoryGroupSobjectTypePair.h"
#import "ZKDebuggingHeader.h"
#import "ZKDeleteResult.h"
#import "ZKDeletedRecord.h"
#import "ZKDescribeAppMenuItem.h"
#import "ZKDescribeAppMenuResult.h"
#import "ZKDescribeApprovalLayout.h"
#import "ZKDescribeApprovalLayoutResult.h"
#import "ZKDescribeAvailableQuickActionResult.h"
#import "ZKDescribeColor.h"
#import "ZKDescribeColumn.h"
#import "ZKDescribeCompactLayout.h"
#import "ZKDescribeCompactLayoutsResult.h"
#import "ZKDescribeDataCategoryGroupResult.h"
#import "ZKDescribeDataCategoryGroupStructureResult.h"
#import "ZKDescribeField.h"
#import "ZKDescribeGlobalResult.h"
#import "ZKDescribeGlobalSObject.h"
#import "ZKDescribeGlobalTheme.h"
#import "ZKDescribeIcon.h"
#import "ZKDescribeLayout.h"
#import "ZKDescribeLayoutButton.h"
#import "ZKDescribeLayoutButtonSection.h"
#import "ZKDescribeLayoutComponent.h"
#import "ZKDescribeLayoutFeedFilter.h"
#import "ZKDescribeLayoutFeedView.h"
#import "ZKDescribeLayoutItem.h"
#import "ZKDescribeLayoutResult.h"
#import "ZKDescribeLayoutRow.h"
#import "ZKDescribeLayoutSaveOption.h"
#import "ZKDescribeLayoutSection.h"
#import "ZKDescribeNounResult.h"
#import "ZKDescribePathAssistant.h"
#import "ZKDescribePathAssistantField.h"
#import "ZKDescribePathAssistantStep.h"
#import "ZKDescribePathAssistantsResult.h"
#import "ZKDescribeQuickActionDefaultValue.h"
#import "ZKDescribeQuickActionListItemResult.h"
#import "ZKDescribeQuickActionListResult.h"
#import "ZKDescribeQuickActionResult.h"
#import "ZKDescribeRelatedContentItem.h"
#import "ZKDescribeSObject.h"
#import "ZKDescribeSearchLayoutResult.h"
#import "ZKDescribeSearchScopeOrderResult.h"
#import "ZKDescribeSearchableEntityResult.h"
#import "ZKDescribeSoftphoneLayoutCallType.h"
#import "ZKDescribeSoftphoneLayoutInfoField.h"
#import "ZKDescribeSoftphoneLayoutItem.h"
#import "ZKDescribeSoftphoneLayoutResult.h"
#import "ZKDescribeSoftphoneLayoutSection.h"
#import "ZKDescribeSoftphoneScreenPopOption.h"
#import "ZKDescribeSoqlListView.h"
#import "ZKDescribeSoqlListViewParams.h"
#import "ZKDescribeSoqlListViewResult.h"
#import "ZKDescribeSoqlListViewsRequest.h"
#import "ZKDescribeTab.h"
#import "ZKDescribeTabSetResult.h"
#import "ZKDescribeThemeItem.h"
#import "ZKDescribeThemeResult.h"
#import "ZKDescribeVisualForceResult.h"
#import "ZKDisableFeedTrackingHeader.h"
#import "ZKDuplicateError.h"
#import "ZKDuplicateResult.h"
#import "ZKDuplicateRuleHeader.h"
#import "ZKEmail.h"
#import "ZKEmailFileAttachment.h"
#import "ZKEmailHeader.h"
#import "ZKEmptyRecycleBinResult.h"
#import "ZKEntitySearchMetadata.h"
#import "ZKEntitySpellCorrectionMetadata.h"
#import "ZKError.h"
#import "ZKExecuteListViewRequest.h"
#import "ZKExecuteListViewResult.h"
#import "ZKExtendedErrorDetails.h"
#import "ZKFieldComponent.h"
#import "ZKFieldDiff.h"
#import "ZKFieldLayoutComponent.h"
#import "ZKFieldLevelSearchMetadata.h"
#import "ZKFilteredLookupInfo.h"
#import "ZKFindDuplicatesResult.h"
#import "ZKGetDeletedResult.h"
#import "ZKGetServerTimestampResult.h"
#import "ZKGetUpdatedResult.h"
#import "ZKInvalidateSessionsResult.h"
#import "ZKKnowledgeLanguageItem.h"
#import "ZKKnowledgeSettings.h"
#import "ZKLabelsSearchMetadata.h"
#import "ZKLeadConvert.h"
#import "ZKLeadConvertResult.h"
#import "ZKListViewColumn.h"
#import "ZKListViewOrderBy.h"
#import "ZKListViewRecord.h"
#import "ZKListViewRecordColumn.h"
#import "ZKLocaleOptions.h"
#import "ZKLocation.h"
#import "ZKLogInfo.h"
#import "ZKLoginResult.h"
#import "ZKLoginScopeHeader.h"
#import "ZKMassEmailMessage.h"
#import "ZKMatchRecord.h"
#import "ZKMatchResult.h"
#import "ZKMergeRequest.h"
#import "ZKMergeResult.h"
#import "ZKMruHeader.h"
#import "ZKNameCaseValue.h"
#import "ZKNameValuePair.h"
#import "ZKNamedLayoutInfo.h"
#import "ZKOwnerChangeOption.h"
#import "ZKOwnerChangeOptions.h"
#import "ZKPackageVersion.h"
#import "ZKPackageVersionHeader.h"
#import "ZKPerformQuickActionRequest.h"
#import "ZKPerformQuickActionResult.h"
#import "ZKPicklistEntry.h"
#import "ZKPicklistForRecordType.h"
#import "ZKProcessRequest.h"
#import "ZKProcessResult.h"
#import "ZKProcessSubmitRequest.h"
#import "ZKProcessWorkitemRequest.h"
#import "ZKQueryOptions.h"
#import "ZKQuickActionTemplateResult.h"
#import "ZKRecordTypeCompactLayoutMapping.h"
#import "ZKRecordTypeInfo.h"
#import "ZKRecordTypeMapping.h"
#import "ZKRelatedContent.h"
#import "ZKRelatedList.h"
#import "ZKRelatedListColumn.h"
#import "ZKRelatedListSort.h"
#import "ZKRenderEmailTemplateBodyResult.h"
#import "ZKRenderEmailTemplateError.h"
#import "ZKRenderEmailTemplateRequest.h"
#import "ZKRenderEmailTemplateResult.h"
#import "ZKRenderStoredEmailTemplateRequest.h"
#import "ZKRenderStoredEmailTemplateResult.h"
#import "ZKReportChartComponent.h"
#import "ZKResetPasswordResult.h"
#import "ZKSaveResult.h"
#import "ZKScopeInfo.h"
#import "ZKSearchRecord.h"
#import "ZKSearchRecordMetadata.h"
#import "ZKSearchResult.h"
#import "ZKSearchResultsMetadata.h"
#import "ZKSearchSnippet.h"
#import "ZKSendEmailError.h"
#import "ZKSendEmailResult.h"
#import "ZKSessionHeader.h"
#import "ZKSetPasswordResult.h"
#import "ZKSingleEmailMessage.h"
#import "ZKSoqlCondition.h"
#import "ZKSoqlConditionGroup.h"
#import "ZKSoqlNotCondition.h"
#import "ZKSoqlSubQueryCondition.h"
#import "ZKSoqlWhereCondition.h"
#import "ZKStreamingEnabledHeader.h"
#import "ZKUndeleteResult.h"
#import "ZKUpsertResult.h"
#import "ZKUserInfo.h"
#import "ZKUserTerritoryDeleteHeader.h"
#import "ZKVisualforcePage.h"
#import "ZKDescribeField+Extras.h"
#import "ZKDescribeSObject+Extras.h"
#import "zkQueryResult+NSTableView.h"
#import "ZKRelatedList+Extras.h"
#import "ZKSaveResult+Extras.h"
#import "ZKSforceClient+Operations.h"
#import "ZKSforceClient+zkAsyncQuery.h"
#import "ZKUserInfo+Extras.h"
