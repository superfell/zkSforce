// Copyright (c) 2014 Simon Fell
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

/*
<complexType name="ListViewColumn" xmlns="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:fns="urn:fault.partner.soap.sforce.com" xmlns:tns="urn:partner.soap.sforce.com" xmlns:ens="urn:sobject.partner.soap.sforce.com">
  <sequence>
    <element nillable="true" type="xsd:string" name="ascendingLabel"/>
    <element nillable="true" type="xsd:string" name="descendingLabel"/>
    <element type="xsd:string" name="fieldNameOrPath"/>
    <element type="xsd:boolean" name="hidden"/>
    <element type="xsd:string" name="label"/>
    <element type="xsd:boolean" name="searchable"/>
    <element type="xsd:string" name="selectListItem"/>
    <element nillable="true" type="tns:orderByDirection" name="sortDirection"/>
    <element nillable="true" type="xsd:int" name="sortIndex"/>
    <element type="xsd:boolean" name="sortable"/>
    <element type="tns:fieldType" name="type"/>
  </sequence>
</complexType>
*/
@interface ZKListViewColumn : ZKXmlDeserializer <ZKXMLSerializable> {
	UInt16   fields__set[1];
}
+(ZKComplexTypeInfo *)wsdlSchema;

@property (strong,nonatomic) NSString  *ascendingLabel;
@property (strong,nonatomic) NSString  *descendingLabel;
@property (strong,nonatomic) NSString  *fieldNameOrPath;
@property (assign,nonatomic) BOOL       hidden;
@property (strong,nonatomic) NSString  *label;
@property (assign,nonatomic) BOOL       searchable;
@property (strong,nonatomic) NSString  *selectListItem;
@property (strong,nonatomic) NSString  *sortDirection;
@property (assign,nonatomic) NSInteger  sortIndex;
@property (assign,nonatomic) BOOL       sortable;
@property (strong,nonatomic) NSString  *type;
@end
