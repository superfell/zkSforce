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

#import "ZKEmailHeader.h"
#import "ZKEnvelope.h"

@interface ZKEmailHeader()
@property (assign,nonatomic) BOOL triggerAutoResponseEmail__v;
@property (assign,nonatomic) BOOL triggerOtherEmail__v;
@property (assign,nonatomic) BOOL triggerUserEmail__v;
@end

@implementation ZKEmailHeader


+(void)load {
    [self registerType:self xmlName:@"EmailHeader"];
}

+(ZKComplexTypeInfo *)wsdlSchema {
   static ZKComplexTypeInfo *wsdlSchema;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
       wsdlSchema = [[ZKComplexTypeInfo alloc] initWithType:@"EmailHeader" parent:nil
                    fields:@[
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"triggerAutoResponseEmail" propertyName:@"triggerAutoResponseEmail" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"triggerOtherEmail" propertyName:@"triggerOtherEmail" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"triggerUserEmail" propertyName:@"triggerUserEmail" optional:NO nillable:NO],

                    ]];
   });
   return wsdlSchema;
}
    

-(BOOL)triggerAutoResponseEmail {
    if ((fields__set[0] & 0x1) == 0) {
        self.triggerAutoResponseEmail__v = [self boolean:@"triggerAutoResponseEmail"];
        fields__set[0] |= 0x1;
    }
    return self.triggerAutoResponseEmail__v;
}

-(void)setTriggerAutoResponseEmail:(BOOL)v {
    self.triggerAutoResponseEmail__v = v;
    fields__set[0] |= 0x1;
}


-(BOOL)triggerOtherEmail {
    if ((fields__set[0] & 0x2) == 0) {
        self.triggerOtherEmail__v = [self boolean:@"triggerOtherEmail"];
        fields__set[0] |= 0x2;
    }
    return self.triggerOtherEmail__v;
}

-(void)setTriggerOtherEmail:(BOOL)v {
    self.triggerOtherEmail__v = v;
    fields__set[0] |= 0x2;
}


-(BOOL)triggerUserEmail {
    if ((fields__set[0] & 0x4) == 0) {
        self.triggerUserEmail__v = [self boolean:@"triggerUserEmail"];
        fields__set[0] |= 0x4;
    }
    return self.triggerUserEmail__v;
}

-(void)setTriggerUserEmail:(BOOL)v {
    self.triggerUserEmail__v = v;
    fields__set[0] |= 0x4;
}

-(void)serializeTo:(ZKXmlWriter *)env elemName:(NSString *)elemName {
	[env startElement:elemName];
	[env addBoolElement:@"triggerAutoResponseEmail" elemValue:self.triggerAutoResponseEmail];
	[env addBoolElement:@"triggerOtherEmail"        elemValue:self.triggerOtherEmail];
	[env addBoolElement:@"triggerUserEmail"         elemValue:self.triggerUserEmail];
	[env endElement:elemName];
}
@end
