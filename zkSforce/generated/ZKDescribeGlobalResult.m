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

#import "ZKDescribeGlobalResult.h"
#import "ZKEnvelope.h"
#import "ZKDescribeGlobalSObject.h"

@interface ZKDescribeGlobalResult()
@property (strong,nonatomic) NSString  *encoding__v;
@property (assign,nonatomic) NSInteger  maxBatchSize__v;
@property (strong,nonatomic) NSArray   *sobjects__v;
@end

@implementation ZKDescribeGlobalResult


+(void)load {
    [self registerType:self xmlName:@"DescribeGlobalResult"];
}

-(NSString *)encoding {
    if ((fields__set[0] & 0x1) == 0) {
        self.encoding__v = [self string:@"encoding"];
        fields__set[0] |= 0x1; 
    }
    return self.encoding__v;
}
        

-(void)setEncoding:(NSString *)v {
    self.encoding__v = v;
    fields__set[0] |= 0x1; 
}
        

-(NSInteger)maxBatchSize {
    if ((fields__set[0] & 0x2) == 0) {
        self.maxBatchSize__v = [self integer:@"maxBatchSize"];
        fields__set[0] |= 0x2; 
    }
    return self.maxBatchSize__v;
}
        

-(void)setMaxBatchSize:(NSInteger)v {
    self.maxBatchSize__v = v;
    fields__set[0] |= 0x2; 
}
        

-(NSArray *)sobjects {
    if ((fields__set[0] & 0x4) == 0) {
        self.sobjects__v = [self complexTypeArrayFromElements:@"sobjects" cls:[ZKDescribeGlobalSObject class]];
        fields__set[0] |= 0x4; 
    }
    return self.sobjects__v;
}
        

-(void)setSobjects:(NSArray *)v {
    self.sobjects__v = v;
    fields__set[0] |= 0x4; 
}
        
-(void)serializeTo:(ZKXmlWriter *)env elemName:(NSString *)elemName {
	[env startElement:elemName];
	[env addElement:@"encoding"        elemValue:self.encoding     nillable:YES optional:NO];
	[env addIntElement:@"maxBatchSize" elemValue:self.maxBatchSize];
	[env addElementArray:@"sobjects"   elemValue:self.sobjects];
	[env endElement:elemName];
}
@end
