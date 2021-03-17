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

#import "ZKLogInfo.h"
#import "ZKEnvelope.h"

@interface ZKLogInfo()
@property (strong,nonatomic) NSString  *category__v;
@property (strong,nonatomic) NSString  *level__v;
@end

@implementation ZKLogInfo


+(void)load {
    [self registerType:self xmlName:@"LogInfo"];
}

+(ZKComplexTypeInfo *)wsdlSchema {
   static ZKComplexTypeInfo *wsdlSchema;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
       wsdlSchema = [[ZKComplexTypeInfo alloc] initWithType:@"LogInfo" parent:nil
                    fields:@[
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"category" propertyName:@"category" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"level" propertyName:@"level" optional:NO nillable:NO],

                    ]];
   });
   return wsdlSchema;
}
    

-(NSString *)category {
    if ((fields__set[0] & 0x1) == 0) {
        self.category__v = [self string:@"category"];
        fields__set[0] |= 0x1;
    }
    return self.category__v;
}

-(void)setCategory:(NSString *)v {
    self.category__v = v;
    fields__set[0] |= 0x1;
}


-(NSString *)level {
    if ((fields__set[0] & 0x2) == 0) {
        self.level__v = [self string:@"level"];
        fields__set[0] |= 0x2;
    }
    return self.level__v;
}

-(void)setLevel:(NSString *)v {
    self.level__v = v;
    fields__set[0] |= 0x2;
}

-(void)serializeTo:(ZKXmlWriter *)env elemName:(NSString *)elemName {
	[env startElement:elemName];
	[env addElement:@"category" elemValue:self.category nillable:NO  optional:NO];
	[env addElement:@"level"    elemValue:self.level    nillable:NO  optional:NO];
	[env endElement:elemName];
}
@end
