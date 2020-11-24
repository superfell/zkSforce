// Copyright (c) 2014 Simon Fell
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

#import "ZKSObjectTests.h"
#import "ZKSObject.h"
#import "ZKParser.h"
#import "ZKAddress.h"
#import "ZKDescribeSObject+Extras.h"
#import "ZKQueryResult.h"

@implementation ZKSObjectTests

-(ZKSObject *)parseSobject:(NSString *)sobjectContents {
    NSString *xml = [NSString stringWithFormat:@"<sObject xmlns:x='http://www.w3.org/2001/XMLSchema-instance'>%@</sObject>", sobjectContents];
    ZKElement *e = [ZKParser parseData:[xml dataUsingEncoding:NSUTF8StringEncoding]];
    return [ZKSObject fromXmlNode:e];
}

-(void)testConstructors {
    ZKSObject *o = [ZKSObject withType:@"Acc"];
    XCTAssertEqualObjects(@"Acc", o.type);
    XCTAssertNil(o.id);
    XCTAssertEqual(0, o.fields.count);
    
    o = [ZKSObject withTypeAndId:@"Bar" sfId:@"345"];
    XCTAssertEqualObjects(@"Bar", o.type);
    XCTAssertEqualObjects(@"345", o.id);
    XCTAssertEqual(0, o.fields.count);
}

-(void)testLocation {
    NSString *xml = @"<type>Account</type><Id>001_test</Id><foo x:type='ens:location'><latitude>10</latitude><longitude>33</longitude></foo>";
    ZKSObject *so = [self parseSobject:xml];
    XCTAssertEqualObjects([so type], @"Account", @"type should match");
    XCTAssertEqualObjects([so id], @"001_test", @"Id wrong");
    ZKLocation*l = [so locationValue:@"foo"];
    XCTAssertNotNil(l, @"should have a location object");
    XCTAssertEqualObjects([ZKLocation class], [l class], @"location unexpected type");
    XCTAssertEqual(10.0, [l latitude], @"lattitude wrong");
    XCTAssertEqual(33.0, [l longitude], @"longitude wrong");
}

-(void)testAddress {
    NSString *xml = @"<type>Account</type><Id>001_test</Id><foo x:type='ens:address'><latitude>10</latitude><longitude>33</longitude><city>SF</city><country>USA</country><countryCode>US</countryCode><postalCode>94105</postalCode><state>Cali</state><stateCode>CA</stateCode><street>Market St</street></foo>";
    ZKSObject *so = [self parseSobject:xml];
    XCTAssertEqualObjects([so type], @"Account", @"type should match");
    XCTAssertEqualObjects([so id], @"001_test", @"Id wrong");
    ZKAddress*a = [so addressValue:@"foo"];
    XCTAssertNotNil(a, @"should have an address object");
    XCTAssertEqualObjects([ZKAddress class], [a class], @"address unexpected type");
    XCTAssertEqual(10.0, [a latitude], @"lattitude wrong");
    XCTAssertEqual(33.0, [a longitude], @"longitude wrong");
    XCTAssertEqualObjects([a city], @"SF", @"city wrong");
    XCTAssertEqualObjects([a country], @"USA", @"country wrong");
    XCTAssertEqualObjects([a countryCode], @"US", @"countryCode wrong");
    XCTAssertEqualObjects([a postalCode], @"94105", @"postalCode wrong");
    XCTAssertEqualObjects([a state], @"Cali", @"state wrong");
    XCTAssertEqualObjects([a stateCode], @"CA", @"stateCode wrong");
    XCTAssertEqualObjects([a street], @"Market St", @"street wrong");
}

