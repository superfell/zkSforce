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

#import "ZKUserInfo.h"
#import "ZKEnvelope.h"

@interface ZKUserInfo()
@property (assign,nonatomic) BOOL       accessibilityMode__v;
@property (assign,nonatomic) BOOL       chatterExternal__v;
@property (strong,nonatomic) NSString  *currencySymbol__v;
@property (assign,nonatomic) NSInteger  orgAttachmentFileSizeLimit__v;
@property (strong,nonatomic) NSString  *orgDefaultCurrencyIsoCode__v;
@property (strong,nonatomic) NSString  *orgDefaultCurrencyLocale__v;
@property (assign,nonatomic) BOOL       orgDisallowHtmlAttachments__v;
@property (assign,nonatomic) BOOL       orgHasPersonAccounts__v;
@property (strong,nonatomic) NSString  *organizationId__v;
@property (assign,nonatomic) BOOL       organizationMultiCurrency__v;
@property (strong,nonatomic) NSString  *organizationName__v;
@property (strong,nonatomic) NSString  *profileId__v;
@property (strong,nonatomic) NSString  *roleId__v;
@property (assign,nonatomic) NSInteger  sessionSecondsValid__v;
@property (strong,nonatomic) NSString  *userDefaultCurrencyIsoCode__v;
@property (strong,nonatomic) NSString  *userEmail__v;
@property (strong,nonatomic) NSString  *userFullName__v;
@property (strong,nonatomic) NSString  *userId__v;
@property (strong,nonatomic) NSString  *userLanguage__v;
@property (strong,nonatomic) NSString  *userLocale__v;
@property (strong,nonatomic) NSString  *userName__v;
@property (strong,nonatomic) NSString  *userTimeZone__v;
@property (strong,nonatomic) NSString  *userType__v;
@property (strong,nonatomic) NSString  *userUiSkin__v;
@end

@implementation ZKUserInfo


+(void)load {
    [self registerType:self xmlName:@"GetUserInfoResult"];
}

-(BOOL)accessibilityMode {
    if ((fields__set[0] & 0x1) == 0) {
        self.accessibilityMode__v = [self boolean:@"accessibilityMode"];
        fields__set[0] |= 0x1; 
    }
    return self.accessibilityMode__v;
}
        

-(void)setAccessibilityMode:(BOOL)v {
    self.accessibilityMode__v = v;
    fields__set[0] |= 0x1; 
}
        

-(BOOL)chatterExternal {
    if ((fields__set[0] & 0x2) == 0) {
        self.chatterExternal__v = [self boolean:@"chatterExternal"];
        fields__set[0] |= 0x2; 
    }
    return self.chatterExternal__v;
}
        

-(void)setChatterExternal:(BOOL)v {
    self.chatterExternal__v = v;
    fields__set[0] |= 0x2; 
}
        

-(NSString *)currencySymbol {
    if ((fields__set[0] & 0x4) == 0) {
        self.currencySymbol__v = [self string:@"currencySymbol"];
        fields__set[0] |= 0x4; 
    }
    return self.currencySymbol__v;
}
        

-(void)setCurrencySymbol:(NSString *)v {
    self.currencySymbol__v = v;
    fields__set[0] |= 0x4; 
}
        

-(NSInteger)orgAttachmentFileSizeLimit {
    if ((fields__set[0] & 0x8) == 0) {
        self.orgAttachmentFileSizeLimit__v = [self integer:@"orgAttachmentFileSizeLimit"];
        fields__set[0] |= 0x8; 
    }
    return self.orgAttachmentFileSizeLimit__v;
}
        

-(void)setOrgAttachmentFileSizeLimit:(NSInteger)v {
    self.orgAttachmentFileSizeLimit__v = v;
    fields__set[0] |= 0x8; 
}
        

-(NSString *)orgDefaultCurrencyIsoCode {
    if ((fields__set[0] & 0x10) == 0) {
        self.orgDefaultCurrencyIsoCode__v = [self string:@"orgDefaultCurrencyIsoCode"];
        fields__set[0] |= 0x10; 
    }
    return self.orgDefaultCurrencyIsoCode__v;
}
        

-(void)setOrgDefaultCurrencyIsoCode:(NSString *)v {
    self.orgDefaultCurrencyIsoCode__v = v;
    fields__set[0] |= 0x10; 
}
        

-(NSString *)orgDefaultCurrencyLocale {
    if ((fields__set[0] & 0x20) == 0) {
        self.orgDefaultCurrencyLocale__v = [self string:@"orgDefaultCurrencyLocale"];
        fields__set[0] |= 0x20; 
    }
    return self.orgDefaultCurrencyLocale__v;
}
        

-(void)setOrgDefaultCurrencyLocale:(NSString *)v {
    self.orgDefaultCurrencyLocale__v = v;
    fields__set[0] |= 0x20; 
}
        

-(BOOL)orgDisallowHtmlAttachments {
    if ((fields__set[0] & 0x40) == 0) {
        self.orgDisallowHtmlAttachments__v = [self boolean:@"orgDisallowHtmlAttachments"];
        fields__set[0] |= 0x40; 
    }
    return self.orgDisallowHtmlAttachments__v;
}
        

