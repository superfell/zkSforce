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

#import "ZKChangeEventHeader.h"
#import "ZKEnvelope.h"

@interface ZKChangeEventHeader()
@property (strong,nonatomic) NSString             *entityName__v;
@property (strong,nonatomic) NSArray<NSString *>  *recordIds__v;
@property (assign,nonatomic) int64_t               commitTimestamp__v;
@property (assign,nonatomic) int64_t               commitNumber__v;
@property (strong,nonatomic) NSString             *commitUser__v;
@property (strong,nonatomic) NSArray<NSString *>  *diffFields__v;
@property (strong,nonatomic) NSString             *changeType__v;
@property (strong,nonatomic) NSString             *changeOrigin__v;
@property (strong,nonatomic) NSString             *transactionKey__v;
@property (assign,nonatomic) NSInteger             sequenceNumber__v;
@property (strong,nonatomic) NSArray<NSString *>  *nulledFields__v;
@property (strong,nonatomic) NSArray<NSString *>  *changedFields__v;
@end

@implementation ZKChangeEventHeader


+(void)load {
    [self registerType:self xmlName:@"ChangeEventHeader"];
}

+(ZKComplexTypeInfo *)wsdlSchema {
   static ZKComplexTypeInfo *wsdlSchema;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
       wsdlSchema = [[ZKComplexTypeInfo alloc] initWithType:@"ChangeEventHeader" parent:nil
                    fields:@[
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"entityName" propertyName:@"entityName" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"recordIds" propertyName:@"recordIds" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"commitTimestamp" propertyName:@"commitTimestamp" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"commitNumber" propertyName:@"commitNumber" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"commitUser" propertyName:@"commitUser" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"diffFields" propertyName:@"diffFields" optional:YES nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"changeType" propertyName:@"changeType" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"changeOrigin" propertyName:@"changeOrigin" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"transactionKey" propertyName:@"transactionKey" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"sequenceNumber" propertyName:@"sequenceNumber" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"nulledFields" propertyName:@"nulledFields" optional:YES nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"changedFields" propertyName:@"changedFields" optional:YES nillable:NO],

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


-(NSArray<NSString *> *)recordIds {
    if ((fields__set[0] & 0x2) == 0) {
        self.recordIds__v = [self strings:@"recordIds"];
        fields__set[0] |= 0x2;
    }
    return self.recordIds__v;
}

-(void)setRecordIds:(NSArray<NSString *> *)v {
    self.recordIds__v = v;
    fields__set[0] |= 0x2;
}


-(int64_t)commitTimestamp {
    if ((fields__set[0] & 0x4) == 0) {
        self.commitTimestamp__v = [self int64:@"commitTimestamp"];
        fields__set[0] |= 0x4;
    }
    return self.commitTimestamp__v;
}

-(void)setCommitTimestamp:(int64_t)v {
    self.commitTimestamp__v = v;
    fields__set[0] |= 0x4;
}


-(int64_t)commitNumber {
    if ((fields__set[0] & 0x8) == 0) {
        self.commitNumber__v = [self int64:@"commitNumber"];
        fields__set[0] |= 0x8;
    }
    return self.commitNumber__v;
}

-(void)setCommitNumber:(int64_t)v {
    self.commitNumber__v = v;
    fields__set[0] |= 0x8;
}


-(NSString *)commitUser {
    if ((fields__set[0] & 0x10) == 0) {
        self.commitUser__v = [self string:@"commitUser"];
        fields__set[0] |= 0x10;
    }
    return self.commitUser__v;
}

-(void)setCommitUser:(NSString *)v {
    self.commitUser__v = v;
    fields__set[0] |= 0x10;
}


-(NSArray<NSString *> *)diffFields {
    if ((fields__set[0] & 0x20) == 0) {
        self.diffFields__v = [self strings:@"diffFields"];
        fields__set[0] |= 0x20;
    }
    return self.diffFields__v;
}

-(void)setDiffFields:(NSArray<NSString *> *)v {
    self.diffFields__v = v;
    fields__set[0] |= 0x20;
}


-(NSString *)changeType {
    if ((fields__set[0] & 0x40) == 0) {
        self.changeType__v = [self string:@"changeType"];
        fields__set[0] |= 0x40;
    }
    return self.changeType__v;
}

-(void)setChangeType:(NSString *)v {
    self.changeType__v = v;
    fields__set[0] |= 0x40;
}


-(NSString *)changeOrigin {
    if ((fields__set[0] & 0x80) == 0) {
        self.changeOrigin__v = [self string:@"changeOrigin"];
        fields__set[0] |= 0x80;
    }
    return self.changeOrigin__v;
}

-(void)setChangeOrigin:(NSString *)v {
    self.changeOrigin__v = v;
    fields__set[0] |= 0x80;
}


-(NSString *)transactionKey {
    if ((fields__set[0] & 0x100) == 0) {
        self.transactionKey__v = [self string:@"transactionKey"];
        fields__set[0] |= 0x100;
    }
    return self.transactionKey__v;
}

-(void)setTransactionKey:(NSString *)v {
    self.transactionKey__v = v;
    fields__set[0] |= 0x100;
}


-(NSInteger)sequenceNumber {
    if ((fields__set[0] & 0x200) == 0) {
        self.sequenceNumber__v = [self integer:@"sequenceNumber"];
        fields__set[0] |= 0x200;
    }
    return self.sequenceNumber__v;
}

-(void)setSequenceNumber:(NSInteger)v {
    self.sequenceNumber__v = v;
    fields__set[0] |= 0x200;
}


-(NSArray<NSString *> *)nulledFields {
    if ((fields__set[0] & 0x400) == 0) {
        self.nulledFields__v = [self strings:@"nulledFields"];
        fields__set[0] |= 0x400;
    }
    return self.nulledFields__v;
}

-(void)setNulledFields:(NSArray<NSString *> *)v {
    self.nulledFields__v = v;
    fields__set[0] |= 0x400;
}


-(NSArray<NSString *> *)changedFields {
    if ((fields__set[0] & 0x800) == 0) {
        self.changedFields__v = [self strings:@"changedFields"];
        fields__set[0] |= 0x800;
    }
    return self.changedFields__v;
}

-(void)setChangedFields:(NSArray<NSString *> *)v {
    self.changedFields__v = v;
    fields__set[0] |= 0x800;
}

-(void)serializeTo:(ZKXmlWriter *)env elemName:(NSString *)elemName {
	[env startElement:elemName];
	[env addElement:@"entityName"           elemValue:self.entityName      nillable:NO  optional:NO];
	[env addElementArray:@"recordIds"       elemValue:self.recordIds];
	[env addInt64Element:@"commitTimestamp" elemValue:self.commitTimestamp];
	[env addInt64Element:@"commitNumber"    elemValue:self.commitNumber];
	[env addElement:@"commitUser"           elemValue:self.commitUser      nillable:NO  optional:NO];
	[env addElementArray:@"diffFields"      elemValue:self.diffFields];
	[env addElement:@"changeType"           elemValue:self.changeType      nillable:NO  optional:NO];
	[env addElement:@"changeOrigin"         elemValue:self.changeOrigin    nillable:NO  optional:NO];
	[env addElement:@"transactionKey"       elemValue:self.transactionKey  nillable:NO  optional:NO];
	[env addIntElement:@"sequenceNumber"    elemValue:self.sequenceNumber];
	[env addElementArray:@"nulledFields"    elemValue:self.nulledFields];
	[env addElementArray:@"changedFields"   elemValue:self.changedFields];
	[env endElement:elemName];
}
@end
