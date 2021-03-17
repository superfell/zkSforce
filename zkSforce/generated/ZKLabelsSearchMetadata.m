// Copyright (c) 2016 Simon Fell
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

#import "ZKLabelsSearchMetadata.h"
#import "ZKEnvelope.h"
#import "ZKNameValuePair.h"

@interface ZKLabelsSearchMetadata()
@property (strong,nonatomic) NSArray<ZKNameValuePair *>  *entityFieldLabels__v;
@property (strong,nonatomic) NSString                    *entityName__v;
@end

@implementation ZKLabelsSearchMetadata


+(void)load {
    [self registerType:self xmlName:@"LabelsSearchMetadata"];
}

+(ZKComplexTypeInfo *)wsdlSchema {
   static ZKComplexTypeInfo *wsdlSchema;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
       wsdlSchema = [[ZKComplexTypeInfo alloc] initWithType:@"LabelsSearchMetadata" parent:nil
                    fields:@[
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"entityFieldLabels" propertyName:@"entityFieldLabels" optional:YES nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"entityName" propertyName:@"entityName" optional:NO nillable:NO],

                    ]];
   });
   return wsdlSchema;
}
    

-(NSArray<ZKNameValuePair *> *)entityFieldLabels {
    if ((fields__set[0] & 0x1) == 0) {
        self.entityFieldLabels__v = [self complexTypeArrayFromElements:@"entityFieldLabels" cls:[ZKNameValuePair class]];
        fields__set[0] |= 0x1;
    }
    return self.entityFieldLabels__v;
}

-(void)setEntityFieldLabels:(NSArray<ZKNameValuePair *> *)v {
    self.entityFieldLabels__v = v;
    fields__set[0] |= 0x1;
}


-(NSString *)entityName {
    if ((fields__set[0] & 0x2) == 0) {
        self.entityName__v = [self string:@"entityName"];
        fields__set[0] |= 0x2;
    }
    return self.entityName__v;
}

-(void)setEntityName:(NSString *)v {
    self.entityName__v = v;
    fields__set[0] |= 0x2;
}

-(void)serializeTo:(ZKXmlWriter *)env elemName:(NSString *)elemName {
	[env startElement:elemName];
	[env addElementArray:@"entityFieldLabels" elemValue:self.entityFieldLabels];
	[env addElement:@"entityName"             elemValue:self.entityName        nillable:NO  optional:NO];
	[env endElement:elemName];
}
@end
