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

#import "zkXmlDeserializer.h"

/*
<complexType name="DescribeQuickActionResult" xmlns="http://www.w3.org/2001/XMLSchema" xmlns:ens="urn:sobject.partner.soap.sforce.com" xmlns:tns="urn:partner.soap.sforce.com" xmlns:fns="urn:fault.partner.soap.sforce.com" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns="http://schemas.xmlsoap.org/wsdl/">
  <sequence>
    <element nillable="true" type="xsd:string" name="canvasApplicationName"/>
    <element maxOccurs="unbounded" minOccurs="0" type="tns:DescribeColor" name="colors"/>
    <element maxOccurs="unbounded" minOccurs="0" nillable="true" type="tns:DescribeQuickActionDefaultValue" name="defaultValues"/>
    <element nillable="true" type="xsd:int" name="height"/>
    <element nillable="true" type="xsd:string" name="iconName"/>
    <element nillable="true" type="xsd:string" name="iconUrl"/>
    <element maxOccurs="unbounded" minOccurs="0" type="tns:DescribeIcon" name="icons"/>
    <element type="xsd:string" name="label"/>
    <element maxOccurs="unbounded" minOccurs="0" type="tns:DescribeLayoutSection" name="layout"/>
    <element nillable="true" type="xsd:string" name="miniIconUrl"/>
    <element type="xsd:string" name="name"/>
    <element nillable="true" type="xsd:string" name="sourceSobjectType"/>
    <element nillable="true" type="xsd:string" name="targetParentField"/>
    <element nillable="true" type="tns:ID" name="targetRecordTypeId"/>
    <element nillable="true" type="xsd:string" name="targetSobjectType"/>
    <element type="xsd:string" name="type"/>
    <element nillable="true" type="xsd:string" name="visualforcePageName"/>
    <element nillable="true" type="xsd:int" name="width"/>
  </sequence>
</complexType>
*/
@interface ZKDescribeQuickActionResult : ZKXmlDeserializer {
}
@property (readonly) NSString  *canvasApplicationName; 
@property (readonly) NSArray   *colors;  // of ZKDescribeColor
@property (readonly) NSArray   *defaultValues;  // of ZKDescribeQuickActionDefaultValue
@property (readonly) NSInteger  height; 
@property (readonly) NSString  *iconName; 
@property (readonly) NSString  *iconUrl; 
@property (readonly) NSArray   *icons;  // of ZKDescribeIcon
@property (readonly) NSString  *label; 
@property (readonly) NSArray   *layout;  // of ZKDescribeLayoutSection
@property (readonly) NSString  *miniIconUrl; 
@property (readonly) NSString  *name; 
@property (readonly) NSString  *sourceSobjectType; 
@property (readonly) NSString  *targetParentField; 
@property (readonly) NSString  *targetRecordTypeId; 
@property (readonly) NSString  *targetSobjectType; 
@property (readonly) NSString  *type; 
@property (readonly) NSString  *visualforcePageName; 
@property (readonly) NSInteger  width; 
@end