-(void)testQueryResult {
    NSString *xml = @"<type>Account</type><Id>A</Id><contacts x:type='QueryResult'><records><type>Contact</type><Id>B</Id><name>Bob</name></records><size>1</size><done>true</done></contacts>";
    ZKSObject *o = [self parseSobject:xml];
    XCTAssertEqualObjects(@"Account", o.type);
    XCTAssertEqualObjects(@"A", o.id);
    ZKQueryResult *c = [o fieldValue:@"contacts"];
    ZKQueryResult *c2 = [o queryResultValue:@"contacts"];
    XCTAssertTrue(c == c2);
    XCTAssertEqual(1, c.size);
    XCTAssertTrue(c.done);
    NSArray *recs = c.records;
    XCTAssertEqual(1, recs.count);
    ZKSObject *bob = recs[0];
    XCTAssertEqualObjects(@"Contact", bob.type);
    XCTAssertEqualObjects(@"B", bob.id);
    XCTAssertEqualObjects(@"Bob", [bob fieldValue:@"name"]);
}

-(void)testParentSObject {
    NSString *xml = @"<type>Contact</type><Id>A</Id><Account x:type='sObject'><type>Account</type><Id>B</Id><name>Bob inc.</name></Account>";
    ZKSObject *o = [self parseSobject:xml];
    XCTAssertEqualObjects(@"Contact", o.type);
    XCTAssertEqualObjects(@"A", o.id);
    ZKSObject *a = [o fieldValue:@"Account"];
    XCTAssertEqualObjects(@"Account", a.type);
    XCTAssertEqualObjects(@"B", a.id);
    XCTAssertEqualObjects(@"Bob inc.", [a fieldValue:@"name"]);
}

-(void)testFieldOrder {
    ZKSObject *o = [[ZKSObject alloc] initWithType:@"Account"];
    [o setFieldValue:@"Bob" field:@"Bf"];
    [o setFieldValue:@"Alice" field:@"Af"];
    [o setFieldValue:@"Eve" field:@"Ef"];
    // see http://www.openradar.me/14504007 for why the array literal is in ()
    XCTAssertEqualObjects(o.orderedFieldNames, (@[@"Bf", @"Af", @"Ef"]));
    [o setFieldValue:@"Alice2" field:@"Af"];
    XCTAssertEqualObjects(o.orderedFieldNames, (@[@"Bf", @"Af", @"Ef"]));
    [o setFieldValue:@"Mallory" field:@"Mf"];
    XCTAssertEqualObjects(o.orderedFieldNames, (@[@"Bf", @"Af", @"Ef", @"Mf"]));
    [o setFieldToNull:@"Ef"];
    XCTAssertEqualObjects(o.orderedFieldNames, (@[@"Bf", @"Af", @"Mf"]));
}

-(void)testSetFieldsToNil {
    ZKSObject *o = [ZKSObject withType:@"Account"];
    [o setFieldValue:@"Alice" field:@"Name"];
    XCTAssertFalse([o isFieldToNull:@"Name"]);
    [o setFieldToNull:@"Name"];
    XCTAssertTrue([o isFieldToNull:@"Name"]);
    XCTAssertNil([o fieldValue:@"Name"]);

    [o setFieldValue:@"Alice" field:@"Name"];
    XCTAssertFalse([o isFieldToNull:@"Name"]);
    [o setFieldValue:@"" field:@"Name"];
    XCTAssertTrue([o isFieldToNull:@"Name"]);
    XCTAssertNil([o fieldValue:@"Name"]);

    [o setFieldValue:@"Alice" field:@"Name"];
    XCTAssertFalse([o isFieldToNull:@"Name"]);
    [o setFieldValue:nil field:@"Name"];
    XCTAssertTrue([o isFieldToNull:@"Name"]);
    XCTAssertNil([o fieldValue:@"Name"]);
}

-(void)testFields {
    ZKSObject *o = [[ZKSObject alloc] initWithType:@"Account"];
    [o setFieldValue:@"Alice" field:@"A"];
    [o setFieldValue:@"Eve" field:@"E"];
    XCTAssertEqualObjects(o.fields, (@{@"A": @"Alice", @"E": @"Eve"}));
}

