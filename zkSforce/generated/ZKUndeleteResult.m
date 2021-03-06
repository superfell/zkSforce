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

#import "ZKUndeleteResult.h"
#import "ZKEnvelope.h"
#import "ZKError.h"

@interface ZKUndeleteResult()
@property (strong,nonatomic) NSArray<ZKError *>  *errors__v;
@property (strong,nonatomic) NSString            *id__v;
@property (assign,nonatomic) BOOL                 success__v;
@end

@implementation ZKUndeleteResult


+(void)load {
    [self registerType:self xmlName:@"UndeleteResult"];
}

+(ZKComplexTypeInfo *)wsdlSchema {
   static ZKComplexTypeInfo *wsdlSchema;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
       wsdlSchema = [[ZKComplexTypeInfo alloc] initWithType:@"UndeleteResult" parent:nil
                    fields:@[
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"errors" propertyName:@"errors" optional:YES nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"id" propertyName:@"id" optional:NO nillable:YES],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"success" propertyName:@"success" optional:NO nillable:NO],

                    ]];
   });
   return wsdlSchema;
}
    

-(NSArray<ZKError *> *)errors {
    if ((fields__set[0] & 0x1) == 0) {
        self.errors__v = [self complexTypeArrayFromElements:@"errors" cls:[ZKError class]];
        fields__set[0] |= 0x1;
    }
    return self.errors__v;
}

-(void)setErrors:(NSArray<ZKError *> *)v {
    self.errors__v = v;
    fields__set[0] |= 0x1;
}


-(NSString *)id {
    if ((fields__set[0] & 0x2) == 0) {
        self.id__v = [self string:@"id"];
        fields__set[0] |= 0x2;
    }
    return self.id__v;
}

-(void)setId:(NSString *)v {
    self.id__v = v;
    fields__set[0] |= 0x2;
}


-(BOOL)success {
    if ((fields__set[0] & 0x4) == 0) {
        self.success__v = [self boolean:@"success"];
        fields__set[0] |= 0x4;
    }
    return self.success__v;
}

-(void)setSuccess:(BOOL)v {
    self.success__v = v;
    fields__set[0] |= 0x4;
}

-(void)serializeTo:(ZKXmlWriter *)env elemName:(NSString *)elemName {
	[env startElement:elemName];
	[env addElementArray:@"errors" elemValue:self.errors];
	[env addElement:@"id"          elemValue:self.id      nillable:YES optional:NO];
	[env addBoolElement:@"success" elemValue:self.success];
	[env endElement:elemName];
}
@end
