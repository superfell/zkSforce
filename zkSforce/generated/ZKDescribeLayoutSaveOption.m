// Copyright (c) 2017 Simon Fell
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

#import "ZKDescribeLayoutSaveOption.h"
#import "ZKEnvelope.h"

@interface ZKDescribeLayoutSaveOption()
@property (assign,nonatomic) BOOL       defaultValue__v;
@property (assign,nonatomic) BOOL       isDisplayed__v;
@property (strong,nonatomic) NSString  *label__v;
@property (strong,nonatomic) NSString  *name__v;
@property (strong,nonatomic) NSString  *restHeaderName__v;
@property (strong,nonatomic) NSString  *soapHeaderName__v;
@end

@implementation ZKDescribeLayoutSaveOption


+(void)load {
    [self registerType:self xmlName:@"DescribeLayoutSaveOption"];
}

+(ZKComplexTypeInfo *)wsdlSchema {
   static ZKComplexTypeInfo *wsdlSchema;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
       wsdlSchema = [[ZKComplexTypeInfo alloc] initWithType:@"DescribeLayoutSaveOption" parent:nil
                    fields:@[
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"defaultValue" propertyName:@"defaultValue" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"isDisplayed" propertyName:@"isDisplayed" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"label" propertyName:@"label" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"name" propertyName:@"name" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"restHeaderName" propertyName:@"restHeaderName" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"soapHeaderName" propertyName:@"soapHeaderName" optional:NO nillable:NO],

                    ]];
   });
   return wsdlSchema;
}
    

-(BOOL)defaultValue {
    if ((fields__set[0] & 0x1) == 0) {
        self.defaultValue__v = [self boolean:@"defaultValue"];
        fields__set[0] |= 0x1;
    }
    return self.defaultValue__v;
}

-(void)setDefaultValue:(BOOL)v {
    self.defaultValue__v = v;
    fields__set[0] |= 0x1;
}


-(BOOL)isDisplayed {
    if ((fields__set[0] & 0x2) == 0) {
        self.isDisplayed__v = [self boolean:@"isDisplayed"];
        fields__set[0] |= 0x2;
    }
    return self.isDisplayed__v;
}

-(void)setIsDisplayed:(BOOL)v {
    self.isDisplayed__v = v;
    fields__set[0] |= 0x2;
}


-(NSString *)label {
    if ((fields__set[0] & 0x4) == 0) {
        self.label__v = [self string:@"label"];
        fields__set[0] |= 0x4;
    }
    return self.label__v;
}

-(void)setLabel:(NSString *)v {
    self.label__v = v;
    fields__set[0] |= 0x4;
}


-(NSString *)name {
    if ((fields__set[0] & 0x8) == 0) {
        self.name__v = [self string:@"name"];
        fields__set[0] |= 0x8;
    }
    return self.name__v;
}

-(void)setName:(NSString *)v {
    self.name__v = v;
    fields__set[0] |= 0x8;
}


-(NSString *)restHeaderName {
    if ((fields__set[0] & 0x10) == 0) {
        self.restHeaderName__v = [self string:@"restHeaderName"];
        fields__set[0] |= 0x10;
    }
    return self.restHeaderName__v;
}

-(void)setRestHeaderName:(NSString *)v {
    self.restHeaderName__v = v;
    fields__set[0] |= 0x10;
}


-(NSString *)soapHeaderName {
    if ((fields__set[0] & 0x20) == 0) {
        self.soapHeaderName__v = [self string:@"soapHeaderName"];
        fields__set[0] |= 0x20;
    }
    return self.soapHeaderName__v;
}

-(void)setSoapHeaderName:(NSString *)v {
    self.soapHeaderName__v = v;
    fields__set[0] |= 0x20;
}

-(void)serializeTo:(ZKXmlWriter *)env elemName:(NSString *)elemName {
	[env startElement:elemName];
	[env addBoolElement:@"defaultValue" elemValue:self.defaultValue];
	[env addBoolElement:@"isDisplayed"  elemValue:self.isDisplayed];
	[env addElement:@"label"            elemValue:self.label          nillable:NO  optional:NO];
	[env addElement:@"name"             elemValue:self.name           nillable:NO  optional:NO];
	[env addElement:@"restHeaderName"   elemValue:self.restHeaderName nillable:NO  optional:NO];
	[env addElement:@"soapHeaderName"   elemValue:self.soapHeaderName nillable:NO  optional:NO];
	[env endElement:elemName];
}
@end
