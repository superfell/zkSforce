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

#import "ZKRelatedListColumn.h"
#import "ZKEnvelope.h"

@interface ZKRelatedListColumn()
@property (strong,nonatomic) NSString  *field__v;
@property (strong,nonatomic) NSString  *fieldApiName__v;
@property (strong,nonatomic) NSString  *format__v;
@property (strong,nonatomic) NSString  *label__v;
@property (strong,nonatomic) NSString  *lookupId__v;
@property (strong,nonatomic) NSString  *name__v;
@property (assign,nonatomic) BOOL       sortable__v;
@end

@implementation ZKRelatedListColumn


+(void)load {
    [self registerType:self xmlName:@"RelatedListColumn"];
}

+(ZKComplexTypeInfo *)wsdlSchema {
   static ZKComplexTypeInfo *wsdlSchema;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
       wsdlSchema = [[ZKComplexTypeInfo alloc] initWithType:@"RelatedListColumn" parent:nil
                    fields:@[
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"field" propertyName:@"field" optional:NO nillable:YES],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"fieldApiName" propertyName:@"fieldApiName" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"format" propertyName:@"format" optional:NO nillable:YES],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"label" propertyName:@"label" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"lookupId" propertyName:@"lookupId" optional:YES nillable:YES],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"name" propertyName:@"name" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"sortable" propertyName:@"sortable" optional:NO nillable:NO],

                    ]];
   });
   return wsdlSchema;
}
    

-(NSString *)field {
    if ((fields__set[0] & 0x1) == 0) {
        self.field__v = [self string:@"field"];
        fields__set[0] |= 0x1;
    }
    return self.field__v;
}

-(void)setField:(NSString *)v {
    self.field__v = v;
    fields__set[0] |= 0x1;
}


-(NSString *)fieldApiName {
    if ((fields__set[0] & 0x2) == 0) {
        self.fieldApiName__v = [self string:@"fieldApiName"];
        fields__set[0] |= 0x2;
    }
    return self.fieldApiName__v;
}

-(void)setFieldApiName:(NSString *)v {
    self.fieldApiName__v = v;
    fields__set[0] |= 0x2;
}


-(NSString *)format {
    if ((fields__set[0] & 0x4) == 0) {
        self.format__v = [self string:@"format"];
        fields__set[0] |= 0x4;
    }
    return self.format__v;
}

-(void)setFormat:(NSString *)v {
    self.format__v = v;
    fields__set[0] |= 0x4;
}


-(NSString *)label {
    if ((fields__set[0] & 0x8) == 0) {
        self.label__v = [self string:@"label"];
        fields__set[0] |= 0x8;
    }
    return self.label__v;
}

-(void)setLabel:(NSString *)v {
    self.label__v = v;
    fields__set[0] |= 0x8;
}


-(NSString *)lookupId {
    if ((fields__set[0] & 0x10) == 0) {
        self.lookupId__v = [self string:@"lookupId"];
        fields__set[0] |= 0x10;
    }
    return self.lookupId__v;
}

-(void)setLookupId:(NSString *)v {
    self.lookupId__v = v;
    fields__set[0] |= 0x10;
}


-(NSString *)name {
    if ((fields__set[0] & 0x20) == 0) {
        self.name__v = [self string:@"name"];
        fields__set[0] |= 0x20;
    }
    return self.name__v;
}

-(void)setName:(NSString *)v {
    self.name__v = v;
    fields__set[0] |= 0x20;
}


-(BOOL)sortable {
    if ((fields__set[0] & 0x40) == 0) {
        self.sortable__v = [self boolean:@"sortable"];
        fields__set[0] |= 0x40;
    }
    return self.sortable__v;
}

-(void)setSortable:(BOOL)v {
    self.sortable__v = v;
    fields__set[0] |= 0x40;
}

-(void)serializeTo:(ZKXmlWriter *)env elemName:(NSString *)elemName {
	[env startElement:elemName];
	[env addElement:@"field"        elemValue:self.field        nillable:YES optional:NO];
	[env addElement:@"fieldApiName" elemValue:self.fieldApiName nillable:NO  optional:NO];
	[env addElement:@"format"       elemValue:self.format       nillable:YES optional:NO];
	[env addElement:@"label"        elemValue:self.label        nillable:NO  optional:NO];
	[env addElement:@"lookupId"     elemValue:self.lookupId     nillable:YES optional:YES];
	[env addElement:@"name"         elemValue:self.name         nillable:NO  optional:NO];
	[env addBoolElement:@"sortable" elemValue:self.sortable];
	[env endElement:elemName];
}
@end
