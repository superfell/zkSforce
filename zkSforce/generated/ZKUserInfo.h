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

/*
<complexType name="GetUserInfoResult" xmlns="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:fns="urn:fault.partner.soap.sforce.com" xmlns:tns="urn:partner.soap.sforce.com" xmlns:ens="urn:sobject.partner.soap.sforce.com">
  <sequence>
    <element type="xsd:boolean" name="accessibilityMode"/>
    <element type="xsd:boolean" name="chatterExternal"/>
    <element nillable="true" type="xsd:string" name="currencySymbol"/>
    <element type="xsd:int" name="orgAttachmentFileSizeLimit"/>
    <element nillable="true" type="xsd:string" name="orgDefaultCurrencyIsoCode"/>
    <element nillable="true" type="xsd:string" name="orgDefaultCurrencyLocale"/>
    <element type="xsd:boolean" name="orgDisallowHtmlAttachments"/>
    <element type="xsd:boolean" name="orgHasPersonAccounts"/>
    <element type="tns:ID" name="organizationId"/>
    <element type="xsd:boolean" name="organizationMultiCurrency"/>
    <element type="xsd:string" name="organizationName"/>
    <element type="tns:ID" name="profileId"/>
    <element nillable="true" type="tns:ID" name="roleId"/>
    <element type="xsd:int" name="sessionSecondsValid"/>
    <element nillable="true" type="xsd:string" name="userDefaultCurrencyIsoCode"/>
    <element type="xsd:string" name="userEmail"/>
    <element type="xsd:string" name="userFullName"/>
    <element type="tns:ID" name="userId"/>
    <element type="xsd:string" name="userLanguage"/>
    <element type="xsd:string" name="userLocale"/>
    <element type="xsd:string" name="userName"/>
    <element type="xsd:string" name="userTimeZone"/>
    <element type="xsd:string" name="userType"/>
    <element type="xsd:string" name="userUiSkin"/>
  </sequence>
</complexType>
*/
@interface ZKUserInfo : ZKXmlDeserializer <ZKXMLSerializable> {
	UInt32   fields__set[1];
}
+(ZKComplexTypeInfo *)wsdlSchema;

@property (assign,nonatomic) BOOL       accessibilityMode;
@property (assign,nonatomic) BOOL       chatterExternal;
@property (strong,nonatomic) NSString  *currencySymbol;
@property (assign,nonatomic) NSInteger  orgAttachmentFileSizeLimit;
@property (strong,nonatomic) NSString  *orgDefaultCurrencyIsoCode;
@property (strong,nonatomic) NSString  *orgDefaultCurrencyLocale;
@property (assign,nonatomic) BOOL       orgDisallowHtmlAttachments;
@property (assign,nonatomic) BOOL       orgHasPersonAccounts;
@property (strong,nonatomic) NSString  *organizationId;
@property (assign,nonatomic) BOOL       organizationMultiCurrency;
@property (strong,nonatomic) NSString  *organizationName;
@property (strong,nonatomic) NSString  *profileId;
@property (strong,nonatomic) NSString  *roleId;
@property (assign,nonatomic) NSInteger  sessionSecondsValid;
@property (strong,nonatomic) NSString  *userDefaultCurrencyIsoCode;
@property (strong,nonatomic) NSString  *userEmail;
@property (strong,nonatomic) NSString  *userFullName;
@property (strong,nonatomic) NSString  *userId;
@property (strong,nonatomic) NSString  *userLanguage;
@property (strong,nonatomic) NSString  *userLocale;
@property (strong,nonatomic) NSString  *userName;
@property (strong,nonatomic) NSString  *userTimeZone;
@property (strong,nonatomic) NSString  *userType;
@property (strong,nonatomic) NSString  *userUiSkin;
@end
