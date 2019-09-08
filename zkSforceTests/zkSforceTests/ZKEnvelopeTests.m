// Copyright (c) 2013-2015 Simon Fell
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
#import "ZKSObject.h"
#import "ZKProcessSubmitRequest.h"
#import "ZKAddress.h"

@implementation ZKTestSerialize

-(void)serializeToEnvelope:(ZKEnvelope *)env elemName:(NSString *)elemName {
    [env addElementString:elemName elemValue:@"Hello World"];
}

@end

@implementation ZKEnvelopeTests

NSString *ENV_TAG = @"<s:Envelope xmlns:s='http://schemas.xmlsoap.org/soap/envelope/' xmlns:x='http://www.w3.org/2001/XMLSchema-instance' xmlns='urn:test'>";

-(void)makeEnv {
    env = [[ZKEnvelope alloc] init];
    [env start:@"urn:test"];
}

-(void)setUp {
    [super setUp];
    [self makeEnv];
}

-(NSString *)envWith:(NSString *)content {
    return [NSString stringWithFormat:@"%@%@%@", ENV_TAG, content, @"</s:Envelope>"];
}

-(void)testSimpleEnvelope {
    XCTAssertEqualObjects([self envWith:@""], [env end], @"plain env is wrong");
}

-(void)testStartEndElement {
    [env startElement:@"bob"];
    [env endElement:@"bob"];
    XCTAssertEqualObjects([self envWith:@"<bob></bob>"], [env end]);
}

-(void)testWriteText {
    [env startElement:@"bob"];
    [env writeText:@"<>&\"'hello"];
    [env endElement:@"bob"];
    XCTAssertEqualObjects([self envWith:@"<bob>&lt;&gt;&amp;\"'hello</bob>"], [env end]);
}

-(void)testAddNullElement {
    [env addNullElement:@"bob"];
    XCTAssertEqualObjects([self envWith:@"<bob x:nil='true'/>"], [env end]);
}

-(void)testAddElementNil {
    [env addElement:@"a" elemValue:nil nillable:YES optional:NO];
    [env addElement:@"b" elemValue:nil nillable:YES optional:YES];
    [env addElement:@"c" elemValue:nil nillable:NO optional:YES];
    [env addElement:@"d" elemValue:nil nillable:NO optional:NO];
    XCTAssertEqualObjects([self envWith:@"<a x:nil='true'/><d></d>"], [env end]);
}

-(void)testAddBoolElement {
    [env addBoolElement:@"one" elemValue:TRUE];
    [env addBoolElement:@"two" elemValue:FALSE];
    XCTAssertEqualObjects([self envWith:@"<one>true</one><two>false</two>"], [env end]);
}

-(void)testAddIntElement {
    [env addIntElement:@"one" elemValue:12345];
    XCTAssertEqualObjects([self envWith:@"<one>12345</one>"], [env end]);
}

-(void)testWriteSessionHeader {
    [env writeSessionHeader:@"a sid"];
    XCTAssertEqualObjects([self envWith:@"<s:Header><SessionHeader><sessionId>a sid</sessionId></SessionHeader></s:Header>"], [env end]);
}

-(void)testWriteCallOptionsHeader {
    [env writeCallOptionsHeader:@"test"];
    XCTAssertEqualObjects([self envWith:@"<s:Header><CallOptions><client>test</client></CallOptions></s:Header>"], [env end]);
}

-(void)testWriteTrueMruHeader {
    [env writeMruHeader:TRUE];
    XCTAssertEqualObjects([self envWith:@"<s:Header><MruHeader><updateMru>true</updateMru></MruHeader></s:Header>"], [env end]);
}

-(void)testWriteFalseMruHeader {
    [env writeMruHeader:FALSE];
    XCTAssertEqualObjects([self envWith:@""], [env end]);
}

-(void)testMoveToBody {
    [env moveToBody];
    XCTAssertEqualObjects([self envWith:@"<s:Body></s:Body>"], [env end]);
}

-(void)testMoveToHeaders {
    [env moveToHeaders];
    XCTAssertEqualObjects([self envWith:@"<s:Header></s:Header>"], [env end]);
}

-(void)testMoveToHeadersAndBody {
    [env moveToHeaders];
    [env moveToBody];
    XCTAssertEqualObjects([self envWith:@"<s:Header></s:Header><s:Body></s:Body>"], [env end]);
}

