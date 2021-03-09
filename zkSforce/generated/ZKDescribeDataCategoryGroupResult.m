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

#import "ZKDescribeDataCategoryGroupResult.h"
#import "ZKEnvelope.h"

@interface ZKDescribeDataCategoryGroupResult()
@property (assign,nonatomic) NSInteger  categoryCount__v;
@property (strong,nonatomic) NSString  *a_description__v;
@property (strong,nonatomic) NSString  *label__v;
@property (strong,nonatomic) NSString  *name__v;
@property (strong,nonatomic) NSString  *sobject__v;
@end

@implementation ZKDescribeDataCategoryGroupResult


+(void)load {
    [self registerType:self xmlName:@"DescribeDataCategoryGroupResult"];
}

-(NSInteger)categoryCount {
    if ((fields__set[0] & 0x1) == 0) {
        self.categoryCount__v = [self integer:@"categoryCount"];
        fields__set[0] |= 0x1; 
    }
    return self.categoryCount__v;
}
        

-(void)setCategoryCount:(NSInteger)v {
    self.categoryCount__v = v;
    fields__set[0] |= 0x1; 
}
        

-(NSString *)a_description {
    if ((fields__set[0] & 0x2) == 0) {
        self.a_description__v = [self string:@"description"];
        fields__set[0] |= 0x2; 
    }
    return self.a_description__v;
}
        

-(void)setA_description:(NSString *)v {
    self.a_description__v = v;
    fields__set[0] |= 0x2; 
}
        

-(NSString *)label {
    if ((fields__set[0] & 0x4) == 0) {
        self.label__v = [self string:@"label"];
        fields__set[0] |= 0x4; 
    }
    return self.label__v;
}
        

-(void)setLabel:(NSString *)v {
    self.label__v = v;
    fields__set[0] |= 0x4; 
}
        

-(NSString *)name {
    if ((fields__set[0] & 0x8) == 0) {
        self.name__v = [self string:@"name"];
        fields__set[0] |= 0x8; 
    }
    return self.name__v;
}
        

-(void)setName:(NSString *)v {
    self.name__v = v;
    fields__set[0] |= 0x8; 
}
        

-(NSString *)sobject {
    if ((fields__set[0] & 0x10) == 0) {
        self.sobject__v = [self string:@"sobject"];
        fields__set[0] |= 0x10; 
    }
    return self.sobject__v;
}
        

-(void)setSobject:(NSString *)v {
    self.sobject__v = v;
    fields__set[0] |= 0x10; 
}
        
-(void)serializeTo:(ZKXmlWriter *)env elemName:(NSString *)elemName {
	[env startElement:elemName];
	[env addIntElement:@"categoryCount" elemValue:self.categoryCount];
	[env addElement:@"description"      elemValue:self.a_description   nillable:NO  optional:NO];
	[env addElement:@"label"            elemValue:self.label         nillable:NO  optional:NO];
	[env addElement:@"name"             elemValue:self.name          nillable:NO  optional:NO];
	[env addElement:@"sobject"          elemValue:self.sobject       nillable:NO  optional:NO];
	[env endElement:elemName];
}
@end
