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

#import "ZKCustomLinkComponent.h"
#import "ZKEnvelope.h"
#import "ZKDescribeLayoutButton.h"

@interface ZKCustomLinkComponent()
@property (strong,nonatomic) ZKDescribeLayoutButton  *customLink__v;
@end

@implementation ZKCustomLinkComponent


+(void)load {
    [self registerType:self xmlName:@"CustomLinkComponent"];
}

+(ZKComplexTypeInfo *)wsdlSchema {
   static ZKComplexTypeInfo *wsdlSchema;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
       wsdlSchema = [[ZKComplexTypeInfo alloc] initWithType:@"CustomLinkComponent" parent:[ZKDescribeLayoutComponent class]
                    fields:@[
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"customLink" propertyName:@"customLink" optional:NO nillable:NO],

                    ]];
   });
   return wsdlSchema;
}
    

-(ZKDescribeLayoutButton *)customLink {
    if ((fields__set2[0] & 0x1) == 0) {
        self.customLink__v = [self complexTypeArrayFromElements:@"customLink" cls:[ZKDescribeLayoutButton class]].lastObject;
        fields__set2[0] |= 0x1;
    }
    return self.customLink__v;
}

-(void)setCustomLink:(ZKDescribeLayoutButton *)v {
    self.customLink__v = v;
    fields__set2[0] |= 0x1;
}

-(void)serializeTo:(ZKXmlWriter *)env elemName:(NSString *)elemName {
	[env startElement:elemName type:@"CustomLinkComponent"];
	[env addIntElement:@"displayLines" elemValue:self.displayLines];
	[env addIntElement:@"tabOrder"     elemValue:self.tabOrder];
	[env addElement:@"type"            elemValue:self.type         nillable:NO  optional:NO];
	[env addElement:@"value"           elemValue:self.value        nillable:YES optional:NO];
	[env addElement:@"customLink"      elemValue:self.customLink   nillable:NO  optional:NO];
	[env endElement:elemName];
}
@end
