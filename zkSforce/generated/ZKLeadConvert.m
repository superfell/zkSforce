// Copyright (c) 2013 Simon Fell
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

#import "ZKLeadConvert.h"
#import "ZKEnvelope.h"

@implementation ZKLeadConvert

@synthesize accountId, accountRecord, bypassAccountDedupeCheck, bypassContactDedupeCheck, contactId, contactRecord, convertedStatus, doNotCreateOpportunity, leadId, opportunityId, opportunityName, opportunityRecord, overwriteLeadSource, ownerId, relatedPersonAccountId, relatedPersonAccountRecord, sendNotificationEmail;

-(void)serializeTo:(ZKXmlWriter *)env elemName:(NSString *)elemName {
	[env startElement:elemName];
	[env addElement:@"accountId"                    elemValue:self.accountId                  nillable:YES optional:NO];
	[env addElement:@"accountRecord"                elemValue:self.accountRecord              nillable:YES optional:NO];
	[env addBoolElement:@"bypassAccountDedupeCheck" elemValue:self.bypassAccountDedupeCheck];
	[env addBoolElement:@"bypassContactDedupeCheck" elemValue:self.bypassContactDedupeCheck];
	[env addElement:@"contactId"                    elemValue:self.contactId                  nillable:YES optional:NO];
	[env addElement:@"contactRecord"                elemValue:self.contactRecord              nillable:YES optional:NO];
	[env addElement:@"convertedStatus"              elemValue:self.convertedStatus            nillable:NO  optional:NO];
	[env addBoolElement:@"doNotCreateOpportunity"   elemValue:self.doNotCreateOpportunity];
	[env addElement:@"leadId"                       elemValue:self.leadId                     nillable:NO  optional:NO];
	[env addElement:@"opportunityId"                elemValue:self.opportunityId              nillable:YES optional:NO];
	[env addElement:@"opportunityName"              elemValue:self.opportunityName            nillable:YES optional:NO];
	[env addElement:@"opportunityRecord"            elemValue:self.opportunityRecord          nillable:YES optional:NO];
	[env addBoolElement:@"overwriteLeadSource"      elemValue:self.overwriteLeadSource];
	[env addElement:@"ownerId"                      elemValue:self.ownerId                    nillable:YES optional:NO];
	[env addElement:@"relatedPersonAccountId"       elemValue:self.relatedPersonAccountId     nillable:YES optional:NO];
	[env addElement:@"relatedPersonAccountRecord"   elemValue:self.relatedPersonAccountRecord nillable:YES optional:NO];
	[env addBoolElement:@"sendNotificationEmail"    elemValue:self.sendNotificationEmail];
	[env endElement:elemName];
}
@end
