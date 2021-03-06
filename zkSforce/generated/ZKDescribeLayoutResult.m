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

#import "ZKDescribeLayoutResult.h"
#import "ZKEnvelope.h"
#import "ZKDescribeLayout.h"
#import "ZKRecordTypeMapping.h"

@interface ZKDescribeLayoutResult()
@property (strong,nonatomic) NSArray<ZKDescribeLayout *>     *layouts__v;
@property (strong,nonatomic) NSArray<ZKRecordTypeMapping *>  *recordTypeMappings__v;
@property (assign,nonatomic) BOOL                             recordTypeSelectorRequired__v;
@end

@implementation ZKDescribeLayoutResult


+(void)load {
    [self registerType:self xmlName:@"DescribeLayoutResult"];
}

+(ZKComplexTypeInfo *)wsdlSchema {
   static ZKComplexTypeInfo *wsdlSchema;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
       wsdlSchema = [[ZKComplexTypeInfo alloc] initWithType:@"DescribeLayoutResult" parent:nil
                    fields:@[
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"layouts" propertyName:@"layouts" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"recordTypeMappings" propertyName:@"recordTypeMappings" optional:YES nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"recordTypeSelectorRequired" propertyName:@"recordTypeSelectorRequired" optional:NO nillable:NO],

                    ]];
   });
   return wsdlSchema;
}
    

-(NSArray<ZKDescribeLayout *> *)layouts {
    if ((fields__set[0] & 0x1) == 0) {
        self.layouts__v = [self complexTypeArrayFromElements:@"layouts" cls:[ZKDescribeLayout class]];
        fields__set[0] |= 0x1;
    }
    return self.layouts__v;
}

-(void)setLayouts:(NSArray<ZKDescribeLayout *> *)v {
    self.layouts__v = v;
    fields__set[0] |= 0x1;
}


-(NSArray<ZKRecordTypeMapping *> *)recordTypeMappings {
    if ((fields__set[0] & 0x2) == 0) {
        self.recordTypeMappings__v = [self complexTypeArrayFromElements:@"recordTypeMappings" cls:[ZKRecordTypeMapping class]];
        fields__set[0] |= 0x2;
    }
    return self.recordTypeMappings__v;
}

-(void)setRecordTypeMappings:(NSArray<ZKRecordTypeMapping *> *)v {
    self.recordTypeMappings__v = v;
    fields__set[0] |= 0x2;
}


-(BOOL)recordTypeSelectorRequired {
    if ((fields__set[0] & 0x4) == 0) {
        self.recordTypeSelectorRequired__v = [self boolean:@"recordTypeSelectorRequired"];
        fields__set[0] |= 0x4;
    }
    return self.recordTypeSelectorRequired__v;
}

-(void)setRecordTypeSelectorRequired:(BOOL)v {
    self.recordTypeSelectorRequired__v = v;
    fields__set[0] |= 0x4;
}

-(void)serializeTo:(ZKXmlWriter *)env elemName:(NSString *)elemName {
	[env startElement:elemName];
	[env addElementArray:@"layouts"                   elemValue:self.layouts];
	[env addElementArray:@"recordTypeMappings"        elemValue:self.recordTypeMappings];
	[env addBoolElement:@"recordTypeSelectorRequired" elemValue:self.recordTypeSelectorRequired];
	[env endElement:elemName];
}
@end
