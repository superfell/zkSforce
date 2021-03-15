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

#import "ZKSoqlWhereCondition.h"
#import "ZKComplexTypeFieldInfo.h"
#import "ZKXmlDeserializer.h"
#import "ZKParser.h"

/*
<complexType name="SoqlCondition" xmlns="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:fns="urn:fault.partner.soap.sforce.com" xmlns:tns="urn:partner.soap.sforce.com" xmlns:ens="urn:sobject.partner.soap.sforce.com">
  <complexContent>
    <extension base="tns:SoqlWhereCondition">
      <sequence>
        <element type="xsd:string" name="field"/>
        <element type="tns:soqlOperator" name="operator"/>
        <element maxOccurs="unbounded" minOccurs="1" type="xsd:string" name="values"/>
      </sequence>
    </extension>
  </complexContent>
</complexType>
*/
@interface ZKSoqlCondition : ZKSoqlWhereCondition  {
	UInt16   fields__set2[1];
}
+(ZKComplexTypeInfo *)wsdlSchema;

@property (strong,nonatomic) NSString             *field;
@property (strong,nonatomic) NSString             *operator;
@property (strong,nonatomic) NSArray<NSString *>  *values;
@end
