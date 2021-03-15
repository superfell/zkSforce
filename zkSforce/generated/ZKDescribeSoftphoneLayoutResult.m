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

#import "ZKDescribeSoftphoneLayoutResult.h"
#import "ZKEnvelope.h"
#import "ZKDescribeSoftphoneLayoutCallType.h"

@interface ZKDescribeSoftphoneLayoutResult()
@property (strong,nonatomic) NSArray<ZKDescribeSoftphoneLayoutCallType *>  *callTypes__v;
@property (strong,nonatomic) NSString                                      *id__v;
@property (strong,nonatomic) NSString                                      *name__v;
@end

@implementation ZKDescribeSoftphoneLayoutResult


+(void)load {
    [self registerType:self xmlName:@"DescribeSoftphoneLayoutResult"];
}

+(ZKComplexTypeInfo *)wsdlSchema {
   static ZKComplexTypeInfo *wsdlSchema;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
       wsdlSchema = [[ZKComplexTypeInfo alloc] initWithType:@"DescribeSoftphoneLayoutResult" parent:nil
                    fields:@[
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"callTypes" propertyName:@"callTypes" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"id" propertyName:@"id" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"name" propertyName:@"name" optional:NO nillable:NO],

                    ]];
   });
   return wsdlSchema;
}
    

-(NSArray<ZKDescribeSoftphoneLayoutCallType *> *)callTypes {
    if ((fields__set[0] & 0x1) == 0) {
        self.callTypes__v = [self complexTypeArrayFromElements:@"callTypes" cls:[ZKDescribeSoftphoneLayoutCallType class]];
        fields__set[0] |= 0x1; 
    }
    return self.callTypes__v;
}
        

-(void)setCallTypes:(NSArray<ZKDescribeSoftphoneLayoutCallType *> *)v {
    self.callTypes__v = v;
    fields__set[0] |= 0x1; 
}
        

-(NSString *)id {
    if ((fields__set[0] & 0x2) == 0) {
        self.id__v = [self string:@"id"];
        fields__set[0] |= 0x2; 
    }
    return self.id__v;
}
        

-(void)setId:(NSString *)v {
    self.id__v = v;
    fields__set[0] |= 0x2; 
}
        

-(NSString *)name {
    if ((fields__set[0] & 0x4) == 0) {
        self.name__v = [self string:@"name"];
        fields__set[0] |= 0x4; 
    }
    return self.name__v;
}
        

-(void)setName:(NSString *)v {
    self.name__v = v;
    fields__set[0] |= 0x4; 
}
        
-(void)serializeTo:(ZKXmlWriter *)env elemName:(NSString *)elemName {
	[env startElement:elemName];
	[env addElementArray:@"callTypes" elemValue:self.callTypes];
	[env addElement:@"id"             elemValue:self.id        nillable:NO  optional:NO];
	[env addElement:@"name"           elemValue:self.name      nillable:NO  optional:NO];
	[env endElement:elemName];
}
@end
