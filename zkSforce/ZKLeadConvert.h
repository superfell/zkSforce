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

#import "ZKXMLSerializable.h"

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
@interface ZKLeadConvert : NSObject<ZKXMLSerializable> {
    NSString *accountId;
    NSString *contactId;
    NSString *convertedStatus;
    NSString *leadId;
    NSString *opportunityName;
    NSString *ownerId;
    BOOL doNotCreateOpportunity;
    BOOL overwriteLeadSource;
    BOOL sendNotificationEmail;
}

@property (retain) NSString *accountId;
@property (retain) NSString *contactId;
@property (retain) NSString *convertedStatus;
@property (assign) BOOL doNotCreateOpportunity;
@property (retain) NSString *leadId;
@property (retain) NSString *opportunityName;
@property (assign) BOOL overwriteLeadSource;
@property (retain) NSString *ownerId;
@property (assign) BOOL sendNotificationEmail;

@end