-(void)testCantMoveFromBodyToHeaders {
    [env moveToBody];
    XCTAssertThrows([env moveToHeaders]);
}

-(void)testAddElementString {
    [env addElementString:@"bob" elemValue:@"hello>"];
    XCTAssertEqualObjects([self envWith:@"<bob>hello&gt;</bob>"], [env end]);
    [self makeEnv];
    [env addElement:@"alice" elemValue:@"!"];
    XCTAssertEqualObjects([self envWith:@"<alice>!</alice>"],[env end]);
}

-(void)testAddElementArray {
    NSArray *vals = @[@"one", @"two"];
    [env addElementArray:@"bob" elemValue:vals];
    XCTAssertEqualObjects([self envWith:@"<bob>one</bob><bob>two</bob>"], [env end]);
    [self makeEnv];
    [env addElement:@"alice" elemValue:vals];
    XCTAssertEqualObjects([self envWith:@"<alice>one</alice><alice>two</alice>"], [env end]);
}

-(void)testNullArray {
    [env addElementArray:@"bob" elemValue:nil];
    XCTAssertEqualObjects([self envWith:@""], [env end]);
}

-(void)testAddDoubleElement {
    [env addDoubleElement:@"d" elemValue:42.5f];
    XCTAssertEqualObjects([self envWith:@"<d>42.5</d>"], [env end]);
}

-(void)testAddElementSObject {
    ZKSObject *o = [[ZKSObject alloc] initWithType:@"Account"];
    [o setFieldValue:@"Lost" field:@"status"];
    [o setFieldToNull:@"IsWon"];
    [o setFieldToNull:@"Bob__c"];
    [o setFieldValue:@"Sid" field:@"LastMod"];
    [env addElementSObject:@"acc" elemValue:o];
    NSString *accEnv = [self envWith:@"<acc><type>Account</type><fieldsToNull>IsWon</fieldsToNull><fieldsToNull>Bob__c</fieldsToNull><status>Lost</status><LastMod>Sid</LastMod></acc>"];
    XCTAssertEqualObjects(accEnv, [env end]);
    [self makeEnv];
    [env addElement:@"acc" elemValue:o];
    XCTAssertEqualObjects(accEnv, [env end]);
}

-(void)testSObjectAddress {
    ZKSObject *o = [[ZKSObject alloc] initWithType:@"Account"];
    ZKAddress * a = [[ZKAddress alloc] init];
    a.longitude = 10;
    a.latitude = 11;
    a.city = @"SF";
    a.state = @"CA";
    a.street = @"Market";
    a.country = @"USA";
    a.postalCode = @"94925";
    a.geocodeAccuracy = @"1";
    [o setFieldValue:a field:@"MailingAddress"];
    [env addElementSObject:@"acc" elemValue:o];
    NSString *expected = [self envWith:@"<acc><type>Account</type><MailingAddress x:type=\"address\"><latitude>11</latitude><longitude>10</longitude><city>SF</city><country>USA</country><countryCode x:nil='true'/><geocodeAccuracy>1</geocodeAccuracy><postalCode>94925</postalCode><state>CA</state><stateCode x:nil='true'/><street>Market</street></MailingAddress></acc>"];
    XCTAssertEqualObjects(expected, [env end]);
}

-(void)testSerializable {
    ZKTestSerialize *s = [[ZKTestSerialize alloc] init];
    [env addElement:@"bob" elemValue:s];
    XCTAssertEqualObjects([self envWith:@"<bob>Hello World</bob>"], [env end]);
}

-(void)testExtentsionTypeSerializable {
    ZKProcessSubmitRequest *r = [[ZKProcessSubmitRequest alloc] init];
    r.objectId = @"obj";
    r.comments = @"comment";
    [env addElement:@"p" elemValue:r];
    XCTAssertEqualObjects([self envWith:@"<p x:type=\"ProcessSubmitRequest\"><comments>comment</comments><objectId>obj</objectId><submitterId x:nil='true'/><processDefinitionNameOrId x:nil='true'/><skipEntryCriteria>false</skipEntryCriteria></p>"], [env end]);
}

-(void)testToString {
    [env addElement:@"bob" elemValue:@42];
    XCTAssertEqualObjects([self envWith:@"<bob>42</bob>"], [env end]);
}

@end
