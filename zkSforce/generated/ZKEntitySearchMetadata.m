// Copyright (c) 2017 Simon Fell
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

#import "ZKEntitySearchMetadata.h"
#import "ZKEnvelope.h"
#import "ZKEntityErrorMetadata.h"
#import "ZKEntityIntentQueryMetadata.h"
#import "ZKEntitySearchPromotionMetadata.h"
#import "ZKEntitySpellCorrectionMetadata.h"
#import "ZKFieldLevelSearchMetadata.h"

@interface ZKEntitySearchMetadata()
@property (strong,nonatomic) NSString                               *entityName__v;
@property (strong,nonatomic) ZKEntityErrorMetadata                  *errorMetadata__v;
@property (strong,nonatomic) NSArray<ZKFieldLevelSearchMetadata *>  *fieldMetadata__v;
@property (strong,nonatomic) ZKEntityIntentQueryMetadata            *intentQueryMetadata__v;
@property (strong,nonatomic) ZKEntitySearchPromotionMetadata        *searchPromotionMetadata__v;
@property (strong,nonatomic) ZKEntitySpellCorrectionMetadata        *spellCorrectionMetadata__v;
@end

@implementation ZKEntitySearchMetadata


+(void)load {
    [self registerType:self xmlName:@"EntitySearchMetadata"];
}

+(ZKComplexTypeInfo *)wsdlSchema {
   static ZKComplexTypeInfo *wsdlSchema;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
       wsdlSchema = [[ZKComplexTypeInfo alloc] initWithType:@"EntitySearchMetadata" parent:nil
                    fields:@[
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"entityName" propertyName:@"entityName" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"errorMetadata" propertyName:@"errorMetadata" optional:YES nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"fieldMetadata" propertyName:@"fieldMetadata" optional:YES nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"intentQueryMetadata" propertyName:@"intentQueryMetadata" optional:YES nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"searchPromotionMetadata" propertyName:@"searchPromotionMetadata" optional:YES nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"spellCorrectionMetadata" propertyName:@"spellCorrectionMetadata" optional:YES nillable:NO],

                    ]];
   });
   return wsdlSchema;
}
    

-(NSString *)entityName {
    if ((fields__set[0] & 0x1) == 0) {
        self.entityName__v = [self string:@"entityName"];
        fields__set[0] |= 0x1;
    }
    return self.entityName__v;
}

-(void)setEntityName:(NSString *)v {
    self.entityName__v = v;
    fields__set[0] |= 0x1;
}


-(ZKEntityErrorMetadata *)errorMetadata {
    if ((fields__set[0] & 0x2) == 0) {
        self.errorMetadata__v = [self complexTypeArrayFromElements:@"errorMetadata" cls:[ZKEntityErrorMetadata class]].lastObject;
        fields__set[0] |= 0x2;
    }
    return self.errorMetadata__v;
}

-(void)setErrorMetadata:(ZKEntityErrorMetadata *)v {
    self.errorMetadata__v = v;
    fields__set[0] |= 0x2;
}


-(NSArray<ZKFieldLevelSearchMetadata *> *)fieldMetadata {
    if ((fields__set[0] & 0x4) == 0) {
        self.fieldMetadata__v = [self complexTypeArrayFromElements:@"fieldMetadata" cls:[ZKFieldLevelSearchMetadata class]];
        fields__set[0] |= 0x4;
    }
    return self.fieldMetadata__v;
}

-(void)setFieldMetadata:(NSArray<ZKFieldLevelSearchMetadata *> *)v {
    self.fieldMetadata__v = v;
    fields__set[0] |= 0x4;
}


-(ZKEntityIntentQueryMetadata *)intentQueryMetadata {
    if ((fields__set[0] & 0x8) == 0) {
        self.intentQueryMetadata__v = [self complexTypeArrayFromElements:@"intentQueryMetadata" cls:[ZKEntityIntentQueryMetadata class]].lastObject;
        fields__set[0] |= 0x8;
    }
    return self.intentQueryMetadata__v;
}

-(void)setIntentQueryMetadata:(ZKEntityIntentQueryMetadata *)v {
    self.intentQueryMetadata__v = v;
    fields__set[0] |= 0x8;
}


-(ZKEntitySearchPromotionMetadata *)searchPromotionMetadata {
    if ((fields__set[0] & 0x10) == 0) {
        self.searchPromotionMetadata__v = [self complexTypeArrayFromElements:@"searchPromotionMetadata" cls:[ZKEntitySearchPromotionMetadata class]].lastObject;
        fields__set[0] |= 0x10;
    }
    return self.searchPromotionMetadata__v;
}

-(void)setSearchPromotionMetadata:(ZKEntitySearchPromotionMetadata *)v {
    self.searchPromotionMetadata__v = v;
    fields__set[0] |= 0x10;
}


-(ZKEntitySpellCorrectionMetadata *)spellCorrectionMetadata {
    if ((fields__set[0] & 0x20) == 0) {
        self.spellCorrectionMetadata__v = [self complexTypeArrayFromElements:@"spellCorrectionMetadata" cls:[ZKEntitySpellCorrectionMetadata class]].lastObject;
        fields__set[0] |= 0x20;
    }
    return self.spellCorrectionMetadata__v;
}

-(void)setSpellCorrectionMetadata:(ZKEntitySpellCorrectionMetadata *)v {
    self.spellCorrectionMetadata__v = v;
    fields__set[0] |= 0x20;
}

-(void)serializeTo:(ZKXmlWriter *)env elemName:(NSString *)elemName {
	[env startElement:elemName];
	[env addElement:@"entityName"              elemValue:self.entityName              nillable:NO  optional:NO];
	[env addElement:@"errorMetadata"           elemValue:self.errorMetadata           nillable:NO  optional:YES];
	[env addElementArray:@"fieldMetadata"      elemValue:self.fieldMetadata];
	[env addElement:@"intentQueryMetadata"     elemValue:self.intentQueryMetadata     nillable:NO  optional:YES];
	[env addElement:@"searchPromotionMetadata" elemValue:self.searchPromotionMetadata nillable:NO  optional:YES];
	[env addElement:@"spellCorrectionMetadata" elemValue:self.spellCorrectionMetadata nillable:NO  optional:YES];
	[env endElement:elemName];
}
@end
