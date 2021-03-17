// Copyright (c) 2014 Simon Fell
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

#import "ZKSoqlSubQueryCondition.h"
#import "ZKEnvelope.h"

@interface ZKSoqlSubQueryCondition()
@property (strong,nonatomic) NSString  *field__v;
@property (strong,nonatomic) NSString  *operator__v;
@property (strong,nonatomic) NSString  *subQuery__v;
@end

@implementation ZKSoqlSubQueryCondition


+(void)load {
    [self registerType:self xmlName:@"SoqlSubQueryCondition"];
}

+(ZKComplexTypeInfo *)wsdlSchema {
   static ZKComplexTypeInfo *wsdlSchema;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
       wsdlSchema = [[ZKComplexTypeInfo alloc] initWithType:@"SoqlSubQueryCondition" parent:[ZKSoqlWhereCondition class]
                    fields:@[
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"field" propertyName:@"field" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"operator" propertyName:@"operator" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"subQuery" propertyName:@"subQuery" optional:NO nillable:NO],

                    ]];
   });
   return wsdlSchema;
}
    

-(NSString *)field {
    if ((fields__set2[0] & 0x1) == 0) {
        self.field__v = [self string:@"field"];
        fields__set2[0] |= 0x1;
    }
    return self.field__v;
}

-(void)setField:(NSString *)v {
    self.field__v = v;
    fields__set2[0] |= 0x1;
}


-(NSString *)operator {
    if ((fields__set2[0] & 0x2) == 0) {
        self.operator__v = [self string:@"operator"];
        fields__set2[0] |= 0x2;
    }
    return self.operator__v;
}

-(void)setOperator:(NSString *)v {
    self.operator__v = v;
    fields__set2[0] |= 0x2;
}


-(NSString *)subQuery {
    if ((fields__set2[0] & 0x4) == 0) {
        self.subQuery__v = [self string:@"subQuery"];
        fields__set2[0] |= 0x4;
    }
    return self.subQuery__v;
}

-(void)setSubQuery:(NSString *)v {
    self.subQuery__v = v;
    fields__set2[0] |= 0x4;
}

-(void)serializeTo:(ZKXmlWriter *)env elemName:(NSString *)elemName {
	[env startElement:elemName type:@"SoqlSubQueryCondition"];
	[env addElement:@"field"    elemValue:self.field    nillable:NO  optional:NO];
	[env addElement:@"operator" elemValue:self.operator nillable:NO  optional:NO];
	[env addElement:@"subQuery" elemValue:self.subQuery nillable:NO  optional:NO];
	[env endElement:elemName];
}
@end
