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

#import "ZKDescribeAvailableQuickActionResult.h"
#import "ZKEnvelope.h"

@interface ZKDescribeAvailableQuickActionResult()
@property (strong,nonatomic) NSString  *actionEnumOrId__v;
@property (strong,nonatomic) NSString  *label__v;
@property (strong,nonatomic) NSString  *name__v;
@property (strong,nonatomic) NSString  *type__v;
@end

@implementation ZKDescribeAvailableQuickActionResult


+(void)load {
    [self registerType:self xmlName:@"DescribeAvailableQuickActionResult"];
}

-(NSString *)actionEnumOrId {
    if ((fields__set[0] & 0x1) == 0) {
        self.actionEnumOrId__v = [self string:@"actionEnumOrId"];
        fields__set[0] |= 0x1; 
    }
    return self.actionEnumOrId__v;
}
        

-(void)setActionEnumOrId:(NSString *)v {
    self.actionEnumOrId__v = v;
    fields__set[0] |= 0x1; 
}
        

-(NSString *)label {
    if ((fields__set[0] & 0x2) == 0) {
        self.label__v = [self string:@"label"];
        fields__set[0] |= 0x2; 
    }
    return self.label__v;
}
        

-(void)setLabel:(NSString *)v {
    self.label__v = v;
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
        

-(NSString *)type {
    if ((fields__set[0] & 0x8) == 0) {
        self.type__v = [self string:@"type"];
        fields__set[0] |= 0x8; 
    }
    return self.type__v;
}
        

-(void)setType:(NSString *)v {
    self.type__v = v;
    fields__set[0] |= 0x8; 
}
        
-(void)serializeTo:(ZKXmlWriter *)env elemName:(NSString *)elemName {
	[env startElement:elemName];
	[env addElement:@"actionEnumOrId" elemValue:self.actionEnumOrId nillable:NO  optional:NO];
	[env addElement:@"label"          elemValue:self.label          nillable:NO  optional:NO];
	[env addElement:@"name"           elemValue:self.name           nillable:NO  optional:NO];
	[env addElement:@"type"           elemValue:self.type           nillable:NO  optional:NO];
	[env endElement:elemName];
}
@end
