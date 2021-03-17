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

#import "ZKLocaleOptions.h"
#import "ZKEnvelope.h"

@interface ZKLocaleOptions()
@property (strong,nonatomic) NSString  *language__v;
@property (assign,nonatomic) BOOL       localizeErrors__v;
@end

@implementation ZKLocaleOptions


+(void)load {
    [self registerType:self xmlName:@"LocaleOptions"];
}

+(ZKComplexTypeInfo *)wsdlSchema {
   static ZKComplexTypeInfo *wsdlSchema;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
       wsdlSchema = [[ZKComplexTypeInfo alloc] initWithType:@"LocaleOptions" parent:nil
                    fields:@[
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"language" propertyName:@"language" optional:YES nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"localizeErrors" propertyName:@"localizeErrors" optional:YES nillable:NO],

                    ]];
   });
   return wsdlSchema;
}
    

-(NSString *)language {
    if ((fields__set[0] & 0x1) == 0) {
        self.language__v = [self string:@"language"];
        fields__set[0] |= 0x1;
    }
    return self.language__v;
}

-(void)setLanguage:(NSString *)v {
    self.language__v = v;
    fields__set[0] |= 0x1;
}


-(BOOL)localizeErrors {
    if ((fields__set[0] & 0x2) == 0) {
        self.localizeErrors__v = [self boolean:@"localizeErrors"];
        fields__set[0] |= 0x2;
    }
    return self.localizeErrors__v;
}

-(void)setLocalizeErrors:(BOOL)v {
    self.localizeErrors__v = v;
    fields__set[0] |= 0x2;
}

-(void)serializeTo:(ZKXmlWriter *)env elemName:(NSString *)elemName {
	[env startElement:elemName];
	[env addElement:@"language"           elemValue:self.language       nillable:NO  optional:YES];
	[env addBoolElement:@"localizeErrors" elemValue:self.localizeErrors];
	[env endElement:elemName];
}
@end
