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

#import "ZKSendEmailError.h"
#import "ZKEnvelope.h"

@interface ZKSendEmailError()
@property (strong,nonatomic) NSArray<NSString *>  *fields__v;
@property (strong,nonatomic) NSString             *message__v;
@property (strong,nonatomic) NSString             *statusCode__v;
@property (strong,nonatomic) NSString             *targetObjectId__v;
@end

@implementation ZKSendEmailError


+(void)load {
    [self registerType:self xmlName:@"SendEmailError"];
}

+(ZKComplexTypeInfo *)wsdlSchema {
   static ZKComplexTypeInfo *wsdlSchema;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
       wsdlSchema = [[ZKComplexTypeInfo alloc] initWithType:@"SendEmailError" parent:nil
                    fields:@[
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"fields" propertyName:@"fields" optional:YES nillable:YES],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"message" propertyName:@"message" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"statusCode" propertyName:@"statusCode" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"targetObjectId" propertyName:@"targetObjectId" optional:NO nillable:YES],

                    ]];
   });
   return wsdlSchema;
}
    

-(NSArray<NSString *> *)fields {
    if ((fields__set[0] & 0x1) == 0) {
        self.fields__v = [self strings:@"fields"];
        fields__set[0] |= 0x1; 
    }
    return self.fields__v;
}
        

-(void)setFields:(NSArray<NSString *> *)v {
    self.fields__v = v;
    fields__set[0] |= 0x1; 
}
        

-(NSString *)message {
    if ((fields__set[0] & 0x2) == 0) {
        self.message__v = [self string:@"message"];
        fields__set[0] |= 0x2; 
    }
    return self.message__v;
}
        

-(void)setMessage:(NSString *)v {
    self.message__v = v;
    fields__set[0] |= 0x2; 
}
        

-(NSString *)statusCode {
    if ((fields__set[0] & 0x4) == 0) {
        self.statusCode__v = [self string:@"statusCode"];
        fields__set[0] |= 0x4; 
    }
    return self.statusCode__v;
}
        

-(void)setStatusCode:(NSString *)v {
    self.statusCode__v = v;
    fields__set[0] |= 0x4; 
}
        

-(NSString *)targetObjectId {
    if ((fields__set[0] & 0x8) == 0) {
        self.targetObjectId__v = [self string:@"targetObjectId"];
        fields__set[0] |= 0x8; 
    }
    return self.targetObjectId__v;
}
        

-(void)setTargetObjectId:(NSString *)v {
    self.targetObjectId__v = v;
    fields__set[0] |= 0x8; 
}
        
-(void)serializeTo:(ZKXmlWriter *)env elemName:(NSString *)elemName {
	[env startElement:elemName];
	[env addElementArray:@"fields"    elemValue:self.fields];
	[env addElement:@"message"        elemValue:self.message        nillable:NO  optional:NO];
	[env addElement:@"statusCode"     elemValue:self.statusCode     nillable:NO  optional:NO];
	[env addElement:@"targetObjectId" elemValue:self.targetObjectId nillable:YES optional:NO];
	[env endElement:elemName];
}
@end