-(void)testDateTime {
    ZKSObject *o = [ZKSObject withType:@"Contact"];
    NSDateComponents *dc = [[NSDateComponents alloc] init];
    dc.year = 2020;
    dc.month = 11;
    dc.day = 23;
    dc.hour = 15;
    dc.minute = 8;
    dc.second = 13;
    dc.calendar = cal;
    XCTAssertTrue([dc isValidDate]);
    [o setFieldDateTimeValue:[dc date] field:@"a"];
    XCTAssertEqualObjects(@"2020-11-23T15:08:13.0000Z", [o fieldValue:@"a"]);
    XCTAssertEqualObjects([dc date], [o dateTimeValue:@"a"]);
    
    [o setFieldDateValue:[dc date] field:@"b"];
    XCTAssertEqualObjects(@"2020-11-23", [o fieldValue:@"b"]);
    [self assertDate:[o dateValue:@"b"] equalsYear:2020 month:11 day:23];
    
    [o setFieldTimeValue:[dc date] field:@"c"];
    XCTAssertEqualObjects(@"15:08:13.0000Z", [o fieldValue:@"c"]);
    [self assertTime:[o timeValue:@"c"] equalsHour:15 minute:8 seconds:13];
}

-(void)testNilValueFromServer {
    NSString *xml = @"<type>Acc</type><Id>123</Id><foo x:nil='true'></foo><bar>Alice</bar>";
    ZKSObject *o = [self parseSobject:xml];
    XCTAssertEqualObjects(@"Acc", o.type);
    XCTAssertEqualObjects(@"123", o.id);
    XCTAssertTrue([o containsField:@"foo"]);
    XCTAssertNil([o fieldValue:@"foo"]);
    XCTAssertTrue([o containsField:@"bar"]);
    XCTAssertEqualObjects(@"Alice", [o fieldValue:@"bar"]);
    XCTAssertFalse([o containsField:@"baz"]);
    XCTAssertNil([o fieldValue:@"baz"]);
}

-(void)testCopy {
    ZKSObject *o = [[ZKSObject alloc] initWithType:@"Account"];
    o.id = @"001123";
    [o setFieldToNull:@"Name"];
    [o setFieldValue:@"A" field:@"A"];
    ZKSObject *c = [o copyWithZone:nil];
    XCTAssertEqualObjects(o.type, c.type);
    XCTAssertEqualObjects(o.id, c.id);
    XCTAssertEqualObjects(o.fields, c.fields);
    XCTAssertEqualObjects(o.orderedFieldNames, c.orderedFieldNames);
    XCTAssertEqualObjects(o.fieldsToNull, c.fieldsToNull);
}

-(void)testContainsField {
    NSString *xml = @"<type>Agg</type><id/><min x:type='double'>1.1</min><max>1.1</max>";
    ZKSObject *o = [self parseSobject:xml];
    XCTAssertTrue([o containsField:@"min"]);
    XCTAssertTrue([o containsField:@"max"]);
    XCTAssertFalse([o containsField:@"sum"]);
    ZKSObject *c = [o copy];
    XCTAssertTrue([c containsField:@"min"]);
    XCTAssertTrue([c containsField:@"max"]);
    XCTAssertFalse([c containsField:@"sum"]);
}

-(void)testXmlType {
    NSString *xml = @"<type>Agg</type><id/><min x:type='xsd:double'>1.1</min><max>1.1</max>";
    ZKSObject *o = [self parseSobject:xml];
    XCTAssertEqualObjects(@"xsd:double", [o typeOfField:@"min"]);
    XCTAssertNil([o typeOfField:@"max"]);
    XCTAssertNil([o typeOfField:@"missing"]);
}

