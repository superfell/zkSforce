// Copyright (c) 2015 Simon Fell
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

#import "ZKOwnerChangeOption.h"
#import "ZKEnvelope.h"

@interface ZKOwnerChangeOption()
@property (strong,nonatomic) NSString  *type__v;
@property (assign,nonatomic) BOOL       execute__v;
@end

@implementation ZKOwnerChangeOption


+(void)load {
    [self registerType:self xmlName:@"OwnerChangeOption"];
}

-(NSString *)type {
    if ((fields__set[0] & 0x1) == 0) {
        self.type__v = [self string:@"type"];
        fields__set[0] |= 0x1; 
    }
    return self.type__v;
}
        

-(void)setType:(NSString *)v {
    self.type__v = v;
    fields__set[0] |= 0x1; 
}
        

-(BOOL)execute {
    if ((fields__set[0] & 0x2) == 0) {
        self.execute__v = [self boolean:@"execute"];
        fields__set[0] |= 0x2; 
    }
    return self.execute__v;
}
        

-(void)setExecute:(BOOL)v {
    self.execute__v = v;
    fields__set[0] |= 0x2; 
}
        
-(void)serializeTo:(ZKXmlWriter *)env elemName:(NSString *)elemName {
	[env startElement:elemName];
	[env addElement:@"type"        elemValue:self.type    nillable:NO  optional:NO];
	[env addBoolElement:@"execute" elemValue:self.execute];
	[env endElement:elemName];
}
@end
