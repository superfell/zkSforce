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

#import "ZKFieldDiff.h"
#import "ZKEnvelope.h"

@interface ZKFieldDiff()
@property (strong,nonatomic) NSString  *difference__v;
@property (strong,nonatomic) NSString  *name__v;
@end

@implementation ZKFieldDiff


+(void)load {
    [self registerType:self xmlName:@"FieldDiff"];
}

-(NSString *)difference {
    if ((fields__set[0] & 0x1) == 0) {
        self.difference__v = [self string:@"difference"];
        fields__set[0] |= 0x1; 
    }
    return self.difference__v;
}
        

-(void)setDifference:(NSString *)v {
    self.difference__v = v;
    fields__set[0] |= 0x1; 
}
        

-(NSString *)name {
    if ((fields__set[0] & 0x2) == 0) {
        self.name__v = [self string:@"name"];
        fields__set[0] |= 0x2; 
    }
    return self.name__v;
}
        

-(void)setName:(NSString *)v {
    self.name__v = v;
    fields__set[0] |= 0x2; 
}
        
-(void)serializeTo:(ZKXmlWriter *)env elemName:(NSString *)elemName {
	[env startElement:elemName];
	[env addElement:@"difference" elemValue:self.difference nillable:NO  optional:NO];
	[env addElement:@"name"       elemValue:self.name       nillable:NO  optional:NO];
	[env endElement:elemName];
}
@end
