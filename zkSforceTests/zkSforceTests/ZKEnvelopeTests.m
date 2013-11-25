// Copyright (c) 2013 Simon Fell
//
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the "Software"),
// to deal in the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following conditions:
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

#import "ZKEnvelopeTests.h"
#import "ZKEnvelope.h"

@implementation ZKEnvelopeTests

NSString *ENV_TAG = @"<s:Envelope xmlns:s='http://schemas.xmlsoap.org/soap/envelope/' xmlns:x='http://www.w3.org/2001/XMLSchema-instance' xmlns='urn:test'>";

-(void)setUp {
    [super setUp];
    // Set-up code here.
}

-(void)tearDown {
    // Tear-down code here.
    [super tearDown];
}

-(NSString *)envWith:(NSString *)content {
    return [NSString stringWithFormat:@"%@%@%@", ENV_TAG, content, @"</s:Envelope>"];
}

-(void)testSimpleEnvelope {
    ZKEnvelope *e = [[[ZKEnvelope alloc] init] autorelease];
    [e start:@"urn:test"];
    NSString *result = [e end];
    STAssertEqualObjects([self envWith:@""], result, @"plain env is wrong");
}

-(void)testStartEndElement {
    ZKEnvelope *e = [[[ZKEnvelope alloc] init] autorelease];
    [e start:@"urn:test"];
    [e startElement:@"bob"];
    [e endElement:@"bob"];
    NSString *result = [e end];
    STAssertEqualObjects([self envWith:@"<bob></bob>"], result, nil);
}

@end
