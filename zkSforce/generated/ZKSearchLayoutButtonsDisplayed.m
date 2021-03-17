// Copyright (c) 2021 Simon Fell
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

#import "ZKSearchLayoutButtonsDisplayed.h"
#import "ZKEnvelope.h"
#import "ZKSearchLayoutButton.h"

@interface ZKSearchLayoutButtonsDisplayed()
@property (assign,nonatomic) BOOL                              applicable__v;
@property (strong,nonatomic) NSArray<ZKSearchLayoutButton *>  *buttons__v;
@end

@implementation ZKSearchLayoutButtonsDisplayed


+(void)load {
    [self registerType:self xmlName:@"SearchLayoutButtonsDisplayed"];
}

+(ZKComplexTypeInfo *)wsdlSchema {
   static ZKComplexTypeInfo *wsdlSchema;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
       wsdlSchema = [[ZKComplexTypeInfo alloc] initWithType:@"SearchLayoutButtonsDisplayed" parent:nil
                    fields:@[
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"applicable" propertyName:@"applicable" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"buttons" propertyName:@"buttons" optional:YES nillable:NO],

                    ]];
   });
   return wsdlSchema;
}
    

-(BOOL)applicable {
    if ((fields__set[0] & 0x1) == 0) {
        self.applicable__v = [self boolean:@"applicable"];
        fields__set[0] |= 0x1;
    }
    return self.applicable__v;
}

-(void)setApplicable:(BOOL)v {
    self.applicable__v = v;
    fields__set[0] |= 0x1;
}


-(NSArray<ZKSearchLayoutButton *> *)buttons {
    if ((fields__set[0] & 0x2) == 0) {
        self.buttons__v = [self complexTypeArrayFromElements:@"buttons" cls:[ZKSearchLayoutButton class]];
        fields__set[0] |= 0x2;
    }
    return self.buttons__v;
}

-(void)setButtons:(NSArray<ZKSearchLayoutButton *> *)v {
    self.buttons__v = v;
    fields__set[0] |= 0x2;
}

-(void)serializeTo:(ZKXmlWriter *)env elemName:(NSString *)elemName {
	[env startElement:elemName];
	[env addBoolElement:@"applicable" elemValue:self.applicable];
	[env addElementArray:@"buttons"   elemValue:self.buttons];
	[env endElement:elemName];
}
@end
