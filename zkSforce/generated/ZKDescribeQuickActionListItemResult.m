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

#import "ZKDescribeQuickActionListItemResult.h"
#import "ZKEnvelope.h"
#import "ZKDescribeColor.h"
#import "ZKDescribeIcon.h"

@interface ZKDescribeQuickActionListItemResult()
@property (strong,nonatomic) NSString                    *accessLevelRequired__v;
@property (strong,nonatomic) NSArray<ZKDescribeColor *>  *colors__v;
@property (strong,nonatomic) NSString                    *iconUrl__v;
@property (strong,nonatomic) NSArray<ZKDescribeIcon *>   *icons__v;
@property (strong,nonatomic) NSString                    *label__v;
@property (strong,nonatomic) NSString                    *miniIconUrl__v;
@property (strong,nonatomic) NSString                    *quickActionName__v;
@property (strong,nonatomic) NSString                    *targetSobjectType__v;
@property (strong,nonatomic) NSString                    *type__v;
@end

@implementation ZKDescribeQuickActionListItemResult


+(void)load {
    [self registerType:self xmlName:@"DescribeQuickActionListItemResult"];
}

+(ZKComplexTypeInfo *)wsdlSchema {
   static ZKComplexTypeInfo *wsdlSchema;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
       wsdlSchema = [[ZKComplexTypeInfo alloc] initWithType:@"DescribeQuickActionListItemResult" parent:nil
                    fields:@[
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"accessLevelRequired" propertyName:@"accessLevelRequired" optional:NO nillable:YES],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"colors" propertyName:@"colors" optional:YES nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"iconUrl" propertyName:@"iconUrl" optional:NO nillable:YES],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"icons" propertyName:@"icons" optional:YES nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"label" propertyName:@"label" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"miniIconUrl" propertyName:@"miniIconUrl" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"quickActionName" propertyName:@"quickActionName" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"targetSobjectType" propertyName:@"targetSobjectType" optional:NO nillable:YES],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"type" propertyName:@"type" optional:NO nillable:NO],

                    ]];
   });
   return wsdlSchema;
}
    

-(NSString *)accessLevelRequired {
    if ((fields__set[0] & 0x1) == 0) {
        self.accessLevelRequired__v = [self string:@"accessLevelRequired"];
        fields__set[0] |= 0x1;
    }
    return self.accessLevelRequired__v;
}

-(void)setAccessLevelRequired:(NSString *)v {
    self.accessLevelRequired__v = v;
    fields__set[0] |= 0x1;
}


-(NSArray<ZKDescribeColor *> *)colors {
    if ((fields__set[0] & 0x2) == 0) {
        self.colors__v = [self complexTypeArrayFromElements:@"colors" cls:[ZKDescribeColor class]];
        fields__set[0] |= 0x2;
    }
    return self.colors__v;
}

-(void)setColors:(NSArray<ZKDescribeColor *> *)v {
    self.colors__v = v;
    fields__set[0] |= 0x2;
}


-(NSString *)iconUrl {
    if ((fields__set[0] & 0x4) == 0) {
        self.iconUrl__v = [self string:@"iconUrl"];
        fields__set[0] |= 0x4;
    }
    return self.iconUrl__v;
}

-(void)setIconUrl:(NSString *)v {
    self.iconUrl__v = v;
    fields__set[0] |= 0x4;
}


-(NSArray<ZKDescribeIcon *> *)icons {
    if ((fields__set[0] & 0x8) == 0) {
        self.icons__v = [self complexTypeArrayFromElements:@"icons" cls:[ZKDescribeIcon class]];
        fields__set[0] |= 0x8;
    }
    return self.icons__v;
}

-(void)setIcons:(NSArray<ZKDescribeIcon *> *)v {
    self.icons__v = v;
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


-(NSString *)miniIconUrl {
    if ((fields__set[0] & 0x20) == 0) {
        self.miniIconUrl__v = [self string:@"miniIconUrl"];
        fields__set[0] |= 0x20;
    }
    return self.miniIconUrl__v;
}

-(void)setMiniIconUrl:(NSString *)v {
    self.miniIconUrl__v = v;
    fields__set[0] |= 0x20;
}


-(NSString *)quickActionName {
    if ((fields__set[0] & 0x40) == 0) {
        self.quickActionName__v = [self string:@"quickActionName"];
        fields__set[0] |= 0x40;
    }
    return self.quickActionName__v;
}

-(void)setQuickActionName:(NSString *)v {
    self.quickActionName__v = v;
    fields__set[0] |= 0x40;
}


-(NSString *)targetSobjectType {
    if ((fields__set[0] & 0x80) == 0) {
        self.targetSobjectType__v = [self string:@"targetSobjectType"];
        fields__set[0] |= 0x80;
    }
    return self.targetSobjectType__v;
}

-(void)setTargetSobjectType:(NSString *)v {
    self.targetSobjectType__v = v;
    fields__set[0] |= 0x80;
}


-(NSString *)type {
    if ((fields__set[0] & 0x100) == 0) {
        self.type__v = [self string:@"type"];
        fields__set[0] |= 0x100;
    }
    return self.type__v;
}

-(void)setType:(NSString *)v {
    self.type__v = v;
    fields__set[0] |= 0x100;
}

-(void)serializeTo:(ZKXmlWriter *)env elemName:(NSString *)elemName {
	[env startElement:elemName];
	[env addElement:@"accessLevelRequired" elemValue:self.accessLevelRequired nillable:YES optional:NO];
	[env addElementArray:@"colors"         elemValue:self.colors];
	[env addElement:@"iconUrl"             elemValue:self.iconUrl             nillable:YES optional:NO];
	[env addElementArray:@"icons"          elemValue:self.icons];
	[env addElement:@"label"               elemValue:self.label               nillable:NO  optional:NO];
	[env addElement:@"miniIconUrl"         elemValue:self.miniIconUrl         nillable:NO  optional:NO];
	[env addElement:@"quickActionName"     elemValue:self.quickActionName     nillable:NO  optional:NO];
	[env addElement:@"targetSobjectType"   elemValue:self.targetSobjectType   nillable:YES optional:NO];
	[env addElement:@"type"                elemValue:self.type                nillable:NO  optional:NO];
	[env endElement:elemName];
}
@end
