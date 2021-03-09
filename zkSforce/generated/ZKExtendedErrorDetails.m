// Copyright (c) 2016 Simon Fell
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

#import "ZKExtendedErrorDetails.h"
#import "ZKEnvelope.h"

@interface ZKExtendedErrorDetails()
@property (strong,nonatomic) NSString  *extendedErrorCode__v;
@end

@implementation ZKExtendedErrorDetails


+(void)load {
    [self registerType:self xmlName:@"ExtendedErrorDetails"];
}

-(NSString *)extendedErrorCode {
    if ((fields__set[0] & 0x1) == 0) {
        self.extendedErrorCode__v = [self string:@"extendedErrorCode"];
        fields__set[0] |= 0x1; 
    }
    return self.extendedErrorCode__v;
}
        

-(void)setExtendedErrorCode:(NSString *)v {
    self.extendedErrorCode__v = v;
    fields__set[0] |= 0x1; 
}
        
-(void)serializeTo:(ZKXmlWriter *)env elemName:(NSString *)elemName {
	[env startElement:elemName];
	[env addElement:@"extendedErrorCode" elemValue:self.extendedErrorCode nillable:NO  optional:NO];
	[env endElement:elemName];
}
@end
