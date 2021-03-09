// Copyright (c) 2009 Simon Fell
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

#import "ZKLoginResult.h"
#import "ZKEnvelope.h"
#import "ZKUserInfo.h"

@interface ZKLoginResult()
@property (strong,nonatomic) NSString    *metadataServerUrl__v;
@property (assign,nonatomic) BOOL         passwordExpired__v;
@property (assign,nonatomic) BOOL         sandbox__v;
@property (strong,nonatomic) NSString    *serverUrl__v;
@property (strong,nonatomic) NSString    *sessionId__v;
@property (strong,nonatomic) NSString    *userId__v;
@property (strong,nonatomic) ZKUserInfo  *userInfo__v;
@end

@implementation ZKLoginResult


+(void)load {
    [self registerType:self xmlName:@"LoginResult"];
}

-(NSString *)metadataServerUrl {
    if ((fields__set[0] & 0x1) == 0) {
        self.metadataServerUrl__v = [self string:@"metadataServerUrl"];
        fields__set[0] |= 0x1; 
    }
    return self.metadataServerUrl__v;
}
        

-(void)setMetadataServerUrl:(NSString *)v {
    self.metadataServerUrl__v = v;
    fields__set[0] |= 0x1; 
}
        

-(BOOL)passwordExpired {
    if ((fields__set[0] & 0x2) == 0) {
        self.passwordExpired__v = [self boolean:@"passwordExpired"];
        fields__set[0] |= 0x2; 
    }
    return self.passwordExpired__v;
}
        

-(void)setPasswordExpired:(BOOL)v {
    self.passwordExpired__v = v;
    fields__set[0] |= 0x2; 
}
        

-(BOOL)sandbox {
    if ((fields__set[0] & 0x4) == 0) {
        self.sandbox__v = [self boolean:@"sandbox"];
        fields__set[0] |= 0x4; 
    }
    return self.sandbox__v;
}
        

-(void)setSandbox:(BOOL)v {
    self.sandbox__v = v;
    fields__set[0] |= 0x4; 
}
        

-(NSString *)serverUrl {
    if ((fields__set[0] & 0x8) == 0) {
        self.serverUrl__v = [self string:@"serverUrl"];
        fields__set[0] |= 0x8; 
    }
    return self.serverUrl__v;
}
        

-(void)setServerUrl:(NSString *)v {
    self.serverUrl__v = v;
    fields__set[0] |= 0x8; 
}
        

-(NSString *)sessionId {
    if ((fields__set[0] & 0x10) == 0) {
        self.sessionId__v = [self string:@"sessionId"];
        fields__set[0] |= 0x10; 
    }
    return self.sessionId__v;
}
        

-(void)setSessionId:(NSString *)v {
    self.sessionId__v = v;
    fields__set[0] |= 0x10; 
}
        

-(NSString *)userId {
    if ((fields__set[0] & 0x20) == 0) {
        self.userId__v = [self string:@"userId"];
        fields__set[0] |= 0x20; 
    }
    return self.userId__v;
}
        

-(void)setUserId:(NSString *)v {
    self.userId__v = v;
    fields__set[0] |= 0x20; 
}
        

-(ZKUserInfo *)userInfo {
    if ((fields__set[0] & 0x40) == 0) {
        self.userInfo__v = [self complexTypeArrayFromElements:@"userInfo" cls:[ZKUserInfo class]].lastObject;
        fields__set[0] |= 0x40; 
    }
    return self.userInfo__v;
}
        

-(void)setUserInfo:(ZKUserInfo *)v {
    self.userInfo__v = v;
    fields__set[0] |= 0x40; 
}
        
-(void)serializeTo:(ZKXmlWriter *)env elemName:(NSString *)elemName {
	[env startElement:elemName];
	[env addElement:@"metadataServerUrl"   elemValue:self.metadataServerUrl nillable:YES optional:NO];
	[env addBoolElement:@"passwordExpired" elemValue:self.passwordExpired];
	[env addBoolElement:@"sandbox"         elemValue:self.sandbox];
	[env addElement:@"serverUrl"           elemValue:self.serverUrl         nillable:YES optional:NO];
	[env addElement:@"sessionId"           elemValue:self.sessionId         nillable:YES optional:NO];
	[env addElement:@"userId"              elemValue:self.userId            nillable:YES optional:NO];
	[env addElement:@"userInfo"            elemValue:self.userInfo          nillable:NO  optional:YES];
	[env endElement:elemName];
}
@end
