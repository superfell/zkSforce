// Copyright (c) 2015 Simon Fell
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

#import "ZKDescribePathAssistantField.h"
#import "ZKEnvelope.h"

@interface ZKDescribePathAssistantField()
@property (strong,nonatomic) NSString  *apiName__v;
@property (strong,nonatomic) NSString  *label__v;
@property (assign,nonatomic) BOOL       readOnly__v;
@property (assign,nonatomic) BOOL       required__v;
@end

@implementation ZKDescribePathAssistantField


+(void)load {
    [self registerType:self xmlName:@"DescribePathAssistantField"];
}

+(ZKComplexTypeInfo *)wsdlSchema {
   static ZKComplexTypeInfo *wsdlSchema;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
       wsdlSchema = [[ZKComplexTypeInfo alloc] initWithType:@"DescribePathAssistantField" parent:nil
                    fields:@[
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"apiName" propertyName:@"apiName" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"label" propertyName:@"label" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"readOnly" propertyName:@"readOnly" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"required" propertyName:@"required" optional:NO nillable:NO],

                    ]];
   });
   return wsdlSchema;
}
    

-(NSString *)apiName {
    if ((fields__set[0] & 0x1) == 0) {
        self.apiName__v = [self string:@"apiName"];
        fields__set[0] |= 0x1;
    }
    return self.apiName__v;
}

-(void)setApiName:(NSString *)v {
    self.apiName__v = v;
    fields__set[0] |= 0x1;
}


-(NSString *)label {
    if ((fields__set[0] & 0x2) == 0) {
        self.label__v = [self string:@"label"];
        fields__set[0] |= 0x2;
    }
    return self.label__v;
}

-(void)setLabel:(NSString *)v {
    self.label__v = v;
    fields__set[0] |= 0x2;
}


-(BOOL)readOnly {
    if ((fields__set[0] & 0x4) == 0) {
        self.readOnly__v = [self boolean:@"readOnly"];
        fields__set[0] |= 0x4;
    }
    return self.readOnly__v;
}

-(void)setReadOnly:(BOOL)v {
    self.readOnly__v = v;
    fields__set[0] |= 0x4;
}


-(BOOL)required {
    if ((fields__set[0] & 0x8) == 0) {
        self.required__v = [self boolean:@"required"];
        fields__set[0] |= 0x8;
    }
    return self.required__v;
}

-(void)setRequired:(BOOL)v {
    self.required__v = v;
    fields__set[0] |= 0x8;
}

-(void)serializeTo:(ZKXmlWriter *)env elemName:(NSString *)elemName {
	[env startElement:elemName];
	[env addElement:@"apiName"      elemValue:self.apiName  nillable:NO  optional:NO];
	[env addElement:@"label"        elemValue:self.label    nillable:NO  optional:NO];
	[env addBoolElement:@"readOnly" elemValue:self.readOnly];
	[env addBoolElement:@"required" elemValue:self.required];
	[env endElement:elemName];
}
@end
