// Copyright (c) 2016 Simon Fell
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

@class ZKDuplicateResult;
@class ZKError;

/*
<complexType name="FindDuplicatesResult" xmlns="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:fns="urn:fault.partner.soap.sforce.com" xmlns:tns="urn:partner.soap.sforce.com" xmlns:ens="urn:sobject.partner.soap.sforce.com">
  <sequence>
    <element maxOccurs="unbounded" minOccurs="0" type="tns:DuplicateResult" name="duplicateResults"/>
    <element maxOccurs="unbounded" minOccurs="0" type="tns:Error" name="errors"/>
    <element type="xsd:boolean" name="success"/>
  </sequence>
</complexType>
*/
@interface ZKFindDuplicatesResult : ZKXmlDeserializer <ZKXMLSerializable> {
	UInt16   fields__set[1];
}
+(ZKComplexTypeInfo *)wsdlSchema;

@property (strong,nonatomic) NSArray<ZKDuplicateResult *>  *duplicateResults;
@property (strong,nonatomic) NSArray<ZKError *>            *errors;
@property (assign,nonatomic) BOOL                           success;
@end
