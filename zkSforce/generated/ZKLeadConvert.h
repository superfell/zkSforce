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

#import "ZKXMLSerializable.h"

@class ZKSObject;
@class ZKSObject;
@class ZKSObject;
/*
<complexType name="LeadConvert" xmlns="http://www.w3.org/2001/XMLSchema" xmlns:ens="urn:sobject.partner.soap.sforce.com" xmlns:tns="urn:partner.soap.sforce.com" xmlns:fns="urn:fault.partner.soap.sforce.com" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns="http://schemas.xmlsoap.org/wsdl/">
  <sequence>
    <element nillable="true" type="tns:ID" name="accountId"/>
    <element nillable="true" type="ens:sObject" name="accountRecord"/>
    <element nillable="true" type="xsd:boolean" name="bypassAccountDedupeCheck"/>
    <element nillable="true" type="xsd:boolean" name="bypassContactDedupeCheck"/>
    <element nillable="true" type="tns:ID" name="contactId"/>
    <element nillable="true" type="ens:sObject" name="contactRecord"/>
    <element type="xsd:string" name="convertedStatus"/>
    <element type="xsd:boolean" name="doNotCreateOpportunity"/>
    <element type="tns:ID" name="leadId"/>
    <element nillable="true" type="tns:ID" name="opportunityId"/>
    <element nillable="true" type="xsd:string" name="opportunityName"/>
    <element nillable="true" type="ens:sObject" name="opportunityRecord"/>
    <element type="xsd:boolean" name="overwriteLeadSource"/>
    <element nillable="true" type="tns:ID" name="ownerId"/>
    <element type="xsd:boolean" name="sendNotificationEmail"/>
  </sequence>
</complexType>
*/
@interface ZKLeadConvert : NSObject<ZKXMLSerializable> {
}
@property (strong) NSString   *accountId; 
@property (strong) ZKSObject  *accountRecord; 
@property (assign) BOOL        bypassAccountDedupeCheck; 
@property (assign) BOOL        bypassContactDedupeCheck; 
@property (strong) NSString   *contactId; 
@property (strong) ZKSObject  *contactRecord; 
@property (strong) NSString   *convertedStatus; 
@property (assign) BOOL        doNotCreateOpportunity; 
@property (strong) NSString   *leadId; 
@property (strong) NSString   *opportunityId; 
@property (strong) NSString   *opportunityName; 
@property (strong) ZKSObject  *opportunityRecord; 
@property (assign) BOOL        overwriteLeadSource; 
@property (strong) NSString   *ownerId; 
@property (assign) BOOL        sendNotificationEmail; 
@end