-(void)testXmlTypeWithDesc {
    NSString *xmld = @"<desc><fields><name>max</name><soapType>xsd:decimal</soapType></fields></desc>";
    ZKElement *e = [ZKParser parseData:[xmld dataUsingEncoding:NSUTF8StringEncoding]];
    ZKDescribeSObject *desc = [[ZKDescribeSObject alloc] initWithXmlElement:e];
    
    NSString *xmlo = @"<type>Agg</type><id/><min x:type='xsd:double'>1.1</min><max>1.1</max>";
    ZKSObject *o = [self parseSobject:xmlo];
    XCTAssertEqualObjects(@"xsd:double", [o typeOfField:@"min" withDescribe:desc]);
    XCTAssertEqualObjects(@"xsd:decimal", [o typeOfField:@"max" withDescribe:desc]);
    XCTAssertNil([o typeOfField:@"missing" withDescribe:desc]);

    XCTAssertEqualObjects(@"xsd:double", [o typeOfField:@"min" withDescribe:nil]);
    XCTAssertNil([o typeOfField:@"max" withDescribe:nil]);
    XCTAssertNil([o typeOfField:@"missing" withDescribe:nil]);
}

-(void)testTypedGetters {
    NSString *xmlo = @"<type>Agg</type><id/><min>1.1</min><when>2020-11-23</when><sum>3</sum><valid>true</valid>";
    ZKSObject *o = [self parseSobject:xmlo];
    XCTAssertEqual(1.1f, [o floatValue:@"min"]);
    XCTAssertEqual(1.1, [o doubleValue:@"min"]);
    XCTAssertEqual(3, [o intValue:@"sum"]);
    XCTAssertFalse([o boolValue:@"sum"]);
    XCTAssertTrue([o boolValue:@"valid"]);
    [self assertDate:[o dateValue:@"when"] equalsYear:2020 month:11 day:23];
}

-(void)testTypedValue {
    NSString *xmld = @"<desc><fields><name>max</name><soapType>xsd:decimal</soapType></fields></desc>";
    ZKElement *e = [ZKParser parseData:[xmld dataUsingEncoding:NSUTF8StringEncoding]];
    ZKDescribeSObject *desc = [[ZKDescribeSObject alloc] initWithXmlElement:e];
    
    NSString *xmlo = @"<type>Agg</type><id/><min x:type='xsd:double'>1.1</min><max>1.1</max><sum>3</sum>";
    ZKSObject *o = [self parseSobject:xmlo];

    NSObject *min = [o typedValueOfField:@"min" withDescribe:desc];
    XCTAssertTrue([min isKindOfClass:[NSNumber class]], @"has class %@", [min className]);
    XCTAssertEqualObjects([NSNumber numberWithDouble:1.1], min);
    NSObject *min2 = [o typedValueOfField:@"min" withDescribe:desc];
    XCTAssertTrue(min == min2);
    
    NSObject *max = [o typedValueOfField:@"max" withDescribe:desc];
    XCTAssertTrue([max isKindOfClass:[NSDecimalNumber class]], @"has class %@", [max className]);
    XCTAssertEqualObjects([NSDecimalNumber decimalNumberWithString:@"1.1"], max);
    NSObject *max2 = [o typedValueOfField:@"max" withDescribe:desc];
    XCTAssertTrue(max == max2);
    
    NSObject *sum = [o typedValueOfField:@"sum" withDescribe:desc];
    XCTAssertTrue([sum isKindOfClass:[NSString class]]);
    XCTAssertEqualObjects(@"3", sum);
    NSObject *sum2 = [o typedValueOfField:@"sum" withDescribe:desc];
    XCTAssertTrue(sum == sum2);
    
    ZKSObject *o2 = [o copy];
    XCTAssertEqualObjects(min, [o2 typedValueOfField:@"min" withDescribe:desc]);
    
    o = [ZKSObject withType:@"Account"];
    NSNumber *n = @(4321);
    [o setFieldValue:n field:@"size"];
    NSObject *s = [o typedValueOfField:@"size" withDescribe:desc];
    XCTAssertTrue(n == s);
}

@end
