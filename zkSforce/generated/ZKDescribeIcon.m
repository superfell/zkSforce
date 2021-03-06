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

#import "ZKDescribeIcon.h"
#import "ZKEnvelope.h"

@interface ZKDescribeIcon()
@property (strong,nonatomic) NSString  *contentType__v;
@property (assign,nonatomic) NSInteger  height__v;
@property (strong,nonatomic) NSString  *theme__v;
@property (strong,nonatomic) NSString  *url__v;
@property (assign,nonatomic) NSInteger  width__v;
@end

@implementation ZKDescribeIcon


+(void)load {
    [self registerType:self xmlName:@"DescribeIcon"];
}

+(ZKComplexTypeInfo *)wsdlSchema {
   static ZKComplexTypeInfo *wsdlSchema;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
       wsdlSchema = [[ZKComplexTypeInfo alloc] initWithType:@"DescribeIcon" parent:nil
                    fields:@[
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"contentType" propertyName:@"contentType" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"height" propertyName:@"height" optional:NO nillable:YES],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"theme" propertyName:@"theme" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"url" propertyName:@"url" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"width" propertyName:@"width" optional:NO nillable:YES],

                    ]];
   });
   return wsdlSchema;
}
    

-(NSString *)contentType {
    if ((fields__set[0] & 0x1) == 0) {
        self.contentType__v = [self string:@"contentType"];
        fields__set[0] |= 0x1;
    }
    return self.contentType__v;
}

-(void)setContentType:(NSString *)v {
    self.contentType__v = v;
    fields__set[0] |= 0x1;
}


-(NSInteger)height {
    if ((fields__set[0] & 0x2) == 0) {
        self.height__v = [self integer:@"height"];
        fields__set[0] |= 0x2;
    }
    return self.height__v;
}

-(void)setHeight:(NSInteger)v {
    self.height__v = v;
    fields__set[0] |= 0x2;
}


-(NSString *)theme {
    if ((fields__set[0] & 0x4) == 0) {
        self.theme__v = [self string:@"theme"];
        fields__set[0] |= 0x4;
    }
    return self.theme__v;
}

-(void)setTheme:(NSString *)v {
    self.theme__v = v;
    fields__set[0] |= 0x4;
}


-(NSString *)url {
    if ((fields__set[0] & 0x8) == 0) {
        self.url__v = [self string:@"url"];
        fields__set[0] |= 0x8;
    }
    return self.url__v;
}

-(void)setUrl:(NSString *)v {
    self.url__v = v;
    fields__set[0] |= 0x8;
}


-(NSInteger)width {
    if ((fields__set[0] & 0x10) == 0) {
        self.width__v = [self integer:@"width"];
        fields__set[0] |= 0x10;
    }
    return self.width__v;
}

-(void)setWidth:(NSInteger)v {
    self.width__v = v;
    fields__set[0] |= 0x10;
}

-(void)serializeTo:(ZKXmlWriter *)env elemName:(NSString *)elemName {
	[env startElement:elemName];
	[env addElement:@"contentType" elemValue:self.contentType nillable:NO  optional:NO];
	[env addIntElement:@"height"   elemValue:self.height];
	[env addElement:@"theme"       elemValue:self.theme       nillable:NO  optional:NO];
	[env addElement:@"url"         elemValue:self.url         nillable:NO  optional:NO];
	[env addIntElement:@"width"    elemValue:self.width];
	[env endElement:elemName];
}
@end
