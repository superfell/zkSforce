// Copyright (c) 2010 Ron Hess
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

#import "zkXmlDeserializer.h"

/*
<complexType name="DescribeLayoutButton" xmlns="http://www.w3.org/2001/XMLSchema" xmlns:ens="urn:sobject.partner.soap.sforce.com" xmlns:tns="urn:partner.soap.sforce.com" xmlns:fns="urn:fault.partner.soap.sforce.com" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns="http://schemas.xmlsoap.org/wsdl/">
  <sequence>
    <element minOccurs="0" nillable="true" type="tns:WebLinkWindowType" name="behavior"/>
    <element maxOccurs="unbounded" minOccurs="0" type="tns:DescribeColor" name="colors"/>
    <element minOccurs="0" nillable="true" type="xsd:string" name="content"/>
    <element minOccurs="0" nillable="true" type="tns:WebLinkType" name="contentSource"/>
    <element type="xsd:boolean" name="custom"/>
    <element minOccurs="0" nillable="true" type="xsd:string" name="encoding"/>
    <element minOccurs="0" nillable="true" type="xsd:int" name="height"/>
    <element maxOccurs="unbounded" minOccurs="0" type="tns:DescribeIcon" name="icons"/>
    <element nillable="true" type="xsd:string" name="label"/>
    <element nillable="true" type="xsd:boolean" name="menubar"/>
    <element nillable="true" type="xsd:string" name="name"/>
    <element type="xsd:boolean" name="overridden"/>
    <element nillable="true" type="xsd:boolean" name="resizeable"/>
    <element nillable="true" type="xsd:boolean" name="scrollbars"/>
    <element nillable="true" type="xsd:boolean" name="showsLocation"/>
    <element nillable="true" type="xsd:boolean" name="showsStatus"/>
    <element nillable="true" type="xsd:boolean" name="toolbar"/>
    <element minOccurs="0" nillable="true" type="xsd:string" name="url"/>
    <element minOccurs="0" nillable="true" type="xsd:int" name="width"/>
    <element minOccurs="0" nillable="true" type="tns:WebLinkPosition" name="windowPosition"/>
  </sequence>
</complexType>
*/
@interface ZKDescribeLayoutButton : ZKXmlDeserializer {
}
@property (weak, readonly) NSString  *behavior; 
@property (weak, readonly) NSArray   *colors;  // of ZKDescribeColor
@property (weak, readonly) NSString  *content; 
@property (weak, readonly) NSString  *contentSource; 
@property (readonly) BOOL             custom; 
@property (weak, readonly) NSString  *encoding; 
@property (readonly) NSInteger        height; 
@property (weak, readonly) NSArray   *icons;  // of ZKDescribeIcon
@property (weak, readonly) NSString  *label; 
@property (readonly) BOOL             menubar; 
@property (weak, readonly) NSString  *name; 
@property (readonly) BOOL             overridden; 
@property (readonly) BOOL             resizeable; 
@property (readonly) BOOL             scrollbars; 
@property (readonly) BOOL             showsLocation; 
@property (readonly) BOOL             showsStatus; 
@property (readonly) BOOL             toolbar; 
@property (weak, readonly) NSString  *url; 
@property (readonly) NSInteger        width; 
@property (weak, readonly) NSString  *windowPosition; 
@end
