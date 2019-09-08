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

#import "ZKAdditionalInformationMap.h"
#import "ZKEnvelope.h"

@implementation ZKAdditionalInformationMap

@synthesize name, value;

-(instancetype)init {
    self = [super init];
    return self;
}

-(instancetype)initWithZKXmlDeserializer:(ZKXmlDeserializer *)d {
    self = [super init];
	self.name = [d string:@"name"];
	self.value = [d string:@"value"];
    return self;
}

-(instancetype)initWithXmlElement:(zkElement *)e {
    ZKXmlDeserializer *d = [[ZKXmlDeserializer alloc] initWithXmlElement:e];
    return [self initWithZKXmlDeserializer:d];
}

-(void)serializeToEnvelope:(ZKEnvelope *)env elemName:(NSString *)elemName {
	[env startElement:elemName];
	[env addElement:@"name"  elemValue:self.name  nillable:NO  optional:NO];
	[env addElement:@"value" elemValue:self.value nillable:NO  optional:NO];
	[env endElement:elemName];
}
@end