-(void)setOrgDisallowHtmlAttachments:(BOOL)v {
    self.orgDisallowHtmlAttachments__v = v;
    fields__set[0] |= 0x40; 
}
        

-(BOOL)orgHasPersonAccounts {
    if ((fields__set[0] & 0x80) == 0) {
        self.orgHasPersonAccounts__v = [self boolean:@"orgHasPersonAccounts"];
        fields__set[0] |= 0x80; 
    }
    return self.orgHasPersonAccounts__v;
}
        

-(void)setOrgHasPersonAccounts:(BOOL)v {
    self.orgHasPersonAccounts__v = v;
    fields__set[0] |= 0x80; 
}
        

-(NSString *)organizationId {
    if ((fields__set[0] & 0x100) == 0) {
        self.organizationId__v = [self string:@"organizationId"];
        fields__set[0] |= 0x100; 
    }
    return self.organizationId__v;
}
        

-(void)setOrganizationId:(NSString *)v {
    self.organizationId__v = v;
    fields__set[0] |= 0x100; 
}
        

-(BOOL)organizationMultiCurrency {
    if ((fields__set[0] & 0x200) == 0) {
        self.organizationMultiCurrency__v = [self boolean:@"organizationMultiCurrency"];
        fields__set[0] |= 0x200; 
    }
    return self.organizationMultiCurrency__v;
}
        

-(void)setOrganizationMultiCurrency:(BOOL)v {
    self.organizationMultiCurrency__v = v;
    fields__set[0] |= 0x200; 
}
        

-(NSString *)organizationName {
    if ((fields__set[0] & 0x400) == 0) {
        self.organizationName__v = [self string:@"organizationName"];
        fields__set[0] |= 0x400; 
    }
    return self.organizationName__v;
}
        

-(void)setOrganizationName:(NSString *)v {
    self.organizationName__v = v;
    fields__set[0] |= 0x400; 
}
        

-(NSString *)profileId {
    if ((fields__set[0] & 0x800) == 0) {
        self.profileId__v = [self string:@"profileId"];
        fields__set[0] |= 0x800; 
    }
    return self.profileId__v;
}
        

-(void)setProfileId:(NSString *)v {
    self.profileId__v = v;
    fields__set[0] |= 0x800; 
}
        

-(NSString *)roleId {
    if ((fields__set[0] & 0x1000) == 0) {
        self.roleId__v = [self string:@"roleId"];
        fields__set[0] |= 0x1000; 
    }
    return self.roleId__v;
}
        

-(void)setRoleId:(NSString *)v {
    self.roleId__v = v;
    fields__set[0] |= 0x1000; 
}
        

-(NSInteger)sessionSecondsValid {
    if ((fields__set[0] & 0x2000) == 0) {
        self.sessionSecondsValid__v = [self integer:@"sessionSecondsValid"];
        fields__set[0] |= 0x2000; 
    }
    return self.sessionSecondsValid__v;
}
        

-(void)setSessionSecondsValid:(NSInteger)v {
    self.sessionSecondsValid__v = v;
    fields__set[0] |= 0x2000; 
}
        

-(NSString *)userDefaultCurrencyIsoCode {
    if ((fields__set[0] & 0x4000) == 0) {
        self.userDefaultCurrencyIsoCode__v = [self string:@"userDefaultCurrencyIsoCode"];
        fields__set[0] |= 0x4000; 
    }
    return self.userDefaultCurrencyIsoCode__v;
}
        

-(void)setUserDefaultCurrencyIsoCode:(NSString *)v {
    self.userDefaultCurrencyIsoCode__v = v;
    fields__set[0] |= 0x4000; 
}
        

-(NSString *)userEmail {
    if ((fields__set[0] & 0x8000) == 0) {
        self.userEmail__v = [self string:@"userEmail"];
        fields__set[0] |= 0x8000; 
    }
    return self.userEmail__v;
}
        

-(void)setUserEmail:(NSString *)v {
    self.userEmail__v = v;
    fields__set[0] |= 0x8000; 
}
        

-(NSString *)userFullName {
    if ((fields__set[0] & 0x10000) == 0) {
        self.userFullName__v = [self string:@"userFullName"];
        fields__set[0] |= 0x10000; 
    }
    return self.userFullName__v;
}
        

-(void)setUserFullName:(NSString *)v {
    self.userFullName__v = v;
    fields__set[0] |= 0x10000; 
}
        

-(NSString *)userId {
    if ((fields__set[0] & 0x20000) == 0) {
        self.userId__v = [self string:@"userId"];
        fields__set[0] |= 0x20000; 
    }
    return self.userId__v;
}
        

-(void)setUserId:(NSString *)v {
    self.userId__v = v;
    fields__set[0] |= 0x20000; 
}
        

-(NSString *)userLanguage {
    if ((fields__set[0] & 0x40000) == 0) {
        self.userLanguage__v = [self string:@"userLanguage"];
        fields__set[0] |= 0x40000; 
    }
    return self.userLanguage__v;
}
        

