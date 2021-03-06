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

#import "ZKDescribeCompactLayout.h"
#import "ZKEnvelope.h"
#import "ZKDescribeLayoutButton.h"
#import "ZKDescribeLayoutItem.h"

@interface ZKDescribeCompactLayout()
@property (strong,nonatomic) NSArray<ZKDescribeLayoutButton *>  *actions__v;
@property (strong,nonatomic) NSArray<ZKDescribeLayoutItem *>    *fieldItems__v;
@property (strong,nonatomic) NSString                           *id__v;
@property (strong,nonatomic) NSArray<ZKDescribeLayoutItem *>    *imageItems__v;
@property (strong,nonatomic) NSString                           *label__v;
@property (strong,nonatomic) NSString                           *name__v;
@property (strong,nonatomic) NSString                           *objectType__v;
@end

@implementation ZKDescribeCompactLayout


+(void)load {
    [self registerType:self xmlName:@"DescribeCompactLayout"];
}

+(ZKComplexTypeInfo *)wsdlSchema {
   static ZKComplexTypeInfo *wsdlSchema;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
       wsdlSchema = [[ZKComplexTypeInfo alloc] initWithType:@"DescribeCompactLayout" parent:nil
                    fields:@[
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"actions" propertyName:@"actions" optional:YES nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"fieldItems" propertyName:@"fieldItems" optional:YES nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"id" propertyName:@"id" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"imageItems" propertyName:@"imageItems" optional:YES nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"label" propertyName:@"label" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"name" propertyName:@"name" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"objectType" propertyName:@"objectType" optional:NO nillable:NO],

                    ]];
   });
   return wsdlSchema;
}
    

-(NSArray<ZKDescribeLayoutButton *> *)actions {
    if ((fields__set[0] & 0x1) == 0) {
        self.actions__v = [self complexTypeArrayFromElements:@"actions" cls:[ZKDescribeLayoutButton class]];
        fields__set[0] |= 0x1;
    }
    return self.actions__v;
}

-(void)setActions:(NSArray<ZKDescribeLayoutButton *> *)v {
    self.actions__v = v;
    fields__set[0] |= 0x1;
}


-(NSArray<ZKDescribeLayoutItem *> *)fieldItems {
    if ((fields__set[0] & 0x2) == 0) {
        self.fieldItems__v = [self complexTypeArrayFromElements:@"fieldItems" cls:[ZKDescribeLayoutItem class]];
        fields__set[0] |= 0x2;
    }
    return self.fieldItems__v;
}

-(void)setFieldItems:(NSArray<ZKDescribeLayoutItem *> *)v {
    self.fieldItems__v = v;
    fields__set[0] |= 0x2;
}


-(NSString *)id {
    if ((fields__set[0] & 0x4) == 0) {
        self.id__v = [self string:@"id"];
        fields__set[0] |= 0x4;
    }
    return self.id__v;
}

-(void)setId:(NSString *)v {
    self.id__v = v;
    fields__set[0] |= 0x4;
}


-(NSArray<ZKDescribeLayoutItem *> *)imageItems {
    if ((fields__set[0] & 0x8) == 0) {
        self.imageItems__v = [self complexTypeArrayFromElements:@"imageItems" cls:[ZKDescribeLayoutItem class]];
        fields__set[0] |= 0x8;
    }
    return self.imageItems__v;
}

-(void)setImageItems:(NSArray<ZKDescribeLayoutItem *> *)v {
    self.imageItems__v = v;
    fields__set[0] |= 0x8;
}


-(NSString *)label {
    if ((fields__set[0] & 0x10) == 0) {
        self.label__v = [self string:@"label"];
        fields__set[0] |= 0x10;
    }
    return self.label__v;
}

-(void)setLabel:(NSString *)v {
    self.label__v = v;
    fields__set[0] |= 0x10;
}


-(NSString *)name {
    if ((fields__set[0] & 0x20) == 0) {
        self.name__v = [self string:@"name"];
        fields__set[0] |= 0x20;
    }
    return self.name__v;
}

-(void)setName:(NSString *)v {
    self.name__v = v;
    fields__set[0] |= 0x20;
}


-(NSString *)objectType {
    if ((fields__set[0] & 0x40) == 0) {
        self.objectType__v = [self string:@"objectType"];
        fields__set[0] |= 0x40;
    }
    return self.objectType__v;
}

-(void)setObjectType:(NSString *)v {
    self.objectType__v = v;
    fields__set[0] |= 0x40;
}

-(void)serializeTo:(ZKXmlWriter *)env elemName:(NSString *)elemName {
	[env startElement:elemName];
	[env addElementArray:@"actions"    elemValue:self.actions];
	[env addElementArray:@"fieldItems" elemValue:self.fieldItems];
	[env addElement:@"id"              elemValue:self.id         nillable:NO  optional:NO];
	[env addElementArray:@"imageItems" elemValue:self.imageItems];
	[env addElement:@"label"           elemValue:self.label      nillable:NO  optional:NO];
	[env addElement:@"name"            elemValue:self.name       nillable:NO  optional:NO];
	[env addElement:@"objectType"      elemValue:self.objectType nillable:NO  optional:NO];
	[env endElement:elemName];
}
@end
