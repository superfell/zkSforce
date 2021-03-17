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

#import "ZKDescribeSoqlListView.h"
#import "ZKEnvelope.h"
#import "ZKListViewColumn.h"
#import "ZKListViewOrderBy.h"
#import "ZKSoqlWhereCondition.h"

@interface ZKDescribeSoqlListView()
@property (strong,nonatomic) NSArray<ZKListViewColumn *>   *columns__v;
@property (strong,nonatomic) NSString                      *id__v;
@property (strong,nonatomic) NSArray<ZKListViewOrderBy *>  *orderBy__v;
@property (strong,nonatomic) NSString                      *query__v;
@property (strong,nonatomic) NSString                      *relatedEntityId__v;
@property (strong,nonatomic) NSString                      *scope__v;
@property (strong,nonatomic) NSString                      *scopeEntityId__v;
@property (strong,nonatomic) NSString                      *sobjectType__v;
@property (strong,nonatomic) ZKSoqlWhereCondition          *whereCondition__v;
@end

@implementation ZKDescribeSoqlListView


+(void)load {
    [self registerType:self xmlName:@"DescribeSoqlListView"];
}

+(ZKComplexTypeInfo *)wsdlSchema {
   static ZKComplexTypeInfo *wsdlSchema;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
       wsdlSchema = [[ZKComplexTypeInfo alloc] initWithType:@"DescribeSoqlListView" parent:nil
                    fields:@[
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"columns" propertyName:@"columns" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"id" propertyName:@"id" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"orderBy" propertyName:@"orderBy" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"query" propertyName:@"query" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"relatedEntityId" propertyName:@"relatedEntityId" optional:YES nillable:YES],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"scope" propertyName:@"scope" optional:NO nillable:YES],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"scopeEntityId" propertyName:@"scopeEntityId" optional:YES nillable:YES],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"sobjectType" propertyName:@"sobjectType" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"whereCondition" propertyName:@"whereCondition" optional:YES nillable:NO],

                    ]];
   });
   return wsdlSchema;
}
    

-(NSArray<ZKListViewColumn *> *)columns {
    if ((fields__set[0] & 0x1) == 0) {
        self.columns__v = [self complexTypeArrayFromElements:@"columns" cls:[ZKListViewColumn class]];
        fields__set[0] |= 0x1;
    }
    return self.columns__v;
}

-(void)setColumns:(NSArray<ZKListViewColumn *> *)v {
    self.columns__v = v;
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


-(NSArray<ZKListViewOrderBy *> *)orderBy {
    if ((fields__set[0] & 0x4) == 0) {
        self.orderBy__v = [self complexTypeArrayFromElements:@"orderBy" cls:[ZKListViewOrderBy class]];
        fields__set[0] |= 0x4;
    }
    return self.orderBy__v;
}

-(void)setOrderBy:(NSArray<ZKListViewOrderBy *> *)v {
    self.orderBy__v = v;
    fields__set[0] |= 0x4;
}


-(NSString *)query {
    if ((fields__set[0] & 0x8) == 0) {
        self.query__v = [self string:@"query"];
        fields__set[0] |= 0x8;
    }
    return self.query__v;
}

-(void)setQuery:(NSString *)v {
    self.query__v = v;
    fields__set[0] |= 0x8;
}


-(NSString *)relatedEntityId {
    if ((fields__set[0] & 0x10) == 0) {
        self.relatedEntityId__v = [self string:@"relatedEntityId"];
        fields__set[0] |= 0x10;
    }
    return self.relatedEntityId__v;
}

-(void)setRelatedEntityId:(NSString *)v {
    self.relatedEntityId__v = v;
    fields__set[0] |= 0x10;
}


-(NSString *)scope {
    if ((fields__set[0] & 0x20) == 0) {
        self.scope__v = [self string:@"scope"];
        fields__set[0] |= 0x20;
    }
    return self.scope__v;
}

-(void)setScope:(NSString *)v {
    self.scope__v = v;
    fields__set[0] |= 0x20;
}


-(NSString *)scopeEntityId {
    if ((fields__set[0] & 0x40) == 0) {
        self.scopeEntityId__v = [self string:@"scopeEntityId"];
        fields__set[0] |= 0x40;
    }
    return self.scopeEntityId__v;
}

-(void)setScopeEntityId:(NSString *)v {
    self.scopeEntityId__v = v;
    fields__set[0] |= 0x40;
}


-(NSString *)sobjectType {
    if ((fields__set[0] & 0x80) == 0) {
        self.sobjectType__v = [self string:@"sobjectType"];
        fields__set[0] |= 0x80;
    }
    return self.sobjectType__v;
}

-(void)setSobjectType:(NSString *)v {
    self.sobjectType__v = v;
    fields__set[0] |= 0x80;
}


-(ZKSoqlWhereCondition *)whereCondition {
    if ((fields__set[0] & 0x100) == 0) {
        self.whereCondition__v = [self complexTypeArrayFromElements:@"whereCondition" cls:[ZKSoqlWhereCondition class]].lastObject;
        fields__set[0] |= 0x100;
    }
    return self.whereCondition__v;
}

-(void)setWhereCondition:(ZKSoqlWhereCondition *)v {
    self.whereCondition__v = v;
    fields__set[0] |= 0x100;
}

-(void)serializeTo:(ZKXmlWriter *)env elemName:(NSString *)elemName {
	[env startElement:elemName];
	[env addElementArray:@"columns"    elemValue:self.columns];
	[env addElement:@"id"              elemValue:self.id              nillable:NO  optional:NO];
	[env addElementArray:@"orderBy"    elemValue:self.orderBy];
	[env addElement:@"query"           elemValue:self.query           nillable:NO  optional:NO];
	[env addElement:@"relatedEntityId" elemValue:self.relatedEntityId nillable:YES optional:YES];
	[env addElement:@"scope"           elemValue:self.scope           nillable:YES optional:NO];
	[env addElement:@"scopeEntityId"   elemValue:self.scopeEntityId   nillable:YES optional:YES];
	[env addElement:@"sobjectType"     elemValue:self.sobjectType     nillable:NO  optional:NO];
	[env addElement:@"whereCondition"  elemValue:self.whereCondition  nillable:NO  optional:YES];
	[env endElement:elemName];
}
@end
