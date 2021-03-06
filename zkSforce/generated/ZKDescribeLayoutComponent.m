// Copyright (c) 2010 Ron Hess
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

#import "ZKDescribeLayoutComponent.h"
#import "ZKEnvelope.h"

@interface ZKDescribeLayoutComponent()
@property (assign,nonatomic) NSInteger  displayLines__v;
@property (assign,nonatomic) NSInteger  tabOrder__v;
@property (strong,nonatomic) NSString  *type__v;
@property (strong,nonatomic) NSString  *value__v;
@end

@implementation ZKDescribeLayoutComponent


+(void)load {
    [self registerType:self xmlName:@"DescribeLayoutComponent"];
}

+(ZKComplexTypeInfo *)wsdlSchema {
   static ZKComplexTypeInfo *wsdlSchema;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
       wsdlSchema = [[ZKComplexTypeInfo alloc] initWithType:@"DescribeLayoutComponent" parent:nil
                    fields:@[
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"displayLines" propertyName:@"displayLines" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"tabOrder" propertyName:@"tabOrder" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"type" propertyName:@"type" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"value" propertyName:@"value" optional:NO nillable:YES],

                    ]];
   });
   return wsdlSchema;
}
    

-(NSInteger)displayLines {
    if ((fields__set[0] & 0x1) == 0) {
        self.displayLines__v = [self integer:@"displayLines"];
        fields__set[0] |= 0x1;
    }
    return self.displayLines__v;
}

-(void)setDisplayLines:(NSInteger)v {
    self.displayLines__v = v;
    fields__set[0] |= 0x1;
}


-(NSInteger)tabOrder {
    if ((fields__set[0] & 0x2) == 0) {
        self.tabOrder__v = [self integer:@"tabOrder"];
        fields__set[0] |= 0x2;
    }
    return self.tabOrder__v;
}

-(void)setTabOrder:(NSInteger)v {
    self.tabOrder__v = v;
    fields__set[0] |= 0x2;
}


-(NSString *)type {
    if ((fields__set[0] & 0x4) == 0) {
        self.type__v = [self string:@"type"];
        fields__set[0] |= 0x4;
    }
    return self.type__v;
}

-(void)setType:(NSString *)v {
    self.type__v = v;
    fields__set[0] |= 0x4;
}


-(NSString *)value {
    if ((fields__set[0] & 0x8) == 0) {
        self.value__v = [self string:@"value"];
        fields__set[0] |= 0x8;
    }
    return self.value__v;
}

-(void)setValue:(NSString *)v {
    self.value__v = v;
    fields__set[0] |= 0x8;
}

-(void)serializeTo:(ZKXmlWriter *)env elemName:(NSString *)elemName {
	[env startElement:elemName];
	[env addIntElement:@"displayLines" elemValue:self.displayLines];
	[env addIntElement:@"tabOrder"     elemValue:self.tabOrder];
	[env addElement:@"type"            elemValue:self.type         nillable:NO  optional:NO];
	[env addElement:@"value"           elemValue:self.value        nillable:YES optional:NO];
	[env endElement:elemName];
}
@end
