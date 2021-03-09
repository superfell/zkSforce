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

#import "ZKKnowledgeLanguageItem.h"
#import "ZKEnvelope.h"

@interface ZKKnowledgeLanguageItem()
@property (assign,nonatomic) BOOL       active__v;
@property (strong,nonatomic) NSString  *assigneeId__v;
@property (strong,nonatomic) NSString  *name__v;
@end

@implementation ZKKnowledgeLanguageItem


+(void)load {
    [self registerType:self xmlName:@"KnowledgeLanguageItem"];
}

-(BOOL)active {
    if ((fields__set[0] & 0x1) == 0) {
        self.active__v = [self boolean:@"active"];
        fields__set[0] |= 0x1; 
    }
    return self.active__v;
}
        

-(void)setActive:(BOOL)v {
    self.active__v = v;
    fields__set[0] |= 0x1; 
}
        

-(NSString *)assigneeId {
    if ((fields__set[0] & 0x2) == 0) {
        self.assigneeId__v = [self string:@"assigneeId"];
        fields__set[0] |= 0x2; 
    }
    return self.assigneeId__v;
}
        

-(void)setAssigneeId:(NSString *)v {
    self.assigneeId__v = v;
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
	[env addBoolElement:@"active" elemValue:self.active];
	[env addElement:@"assigneeId" elemValue:self.assigneeId nillable:YES optional:NO];
	[env addElement:@"name"       elemValue:self.name       nillable:NO  optional:NO];
	[env endElement:elemName];
}
@end
