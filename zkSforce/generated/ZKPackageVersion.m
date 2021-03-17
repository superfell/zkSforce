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

#import "ZKPackageVersion.h"
#import "ZKEnvelope.h"

@interface ZKPackageVersion()
@property (assign,nonatomic) NSInteger  majorNumber__v;
@property (assign,nonatomic) NSInteger  minorNumber__v;
@property (strong,nonatomic) NSString  *namespace__v;
@end

@implementation ZKPackageVersion


+(void)load {
    [self registerType:self xmlName:@"PackageVersion"];
}

+(ZKComplexTypeInfo *)wsdlSchema {
   static ZKComplexTypeInfo *wsdlSchema;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
       wsdlSchema = [[ZKComplexTypeInfo alloc] initWithType:@"PackageVersion" parent:nil
                    fields:@[
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"majorNumber" propertyName:@"majorNumber" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"minorNumber" propertyName:@"minorNumber" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"namespace" propertyName:@"namespace" optional:NO nillable:NO],

                    ]];
   });
   return wsdlSchema;
}
    

-(NSInteger)majorNumber {
    if ((fields__set[0] & 0x1) == 0) {
        self.majorNumber__v = [self integer:@"majorNumber"];
        fields__set[0] |= 0x1;
    }
    return self.majorNumber__v;
}

-(void)setMajorNumber:(NSInteger)v {
    self.majorNumber__v = v;
    fields__set[0] |= 0x1;
}


-(NSInteger)minorNumber {
    if ((fields__set[0] & 0x2) == 0) {
        self.minorNumber__v = [self integer:@"minorNumber"];
        fields__set[0] |= 0x2;
    }
    return self.minorNumber__v;
}

-(void)setMinorNumber:(NSInteger)v {
    self.minorNumber__v = v;
    fields__set[0] |= 0x2;
}


-(NSString *)namespace {
    if ((fields__set[0] & 0x4) == 0) {
        self.namespace__v = [self string:@"namespace"];
        fields__set[0] |= 0x4;
    }
    return self.namespace__v;
}

-(void)setNamespace:(NSString *)v {
    self.namespace__v = v;
    fields__set[0] |= 0x4;
}

-(void)serializeTo:(ZKXmlWriter *)env elemName:(NSString *)elemName {
	[env startElement:elemName];
	[env addIntElement:@"majorNumber" elemValue:self.majorNumber];
	[env addIntElement:@"minorNumber" elemValue:self.minorNumber];
	[env addElement:@"namespace"      elemValue:self.namespace   nillable:NO  optional:NO];
	[env endElement:elemName];
}
@end
