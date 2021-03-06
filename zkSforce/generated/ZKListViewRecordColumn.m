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

#import "ZKListViewRecordColumn.h"
#import "ZKEnvelope.h"

@interface ZKListViewRecordColumn()
@property (strong,nonatomic) NSString  *fieldNameOrPath__v;
@property (strong,nonatomic) NSString  *value__v;
@end

@implementation ZKListViewRecordColumn


+(void)load {
    [self registerType:self xmlName:@"ListViewRecordColumn"];
}

+(ZKComplexTypeInfo *)wsdlSchema {
   static ZKComplexTypeInfo *wsdlSchema;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
       wsdlSchema = [[ZKComplexTypeInfo alloc] initWithType:@"ListViewRecordColumn" parent:nil
                    fields:@[
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"fieldNameOrPath" propertyName:@"fieldNameOrPath" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"value" propertyName:@"value" optional:NO nillable:YES],

                    ]];
   });
   return wsdlSchema;
}
    

-(NSString *)fieldNameOrPath {
    if ((fields__set[0] & 0x1) == 0) {
        self.fieldNameOrPath__v = [self string:@"fieldNameOrPath"];
        fields__set[0] |= 0x1;
    }
    return self.fieldNameOrPath__v;
}

-(void)setFieldNameOrPath:(NSString *)v {
    self.fieldNameOrPath__v = v;
    fields__set[0] |= 0x1;
}


-(NSString *)value {
    if ((fields__set[0] & 0x2) == 0) {
        self.value__v = [self string:@"value"];
        fields__set[0] |= 0x2;
    }
    return self.value__v;
}

-(void)setValue:(NSString *)v {
    self.value__v = v;
    fields__set[0] |= 0x2;
}

-(void)serializeTo:(ZKXmlWriter *)env elemName:(NSString *)elemName {
	[env startElement:elemName];
	[env addElement:@"fieldNameOrPath" elemValue:self.fieldNameOrPath nillable:NO  optional:NO];
	[env addElement:@"value"           elemValue:self.value           nillable:YES optional:NO];
	[env endElement:elemName];
}
@end
