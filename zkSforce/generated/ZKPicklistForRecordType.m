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

#import "ZKPicklistForRecordType.h"
#import "ZKEnvelope.h"
#import "ZKPicklistEntry.h"

@interface ZKPicklistForRecordType()
@property (strong,nonatomic) NSString                    *picklistName__v;
@property (strong,nonatomic) NSArray<ZKPicklistEntry *>  *picklistValues__v;
@end

@implementation ZKPicklistForRecordType


+(void)load {
    [self registerType:self xmlName:@"PicklistForRecordType"];
}

+(ZKComplexTypeInfo *)wsdlSchema {
   static ZKComplexTypeInfo *wsdlSchema;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
       wsdlSchema = [[ZKComplexTypeInfo alloc] initWithType:@"PicklistForRecordType" parent:nil
                    fields:@[
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"picklistName" propertyName:@"picklistName" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"picklistValues" propertyName:@"picklistValues" optional:YES nillable:YES],

                    ]];
   });
   return wsdlSchema;
}
    

-(NSString *)picklistName {
    if ((fields__set[0] & 0x1) == 0) {
        self.picklistName__v = [self string:@"picklistName"];
        fields__set[0] |= 0x1;
    }
    return self.picklistName__v;
}

-(void)setPicklistName:(NSString *)v {
    self.picklistName__v = v;
    fields__set[0] |= 0x1;
}


-(NSArray<ZKPicklistEntry *> *)picklistValues {
    if ((fields__set[0] & 0x2) == 0) {
        self.picklistValues__v = [self complexTypeArrayFromElements:@"picklistValues" cls:[ZKPicklistEntry class]];
        fields__set[0] |= 0x2;
    }
    return self.picklistValues__v;
}

-(void)setPicklistValues:(NSArray<ZKPicklistEntry *> *)v {
    self.picklistValues__v = v;
    fields__set[0] |= 0x2;
}

-(void)serializeTo:(ZKXmlWriter *)env elemName:(NSString *)elemName {
	[env startElement:elemName];
	[env addElement:@"picklistName"        elemValue:self.picklistName   nillable:NO  optional:NO];
	[env addElementArray:@"picklistValues" elemValue:self.picklistValues];
	[env endElement:elemName];
}
@end
