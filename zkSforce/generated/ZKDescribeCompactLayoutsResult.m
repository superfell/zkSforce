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

#import "ZKDescribeCompactLayoutsResult.h"
#import "ZKEnvelope.h"
#import "ZKDescribeCompactLayout.h"
#import "ZKRecordTypeCompactLayoutMapping.h"

@interface ZKDescribeCompactLayoutsResult()
@property (strong,nonatomic) NSArray<ZKDescribeCompactLayout *>           *compactLayouts__v;
@property (strong,nonatomic) NSString                                     *defaultCompactLayoutId__v;
@property (strong,nonatomic) NSArray<ZKRecordTypeCompactLayoutMapping *>  *recordTypeCompactLayoutMappings__v;
@end

@implementation ZKDescribeCompactLayoutsResult


+(void)load {
    [self registerType:self xmlName:@"DescribeCompactLayoutsResult"];
}

+(ZKComplexTypeInfo *)wsdlSchema {
   static ZKComplexTypeInfo *wsdlSchema;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
       wsdlSchema = [[ZKComplexTypeInfo alloc] initWithType:@"DescribeCompactLayoutsResult" parent:nil
                    fields:@[
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"compactLayouts" propertyName:@"compactLayouts" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"defaultCompactLayoutId" propertyName:@"defaultCompactLayoutId" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"recordTypeCompactLayoutMappings" propertyName:@"recordTypeCompactLayoutMappings" optional:YES nillable:NO],

                    ]];
   });
   return wsdlSchema;
}
    

-(NSArray<ZKDescribeCompactLayout *> *)compactLayouts {
    if ((fields__set[0] & 0x1) == 0) {
        self.compactLayouts__v = [self complexTypeArrayFromElements:@"compactLayouts" cls:[ZKDescribeCompactLayout class]];
        fields__set[0] |= 0x1;
    }
    return self.compactLayouts__v;
}

-(void)setCompactLayouts:(NSArray<ZKDescribeCompactLayout *> *)v {
    self.compactLayouts__v = v;
    fields__set[0] |= 0x1;
}


-(NSString *)defaultCompactLayoutId {
    if ((fields__set[0] & 0x2) == 0) {
        self.defaultCompactLayoutId__v = [self string:@"defaultCompactLayoutId"];
        fields__set[0] |= 0x2;
    }
    return self.defaultCompactLayoutId__v;
}

-(void)setDefaultCompactLayoutId:(NSString *)v {
    self.defaultCompactLayoutId__v = v;
    fields__set[0] |= 0x2;
}


-(NSArray<ZKRecordTypeCompactLayoutMapping *> *)recordTypeCompactLayoutMappings {
    if ((fields__set[0] & 0x4) == 0) {
        self.recordTypeCompactLayoutMappings__v = [self complexTypeArrayFromElements:@"recordTypeCompactLayoutMappings" cls:[ZKRecordTypeCompactLayoutMapping class]];
        fields__set[0] |= 0x4;
    }
    return self.recordTypeCompactLayoutMappings__v;
}

-(void)setRecordTypeCompactLayoutMappings:(NSArray<ZKRecordTypeCompactLayoutMapping *> *)v {
    self.recordTypeCompactLayoutMappings__v = v;
    fields__set[0] |= 0x4;
}

-(void)serializeTo:(ZKXmlWriter *)env elemName:(NSString *)elemName {
	[env startElement:elemName];
	[env addElementArray:@"compactLayouts"                  elemValue:self.compactLayouts];
	[env addElement:@"defaultCompactLayoutId"               elemValue:self.defaultCompactLayoutId          nillable:NO  optional:NO];
	[env addElementArray:@"recordTypeCompactLayoutMappings" elemValue:self.recordTypeCompactLayoutMappings];
	[env endElement:elemName];
}
@end
