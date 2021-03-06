// Copyright (c) 2007 Simon Fell
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

#import "ZKPicklistEntry.h"
#import "ZKEnvelope.h"

@interface ZKPicklistEntry()
@property (assign,nonatomic) BOOL       active__v;
@property (assign,nonatomic) BOOL       defaultValue__v;
@property (strong,nonatomic) NSString  *label__v;
@property (strong,nonatomic) NSData    *validFor__v;
@property (strong,nonatomic) NSString  *value__v;
@end

@implementation ZKPicklistEntry


+(void)load {
    [self registerType:self xmlName:@"PicklistEntry"];
}

+(ZKComplexTypeInfo *)wsdlSchema {
   static ZKComplexTypeInfo *wsdlSchema;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
       wsdlSchema = [[ZKComplexTypeInfo alloc] initWithType:@"PicklistEntry" parent:nil
                    fields:@[
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"active" propertyName:@"active" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"defaultValue" propertyName:@"defaultValue" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"label" propertyName:@"label" optional:NO nillable:YES],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"validFor" propertyName:@"validFor" optional:YES nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"value" propertyName:@"value" optional:NO nillable:NO],

                    ]];
   });
   return wsdlSchema;
}
    

-(BOOL)active {
    if ((fields__set[0] & 0x1) == 0) {
        self.active__v = [self boolean:@"active"];
        fields__set[0] |= 0x1;
    }
    return self.active__v;
}

-(void)setActive:(BOOL)v {
    self.active__v = v;
    fields__set[0] |= 0x1;
}


-(BOOL)defaultValue {
    if ((fields__set[0] & 0x2) == 0) {
        self.defaultValue__v = [self boolean:@"defaultValue"];
        fields__set[0] |= 0x2;
    }
    return self.defaultValue__v;
}

-(void)setDefaultValue:(BOOL)v {
    self.defaultValue__v = v;
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


-(NSData *)validFor {
    if ((fields__set[0] & 0x8) == 0) {
        self.validFor__v = [self blob:@"validFor"];
        fields__set[0] |= 0x8;
    }
    return self.validFor__v;
}

-(void)setValidFor:(NSData *)v {
    self.validFor__v = v;
    fields__set[0] |= 0x8;
}


-(NSString *)value {
    if ((fields__set[0] & 0x10) == 0) {
        self.value__v = [self string:@"value"];
        fields__set[0] |= 0x10;
    }
    return self.value__v;
}

-(void)setValue:(NSString *)v {
    self.value__v = v;
    fields__set[0] |= 0x10;
}

-(void)serializeTo:(ZKXmlWriter *)env elemName:(NSString *)elemName {
	[env startElement:elemName];
	[env addBoolElement:@"active"       elemValue:self.active];
	[env addBoolElement:@"defaultValue" elemValue:self.defaultValue];
	[env addElement:@"label"            elemValue:self.label        nillable:YES optional:NO];
	[env addElement:@"validFor"         elemValue:self.validFor     nillable:NO  optional:YES];
	[env addElement:@"value"            elemValue:self.value        nillable:NO  optional:NO];
	[env endElement:elemName];
}
@end
