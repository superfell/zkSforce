// Copyright (c) 2019 Simon Fell
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

#import "ZKEntityErrorMetadata.h"
#import "ZKEnvelope.h"

@interface ZKEntityErrorMetadata()
@property (strong,nonatomic) NSString  *errorCode__v;
@property (strong,nonatomic) NSString  *message__v;
@end

@implementation ZKEntityErrorMetadata


+(void)load {
    [self registerType:self xmlName:@"EntityErrorMetadata"];
}

-(NSString *)errorCode {
    if ((fields__set[0] & 0x1) == 0) {
        self.errorCode__v = [self string:@"errorCode"];
        fields__set[0] |= 0x1; 
    }
    return self.errorCode__v;
}
        

-(void)setErrorCode:(NSString *)v {
    self.errorCode__v = v;
    fields__set[0] |= 0x1; 
}
        

-(NSString *)message {
    if ((fields__set[0] & 0x2) == 0) {
        self.message__v = [self string:@"message"];
        fields__set[0] |= 0x2; 
    }
    return self.message__v;
}
        

-(void)setMessage:(NSString *)v {
    self.message__v = v;
    fields__set[0] |= 0x2; 
}
        
-(void)serializeTo:(ZKXmlWriter *)env elemName:(NSString *)elemName {
	[env startElement:elemName];
	[env addElement:@"errorCode" elemValue:self.errorCode nillable:YES optional:NO];
	[env addElement:@"message"   elemValue:self.message   nillable:YES optional:NO];
	[env endElement:elemName];
}
@end
