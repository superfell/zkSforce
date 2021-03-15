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

#import "ZKDescribeThemeResult.h"
#import "ZKEnvelope.h"
#import "ZKDescribeThemeItem.h"

@interface ZKDescribeThemeResult()
@property (strong,nonatomic) NSArray<ZKDescribeThemeItem *>  *themeItems__v;
@end

@implementation ZKDescribeThemeResult


+(void)load {
    [self registerType:self xmlName:@"DescribeThemeResult"];
}

+(ZKComplexTypeInfo *)wsdlSchema {
   static ZKComplexTypeInfo *wsdlSchema;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
       wsdlSchema = [[ZKComplexTypeInfo alloc] initWithType:@"DescribeThemeResult" parent:nil
                    fields:@[
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"themeItems" propertyName:@"themeItems" optional:YES nillable:NO],

                    ]];
   });
   return wsdlSchema;
}
    

-(NSArray<ZKDescribeThemeItem *> *)themeItems {
    if ((fields__set[0] & 0x1) == 0) {
        self.themeItems__v = [self complexTypeArrayFromElements:@"themeItems" cls:[ZKDescribeThemeItem class]];
        fields__set[0] |= 0x1; 
    }
    return self.themeItems__v;
}
        

-(void)setThemeItems:(NSArray<ZKDescribeThemeItem *> *)v {
    self.themeItems__v = v;
    fields__set[0] |= 0x1; 
}
        
-(void)serializeTo:(ZKXmlWriter *)env elemName:(NSString *)elemName {
	[env startElement:elemName];
	[env addElementArray:@"themeItems" elemValue:self.themeItems];
	[env endElement:elemName];
}
@end
