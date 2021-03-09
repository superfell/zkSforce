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

#import "ZKExecuteListViewResult.h"
#import "ZKEnvelope.h"
#import "ZKListViewColumn.h"
#import "ZKListViewRecord.h"

@interface ZKExecuteListViewResult()
@property (strong,nonatomic) NSArray   *columns__v;
@property (strong,nonatomic) NSString  *developerName__v;
@property (assign,nonatomic) BOOL       done__v;
@property (strong,nonatomic) NSString  *id__v;
@property (strong,nonatomic) NSString  *label__v;
@property (strong,nonatomic) NSArray   *records__v;
@property (assign,nonatomic) NSInteger  size__v;
@end

@implementation ZKExecuteListViewResult


+(void)load {
    [self registerType:self xmlName:@"ExecuteListViewResult"];
}

-(NSArray *)columns {
    if ((fields__set[0] & 0x1) == 0) {
        self.columns__v = [self complexTypeArrayFromElements:@"columns" cls:[ZKListViewColumn class]];
        fields__set[0] |= 0x1; 
    }
    return self.columns__v;
}
        

-(void)setColumns:(NSArray *)v {
    self.columns__v = v;
    fields__set[0] |= 0x1; 
}
        

-(NSString *)developerName {
    if ((fields__set[0] & 0x2) == 0) {
        self.developerName__v = [self string:@"developerName"];
        fields__set[0] |= 0x2; 
    }
    return self.developerName__v;
}
        

-(void)setDeveloperName:(NSString *)v {
    self.developerName__v = v;
    fields__set[0] |= 0x2; 
}
        

-(BOOL)done {
    if ((fields__set[0] & 0x4) == 0) {
        self.done__v = [self boolean:@"done"];
        fields__set[0] |= 0x4; 
    }
    return self.done__v;
}
        

-(void)setDone:(BOOL)v {
    self.done__v = v;
    fields__set[0] |= 0x4; 
}
        

-(NSString *)id {
    if ((fields__set[0] & 0x8) == 0) {
        self.id__v = [self string:@"id"];
        fields__set[0] |= 0x8; 
    }
    return self.id__v;
}
        

-(void)setId:(NSString *)v {
    self.id__v = v;
    fields__set[0] |= 0x8; 
}
        

-(NSString *)label {
    if ((fields__set[0] & 0x10) == 0) {
        self.label__v = [self string:@"label"];
        fields__set[0] |= 0x10; 
    }
    return self.label__v;
}
        

-(void)setLabel:(NSString *)v {
    self.label__v = v;
    fields__set[0] |= 0x10; 
}
        

-(NSArray *)records {
    if ((fields__set[0] & 0x20) == 0) {
        self.records__v = [self complexTypeArrayFromElements:@"records" cls:[ZKListViewRecord class]];
        fields__set[0] |= 0x20; 
    }
    return self.records__v;
}
        

-(void)setRecords:(NSArray *)v {
    self.records__v = v;
    fields__set[0] |= 0x20; 
}
        

-(NSInteger)size {
    if ((fields__set[0] & 0x40) == 0) {
        self.size__v = [self integer:@"size"];
        fields__set[0] |= 0x40; 
    }
    return self.size__v;
}
        

-(void)setSize:(NSInteger)v {
    self.size__v = v;
    fields__set[0] |= 0x40; 
}
        
-(void)serializeTo:(ZKXmlWriter *)env elemName:(NSString *)elemName {
	[env startElement:elemName];
	[env addElementArray:@"columns"  elemValue:self.columns];
	[env addElement:@"developerName" elemValue:self.developerName nillable:NO  optional:NO];
	[env addBoolElement:@"done"      elemValue:self.done];
	[env addElement:@"id"            elemValue:self.id            nillable:NO  optional:NO];
	[env addElement:@"label"         elemValue:self.label         nillable:NO  optional:NO];
	[env addElementArray:@"records"  elemValue:self.records];
	[env addIntElement:@"size"       elemValue:self.size];
	[env endElement:elemName];
}
@end
