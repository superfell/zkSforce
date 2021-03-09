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

#import "ZKActionOverride.h"
#import "ZKEnvelope.h"

@interface ZKActionOverride()
@property (strong,nonatomic) NSString  *formFactor__v;
@property (assign,nonatomic) BOOL       isAvailableInTouch__v;
@property (strong,nonatomic) NSString  *name__v;
@property (strong,nonatomic) NSString  *pageId__v;
@property (strong,nonatomic) NSString  *url__v;
@end

@implementation ZKActionOverride


+(void)load {
    [self registerType:self xmlName:@"ActionOverride"];
}

-(NSString *)formFactor {
    if ((fields__set[0] & 0x1) == 0) {
        self.formFactor__v = [self string:@"formFactor"];
        fields__set[0] |= 0x1; 
    }
    return self.formFactor__v;
}
        

-(void)setFormFactor:(NSString *)v {
    self.formFactor__v = v;
    fields__set[0] |= 0x1; 
}
        

-(BOOL)isAvailableInTouch {
    if ((fields__set[0] & 0x2) == 0) {
        self.isAvailableInTouch__v = [self boolean:@"isAvailableInTouch"];
        fields__set[0] |= 0x2; 
    }
    return self.isAvailableInTouch__v;
}
        

-(void)setIsAvailableInTouch:(BOOL)v {
    self.isAvailableInTouch__v = v;
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
        

-(NSString *)pageId {
    if ((fields__set[0] & 0x8) == 0) {
        self.pageId__v = [self string:@"pageId"];
        fields__set[0] |= 0x8; 
    }
    return self.pageId__v;
}
        

-(void)setPageId:(NSString *)v {
    self.pageId__v = v;
    fields__set[0] |= 0x8; 
}
        

-(NSString *)url {
    if ((fields__set[0] & 0x10) == 0) {
        self.url__v = [self string:@"url"];
        fields__set[0] |= 0x10; 
    }
    return self.url__v;
}
        

-(void)setUrl:(NSString *)v {
    self.url__v = v;
    fields__set[0] |= 0x10; 
}
        
-(void)serializeTo:(ZKXmlWriter *)env elemName:(NSString *)elemName {
	[env startElement:elemName];
	[env addElement:@"formFactor"             elemValue:self.formFactor         nillable:YES optional:NO];
	[env addBoolElement:@"isAvailableInTouch" elemValue:self.isAvailableInTouch];
	[env addElement:@"name"                   elemValue:self.name               nillable:NO  optional:NO];
	[env addElement:@"pageId"                 elemValue:self.pageId             nillable:NO  optional:NO];
	[env addElement:@"url"                    elemValue:self.url                nillable:YES optional:NO];
	[env endElement:elemName];
}
@end