-(void)setUserLanguage:(NSString *)v {
    self.userLanguage__v = v;
    fields__set[0] |= 0x40000; 
}
        

-(NSString *)userLocale {
    if ((fields__set[0] & 0x80000) == 0) {
        self.userLocale__v = [self string:@"userLocale"];
        fields__set[0] |= 0x80000; 
    }
    return self.userLocale__v;
}
        

-(void)setUserLocale:(NSString *)v {
    self.userLocale__v = v;
    fields__set[0] |= 0x80000; 
}
        

-(NSString *)userName {
    if ((fields__set[0] & 0x100000) == 0) {
        self.userName__v = [self string:@"userName"];
        fields__set[0] |= 0x100000; 
    }
    return self.userName__v;
}
        

-(void)setUserName:(NSString *)v {
    self.userName__v = v;
    fields__set[0] |= 0x100000; 
}
        

-(NSString *)userTimeZone {
    if ((fields__set[0] & 0x200000) == 0) {
        self.userTimeZone__v = [self string:@"userTimeZone"];
        fields__set[0] |= 0x200000; 
    }
    return self.userTimeZone__v;
}
        

-(void)setUserTimeZone:(NSString *)v {
    self.userTimeZone__v = v;
    fields__set[0] |= 0x200000; 
}
        

-(NSString *)userType {
    if ((fields__set[0] & 0x400000) == 0) {
        self.userType__v = [self string:@"userType"];
        fields__set[0] |= 0x400000; 
    }
    return self.userType__v;
}
        

-(void)setUserType:(NSString *)v {
    self.userType__v = v;
    fields__set[0] |= 0x400000; 
}
        

-(NSString *)userUiSkin {
    if ((fields__set[0] & 0x800000) == 0) {
        self.userUiSkin__v = [self string:@"userUiSkin"];
        fields__set[0] |= 0x800000; 
    }
    return self.userUiSkin__v;
}
        

-(void)setUserUiSkin:(NSString *)v {
    self.userUiSkin__v = v;
    fields__set[0] |= 0x800000; 
}
        
-(void)serializeTo:(ZKXmlWriter *)env elemName:(NSString *)elemName {
	[env startElement:elemName];
	[env addBoolElement:@"accessibilityMode"          elemValue:self.accessibilityMode];
	[env addBoolElement:@"chatterExternal"            elemValue:self.chatterExternal];
	[env addElement:@"currencySymbol"                 elemValue:self.currencySymbol             nillable:YES optional:NO];
	[env addIntElement:@"orgAttachmentFileSizeLimit"  elemValue:self.orgAttachmentFileSizeLimit];
	[env addElement:@"orgDefaultCurrencyIsoCode"      elemValue:self.orgDefaultCurrencyIsoCode  nillable:YES optional:NO];
	[env addElement:@"orgDefaultCurrencyLocale"       elemValue:self.orgDefaultCurrencyLocale   nillable:YES optional:NO];
	[env addBoolElement:@"orgDisallowHtmlAttachments" elemValue:self.orgDisallowHtmlAttachments];
	[env addBoolElement:@"orgHasPersonAccounts"       elemValue:self.orgHasPersonAccounts];
	[env addElement:@"organizationId"                 elemValue:self.organizationId             nillable:NO  optional:NO];
	[env addBoolElement:@"organizationMultiCurrency"  elemValue:self.organizationMultiCurrency];
	[env addElement:@"organizationName"               elemValue:self.organizationName           nillable:NO  optional:NO];
	[env addElement:@"profileId"                      elemValue:self.profileId                  nillable:NO  optional:NO];
	[env addElement:@"roleId"                         elemValue:self.roleId                     nillable:YES optional:NO];
	[env addIntElement:@"sessionSecondsValid"         elemValue:self.sessionSecondsValid];
	[env addElement:@"userDefaultCurrencyIsoCode"     elemValue:self.userDefaultCurrencyIsoCode nillable:YES optional:NO];
	[env addElement:@"userEmail"                      elemValue:self.userEmail                  nillable:NO  optional:NO];
	[env addElement:@"userFullName"                   elemValue:self.userFullName               nillable:NO  optional:NO];
	[env addElement:@"userId"                         elemValue:self.userId                     nillable:NO  optional:NO];
	[env addElement:@"userLanguage"                   elemValue:self.userLanguage               nillable:NO  optional:NO];
	[env addElement:@"userLocale"                     elemValue:self.userLocale                 nillable:NO  optional:NO];
	[env addElement:@"userName"                       elemValue:self.userName                   nillable:NO  optional:NO];
	[env addElement:@"userTimeZone"                   elemValue:self.userTimeZone               nillable:NO  optional:NO];
	[env addElement:@"userType"                       elemValue:self.userType                   nillable:NO  optional:NO];
	[env addElement:@"userUiSkin"                     elemValue:self.userUiSkin                 nillable:NO  optional:NO];
	[env endElement:elemName];
}
@end
