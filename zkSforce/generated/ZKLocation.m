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

#import "ZKLocation.h"
#import "ZKEnvelope.h"

@interface ZKLocation()
@property (assign,nonatomic) double latitude__v;
@property (assign,nonatomic) double longitude__v;
@end

@implementation ZKLocation


+(void)load {
    [self registerType:self xmlName:@"location"];
}

+(ZKComplexTypeInfo *)wsdlSchema {
   static ZKComplexTypeInfo *wsdlSchema;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
       wsdlSchema = [[ZKComplexTypeInfo alloc] initWithType:@"location" parent:nil
                    fields:@[
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"latitude" propertyName:@"latitude" optional:NO nillable:YES],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"longitude" propertyName:@"longitude" optional:NO nillable:YES],

                    ]];
   });
   return wsdlSchema;
}
    

-(double)latitude {
    if ((fields__set[0] & 0x1) == 0) {
        self.latitude__v = [self double:@"latitude"];
        fields__set[0] |= 0x1;
    }
    return self.latitude__v;
}

-(void)setLatitude:(double)v {
    self.latitude__v = v;
    fields__set[0] |= 0x1;
}


-(double)longitude {
    if ((fields__set[0] & 0x2) == 0) {
        self.longitude__v = [self double:@"longitude"];
        fields__set[0] |= 0x2;
    }
    return self.longitude__v;
}

-(void)setLongitude:(double)v {
    self.longitude__v = v;
    fields__set[0] |= 0x2;
}

-(void)serializeTo:(ZKXmlWriter *)env elemName:(NSString *)elemName {
	[env startElement:elemName];
	[env addDoubleElement:@"latitude"  elemValue:self.latitude];
	[env addDoubleElement:@"longitude" elemValue:self.longitude];
	[env endElement:elemName];
}
@end
