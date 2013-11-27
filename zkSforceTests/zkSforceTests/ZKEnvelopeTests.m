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
#import "zkSObject.h"

@implementation ZKTestSerialize

-(void)serializeToEnvelope:(ZKEnvelope *)env elemName:(NSString *)elemName {
    [env addElementString:elemName elemValue:@"Hello World"];
}

@end

@implementation ZKEnvelopeTests

NSString *ENV_TAG = @"<s:Envelope xmlns:s='http://schemas.xmlsoap.org/soap/envelope/' xmlns:x='http://www.w3.org/2001/XMLSchema-instance' xmlns='urn:test'>";

-(void)makeEnv {
    [env release];
    env = [[ZKEnvelope alloc] init];
    [env start:@"urn:test"];
}

-(void)setUp {
    [super setUp];
    [self makeEnv];
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

-(void)testAddElementNil {
    [env addElement:@"a" elemValue:nil nillable:YES optional:NO];
    [env addElement:@"b" elemValue:nil nillable:YES optional:YES];
    [env addElement:@"c" elemValue:nil nillable:NO optional:YES];
    [env addElement:@"d" elemValue:nil nillable:NO optional:NO];
    STAssertEqualObjects([self envWith:@"<a x:nil='true'/><d></d>"], [env end], nil);
}

-(void)testAddBoolElement {
    [env addBoolElement:@"one" elemValue:TRUE];
    [env addBoolElement:@"two" elemValue:FALSE];
    STAssertEqualObjects([self envWith:@"<one>true</one><two>false</two>"], [env end], nil);
}

-(void)testAddIntElement {
    [env addIntElement:@"one" elemValue:12345];
    STAssertEqualObjects([self envWith:@"<one>12345</one>"], [env end], nil);
}

-(void)testWriteSessionHeader {
    [env writeSessionHeader:@"a sid"];
    STAssertEqualObjects([self envWith:@"<s:Header><SessionHeader><sessionId>a sid</sessionId></SessionHeader></s:Header>"], [env end], nil);
}

-(void)testWriteCallOptionsHeader {
    [env writeCallOptionsHeader:@"test"];
    STAssertEqualObjects([self envWith:@"<s:Header><CallOptions><client>test</client></CallOptions></s:Header>"], [env end], nil);
}

-(void)testWriteTrueMruHeader {
    [env writeMruHeader:TRUE];
    STAssertEqualObjects([self envWith:@"<s:Header><MruHeader><updateMru>true</updateMru></MruHeader></s:Header>"], [env end], nil);
}

-(void)testWriteFalseMruHeader {
    [env writeMruHeader:FALSE];
    STAssertEqualObjects([self envWith:@""], [env end], nil);
}

-(void)testMoveToBody {
    [env moveToBody];
    STAssertEqualObjects([self envWith:@"<s:Body></s:Body>"], [env end], nil);
}

-(void)testMoveToHeaders {
    [env moveToHeaders];
    STAssertEqualObjects([self envWith:@"<s:Header></s:Header>"], [env end], nil);
}

-(void)testMoveToHeadersAndBody {
    [env moveToHeaders];
    [env moveToBody];
    STAssertEqualObjects([self envWith:@"<s:Header></s:Header><s:Body></s:Body>"], [env end], nil);
}

-(void)testCantMoveFromBodyToHeaders {
    [env moveToBody];
    STAssertThrows([env moveToHeaders], nil);
}

-(void)testAddElementString {
    [env addElementString:@"bob" elemValue:@"hello>"];
    STAssertEqualObjects([self envWith:@"<bob>hello&gt;</bob>"], [env end], nil);
    [self makeEnv];
    [env addElement:@"alice" elemValue:@"!"];
    STAssertEqualObjects([self envWith:@"<alice>!</alice>"],[env end], nil);
}

-(void)testAddElementArray {
    NSArray *vals = [NSArray arrayWithObjects:@"one", @"two", nil];
    [env addElementArray:@"bob" elemValue:vals];
    STAssertEqualObjects([self envWith:@"<bob>one</bob><bob>two</bob>"], [env end], nil);
    [self makeEnv];
    [env addElement:@"alice" elemValue:vals];
    STAssertEqualObjects([self envWith:@"<alice>one</alice><alice>two</alice>"], [env end], nil);
}

-(void)testNullArray {
    [env addElementArray:@"bob" elemValue:nil];
    STAssertEqualObjects([self envWith:@""], [env end], nil);
}

-(void)testAddElementSObject {
    ZKSObject *o = [[[ZKSObject alloc] initWithType:@"Account"] autorelease];
    [o setFieldValue:@"Lost" field:@"status"];
    [o setFieldToNull:@"IsWon"];
    [o setFieldToNull:@"Bob__c"];
    [o setFieldValue:@"Sid" field:@"LastMod"];
    [env addElementSObject:@"acc" elemValue:o];
    NSString *accEnv = [self envWith:@"<acc><type>Account</type><fieldsToNull>IsWon</fieldsToNull><fieldsToNull>Bob__c</fieldsToNull><status>Lost</status><LastMod>Sid</LastMod></acc>"];
    STAssertEqualObjects(accEnv, [env end], nil);
    [self makeEnv];
    [env addElement:@"acc" elemValue:o];
    STAssertEqualObjects(accEnv, [env end], nil);
}

-(void)testSerializable {
    ZKTestSerialize *s = [[[ZKTestSerialize alloc] init] autorelease];
    [env addElement:@"bob" elemValue:s];
    STAssertEqualObjects([self envWith:@"<bob>Hello World</bob>"], [env end], nil);
}

-(void)testToString {
    [env addElement:@"bob" elemValue:[NSNumber numberWithInt:42]];
    STAssertEqualObjects([self envWith:@"<bob>42</bob>"], [env end], nil);
}

@end
