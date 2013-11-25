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
    env = [[ZKEnvelope alloc] init];
    [env start:@"urn:test"];
}

-(void)tearDown {
    [env release];
    [super tearDown];
}

-(NSString *)envWith:(NSString *)content {
    return [NSString stringWithFormat:@"%@%@%@", ENV_TAG, content, @"</s:Envelope>"];
}

-(void)testSimpleEnvelope {
    STAssertEqualObjects([self envWith:@""], [env end], @"plain env is wrong");
}

-(void)testStartEndElement {
    [env startElement:@"bob"];
    [env endElement:@"bob"];
    STAssertEqualObjects([self envWith:@"<bob></bob>"], [env end], nil);
}

-(void)testWriteText {
    [env startElement:@"bob"];
    [env writeText:@"<>&\"'hello"];
    [env endElement:@"bob"];
    STAssertEqualObjects([self envWith:@"<bob>&lt;&gt;&amp;\"'hello</bob>"], [env end], nil);
}

-(void)testAddNullElement {
    [env addNullElement:@"bob"];
    STAssertEqualObjects([self envWith:@"<bob x:nil='true'/>"], [env end], nil);
}

-(void)testAddBoolElement {
    [env addBoolElement:@"one" elemValue:TRUE];
    [env addBoolElement:@"two" elemValue:FALSE];
    STAssertEqualObjects([self envWith:@"<one>true</one><two>false</two>"], [env end], nil);
}

-(void)testWriteSessionHeader {
    [env writeSessionHeader:@"a sid"];
    STAssertEqualObjects([self envWith:@"<s:Header><SessionHeader><sessionId>a sid</sessionId></SessionHeader></s:Header>"], [env end], nil);
}
@end
