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

#import "ZKXmlDeserializer.h"

@class ZKDescribeLayoutSection;
/*
<complexType name="DescribeQuickActionResult" xmlns="http://www.w3.org/2001/XMLSchema" xmlns:ens="urn:sobject.partner.soap.sforce.com" xmlns:tns="urn:partner.soap.sforce.com" xmlns:fns="urn:fault.partner.soap.sforce.com" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns="http://schemas.xmlsoap.org/wsdl/">
  <sequence>
    <element nillable="true" type="tns:ShareAccessLevel" name="accessLevelRequired"/>
    <element type="xsd:string" name="actionEnumOrId"/>
    <element nillable="true" type="tns:ID" name="canvasApplicationId"/>
    <element nillable="true" type="xsd:string" name="canvasApplicationName"/>
    <element maxOccurs="unbounded" minOccurs="0" type="tns:DescribeColor" name="colors"/>
    <element nillable="true" type="xsd:string" name="contextSobjectType"/>
    <element maxOccurs="unbounded" minOccurs="0" nillable="true" type="tns:DescribeQuickActionDefaultValue" name="defaultValues"/>
    <element nillable="true" type="xsd:string" name="flowDevName"/>
    <element nillable="true" type="xsd:string" name="flowRecordIdVar"/>
    <element nillable="true" type="xsd:int" name="height"/>
    <element nillable="true" type="xsd:string" name="iconName"/>
    <element nillable="true" type="xsd:string" name="iconUrl"/>
    <element maxOccurs="unbounded" minOccurs="0" type="tns:DescribeIcon" name="icons"/>
    <element type="xsd:string" name="label"/>
    <element nillable="true" type="tns:DescribeLayoutSection" name="layout"/>
    <element nillable="true" type="tns:ID" name="lightningComponentBundleId"/>
    <element nillable="true" type="xsd:string" name="lightningComponentBundleName"/>
    <element nillable="true" type="xsd:string" name="lightningComponentQualifiedName"/>
    <element nillable="true" type="xsd:string" name="miniIconUrl"/>
    <element type="xsd:string" name="name"/>
    <element type="xsd:boolean" name="showQuickActionLcHeader"/>
    <element type="xsd:boolean" name="showQuickActionVfHeader"/>
    <element nillable="true" type="xsd:string" name="targetParentField"/>
    <element nillable="true" type="tns:ID" name="targetRecordTypeId"/>
    <element nillable="true" type="xsd:string" name="targetSobjectType"/>
    <element type="xsd:string" name="type"/>
    <element nillable="true" type="xsd:string" name="visualforcePageName"/>
    <element nillable="true" type="xsd:string" name="visualforcePageUrl"/>
    <element nillable="true" type="xsd:int" name="width"/>
  </sequence>
</complexType>
*/
@interface ZKDescribeQuickActionResult : ZKXmlDeserializer {
}
@property (weak, readonly) NSString                 *accessLevelRequired; 
@property (weak, readonly) NSString                 *actionEnumOrId; 
@property (weak, readonly) NSString                 *canvasApplicationId; 
@property (weak, readonly) NSString                 *canvasApplicationName; 
@property (weak, readonly) NSArray                  *colors;  // of ZKDescribeColor
@property (weak, readonly) NSString                 *contextSobjectType; 
@property (weak, readonly) NSArray                  *defaultValues;  // of ZKDescribeQuickActionDefaultValue
@property (weak, readonly) NSString                 *flowDevName; 
@property (weak, readonly) NSString                 *flowRecordIdVar; 
@property (readonly) NSInteger                       height; 
@property (weak, readonly) NSString                 *iconName; 
@property (weak, readonly) NSString                 *iconUrl; 
@property (weak, readonly) NSArray                  *icons;  // of ZKDescribeIcon
@property (weak, readonly) NSString                 *label; 
@property (weak, readonly) ZKDescribeLayoutSection  *layout; 
@property (weak, readonly) NSString                 *lightningComponentBundleId; 
@property (weak, readonly) NSString                 *lightningComponentBundleName; 
@property (weak, readonly) NSString                 *lightningComponentQualifiedName; 
@property (weak, readonly) NSString                 *miniIconUrl; 
@property (weak, readonly) NSString                 *name; 
@property (readonly) BOOL                            showQuickActionLcHeader; 
@property (readonly) BOOL                            showQuickActionVfHeader; 
@property (weak, readonly) NSString                 *targetParentField; 
@property (weak, readonly) NSString                 *targetRecordTypeId; 
@property (weak, readonly) NSString                 *targetSobjectType; 
@property (weak, readonly) NSString                 *type; 
@property (weak, readonly) NSString                 *visualforcePageName; 
@property (weak, readonly) NSString                 *visualforcePageUrl; 
@property (readonly) NSInteger                       width; 
@end
