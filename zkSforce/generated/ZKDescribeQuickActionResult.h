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

#import "ZKXMLSerializable.h"
#import "ZKComplexTypeFieldInfo.h"
#import "ZKXmlDeserializer.h"
#import "ZKParser.h"

@class ZKDescribeColor;
@class ZKDescribeQuickActionDefaultValue;
@class ZKDescribeIcon;
@class ZKDescribeLayoutSection;

/*
<complexType name="DescribeQuickActionResult" xmlns="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:fns="urn:fault.partner.soap.sforce.com" xmlns:tns="urn:partner.soap.sforce.com" xmlns:ens="urn:sobject.partner.soap.sforce.com">
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
    <element nillable="true" type="tns:ID" name="lightningWebComponentBundleId"/>
    <element nillable="true" type="xsd:string" name="lightningWebComponentBundleName"/>
    <element nillable="true" type="xsd:string" name="lightningWebComponentQualifiedName"/>
    <element nillable="true" type="xsd:string" name="miniIconUrl"/>
    <element nillable="true" type="xsd:string" name="mobileExtensionId"/>
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
@interface ZKDescribeQuickActionResult : ZKXmlDeserializer <ZKXMLSerializable> {
	UInt64   fields__set[1];
}
+(ZKComplexTypeInfo *)wsdlSchema;

@property (strong,nonatomic) NSString                                      *accessLevelRequired;
@property (strong,nonatomic) NSString                                      *actionEnumOrId;
@property (strong,nonatomic) NSString                                      *canvasApplicationId;
@property (strong,nonatomic) NSString                                      *canvasApplicationName;
@property (strong,nonatomic) NSArray<ZKDescribeColor *>                    *colors;
@property (strong,nonatomic) NSString                                      *contextSobjectType;
@property (strong,nonatomic) NSArray<ZKDescribeQuickActionDefaultValue *>  *defaultValues;
@property (strong,nonatomic) NSString                                      *flowDevName;
@property (strong,nonatomic) NSString                                      *flowRecordIdVar;
@property (assign,nonatomic) NSInteger                                      height;
@property (strong,nonatomic) NSString                                      *iconName;
@property (strong,nonatomic) NSString                                      *iconUrl;
@property (strong,nonatomic) NSArray<ZKDescribeIcon *>                     *icons;
@property (strong,nonatomic) NSString                                      *label;
@property (strong,nonatomic) ZKDescribeLayoutSection                       *layout;
@property (strong,nonatomic) NSString                                      *lightningComponentBundleId;
@property (strong,nonatomic) NSString                                      *lightningComponentBundleName;
@property (strong,nonatomic) NSString                                      *lightningComponentQualifiedName;
@property (strong,nonatomic) NSString                                      *lightningWebComponentBundleId;
@property (strong,nonatomic) NSString                                      *lightningWebComponentBundleName;
@property (strong,nonatomic) NSString                                      *lightningWebComponentQualifiedName;
@property (strong,nonatomic) NSString                                      *miniIconUrl;
@property (strong,nonatomic) NSString                                      *mobileExtensionId;
@property (strong,nonatomic) NSString                                      *name;
@property (assign,nonatomic) BOOL                                           showQuickActionLcHeader;
@property (assign,nonatomic) BOOL                                           showQuickActionVfHeader;
@property (strong,nonatomic) NSString                                      *targetParentField;
@property (strong,nonatomic) NSString                                      *targetRecordTypeId;
@property (strong,nonatomic) NSString                                      *targetSobjectType;
@property (strong,nonatomic) NSString                                      *type;
@property (strong,nonatomic) NSString                                      *visualforcePageName;
@property (strong,nonatomic) NSString                                      *visualforcePageUrl;
@property (assign,nonatomic) NSInteger                                      width;
@end
