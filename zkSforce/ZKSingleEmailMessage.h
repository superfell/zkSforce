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

#import "ZKEmail.h"

/*
<complexType name="SingleEmailMessage" xmlns="http://www.w3.org/2001/XMLSchema" xmlns:ens="urn:sobject.partner.soap.sforce.com" xmlns:tns="urn:partner.soap.sforce.com" xmlns:fns="urn:fault.partner.soap.sforce.com" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns="http://schemas.xmlsoap.org/wsdl/">
  <complexContent>
    <extension base="tns:Email">
      <sequence>
        <element nillable="true" type="xsd:string" maxOccurs="25" minOccurs="0" name="bccAddresses"/>
        <element nillable="true" type="xsd:string" maxOccurs="25" minOccurs="0" name="ccAddresses"/>
        <element nillable="true" type="xsd:string" name="charset"/>
        <element type="tns:ID" maxOccurs="unbounded" minOccurs="0" name="documentAttachments"/>
        <element type="tns:ID" maxOccurs="unbounded" minOccurs="0" name="entityAttachments"/>
        <element type="tns:EmailFileAttachment" maxOccurs="unbounded" minOccurs="0" name="fileAttachments"/>
        <element nillable="true" type="xsd:string" name="htmlBody"/>
        <element nillable="true" type="xsd:string" minOccurs="0" name="inReplyTo"/>
        <element nillable="true" type="tns:SendEmailOptOutPolicy" name="optOutPolicy"/>
        <element nillable="true" type="tns:ID" maxOccurs="1" minOccurs="0" name="orgWideEmailAddressId"/>
        <element nillable="true" type="xsd:string" name="plainTextBody"/>
        <element nillable="true" type="xsd:string" minOccurs="0" name="references"/>
        <element nillable="true" type="tns:ID" name="targetObjectId"/>
        <element nillable="true" type="tns:ID" name="templateId"/>
        <element nillable="true" type="xsd:string" minOccurs="0" name="templateName"/>
        <element nillable="true" type="xsd:string" maxOccurs="100" minOccurs="0" name="toAddresses"/>
        <element nillable="true" type="xsd:boolean" name="treatBodiesAsTemplate"/>
        <element nillable="true" type="xsd:boolean" name="treatTargetObjectAsRecipient"/>
        <element nillable="true" type="tns:ID" name="whatId"/>
      </sequence>
    </extension>
  </complexContent>
</complexType>
*/
@interface ZKSingleEmailMessage : ZKEmail {
}
@property (weak, readonly) NSArray   *bccAddresses;  // of NSString
@property (weak, readonly) NSArray   *ccAddresses;  // of NSString
@property (weak, readonly) NSString  *charset; 
@property (weak, readonly) NSArray   *documentAttachments;  // of NSString
@property (weak, readonly) NSArray   *entityAttachments;  // of NSString
@property (weak, readonly) NSArray   *fileAttachments;  // of ZKEmailFileAttachment
@property (weak, readonly) NSString  *htmlBody; 
@property (weak, readonly) NSString  *inReplyTo; 
@property (weak, readonly) NSString  *optOutPolicy; 
@property (weak, readonly) NSString  *orgWideEmailAddressId; 
@property (weak, readonly) NSString  *plainTextBody; 
@property (weak, readonly) NSString  *references; 
@property (weak, readonly) NSString  *targetObjectId; 
@property (weak, readonly) NSString  *templateId; 
@property (weak, readonly) NSString  *templateName; 
@property (weak, readonly) NSArray   *toAddresses;  // of NSString
@property (readonly) BOOL             treatBodiesAsTemplate; 
@property (readonly) BOOL             treatTargetObjectAsRecipient; 
@property (weak, readonly) NSString  *whatId; 
@end
