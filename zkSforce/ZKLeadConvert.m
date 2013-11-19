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

#import "ZKLeadConvert.h"
#import "zkEnvelope.h"

@implementation ZKLeadConvert

@synthesize accountId, contactId, convertedStatus, doNotCreateOpportunity, leadId, opportunityName, overwriteLeadSource, ownerId, sendNotificationEmail;

-(void)dealloc {
    [accountId release];
    [contactId release];
    [convertedStatus release];
    [leadId release];
    [opportunityName release];
    [ownerId release];
    [super dealloc];
}

//<complexType name="LeadConvert">
//<sequence>
//<element name="accountId"              type="tns:ID" nillable="true"/>
//<element name="contactId"              type="tns:ID" nillable="true"/>
//<element name="convertedStatus"        type="xsd:string"/>
//<element name="doNotCreateOpportunity" type="xsd:boolean"/>
//<element name="leadId"                 type="tns:ID"/>
//<element name="opportunityName"        type="xsd:string" nillable="true"/>
//<element name="overwriteLeadSource"    type="xsd:boolean"/>
//<element name="ownerId"                type="tns:ID"     nillable="true"/>
//<element name="sendNotificationEmail"  type="xsd:boolean"/>
//</sequence>
//</complexType>
-(void)serializeToEnvelope:(ZKEnvelope *)env {
    [env startElement:@"leadConverts"];
    [env addElement:@"accountId"                    elemValue:self.accountId];
    [env addElement:@"contactId"                    elemValue:self.contactId];
    [env addElement:@"convertedStatus"              elemValue:self.convertedStatus];
    [env addBoolElement:@"doNotCreateOpportunity"   elemValue:self.doNotCreateOpportunity];
    [env addElement:@"leadId"                       elemValue:self.leadId];
    [env addElement:@"opportunityName"              elemValue:self.opportunityName];
    [env addBoolElement:@"overwriteLeadSource"      elemValue:self.overwriteLeadSource];
    [env addElement:@"ownerId"                      elemValue:self.ownerId];
    [env addBoolElement:@"sendNotificationEmail"    elemValue:self.sendNotificationEmail];
    [env endElement:@"leadConverts"];
}

@end
