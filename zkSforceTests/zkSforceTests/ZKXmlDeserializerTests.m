// Copyright (c) 2013-2014 Simon Fell
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

#import "ZKXmlDeserializerTests.h"
#import "zkXmlDeserializer.h"
#import "zkParser.h"
#import "zkSObject.h"
#import "zkQueryResult.h"
#import "ZKReportChartComponent.h"
#import "ZKDescribeColumn.h"
#import "ZKStringList.h"
#import "ZKAddress.h"

@implementation ZKXmlDeserializerTests

-(ZKXmlDeserializer *)deser:(NSString *)doc {
    ZKElement *e = [ZKParser parseData:[doc dataUsingEncoding:NSUTF8StringEncoding]];
    return [[ZKXmlDeserializer alloc] initWithXmlElement:e];
}

-(void)testSimpleTypes {
    NSString *doc = @"<root><str>hello world</str><num>123</num><float>12.13</float><date>2013-11-25</date><dateTime>2013-11-25T13:14:15.000Z</dateTime><bool>true</bool></root>";
    ZKXmlDeserializer *d = [self deser:doc];
    XCTAssertEqualObjects([d string:@"str"], @"hello world");
    XCTAssertEqual(123, [d integer:@"num"]);
    XCTAssertEqual(12.13, [d double:@"float"]);
    XCTAssertTrue([d boolean:@"bool"]);
    NSDateComponents *c = [[NSCalendar currentCalendar] components:-1 fromDate:[d date:@"date"]];
    XCTAssertEqual((NSInteger)2013, [c year]);
    XCTAssertEqual((NSInteger)11, [c month]);
    XCTAssertEqual((NSInteger)25, [c day]);
    c = [[NSCalendar currentCalendar] components:-1 fromDate:[d dateTime:@"dateTime"]];
    NSInteger offset = [[NSCalendar currentCalendar].timeZone secondsFromGMTForDate:[d dateTime:@"dateTime"]];
    XCTAssertEqual((NSInteger)2013, [c year]);
    XCTAssertEqual((NSInteger)11, [c month]);
    XCTAssertEqual((NSInteger)25, [c day]);
    XCTAssertEqual((NSInteger)13 + (offset/3600), [c hour]);
    XCTAssertEqual((NSInteger)14, [c minute]);
    XCTAssertEqual((NSInteger)15, [c second]);
}

-(void)testBlob {
    NSString *doc = @"<root><b>Ym9iIQ==</b></root>";
    ZKXmlDeserializer *d = [self deser:doc];
    NSData *expected = [@"bob!" dataUsingEncoding:NSUTF8StringEncoding];
    NSData *actual = [d blob:@"b"];
    XCTAssertEqualObjects(expected, actual);
}

-(void)testMissingBlob {
    NSString *doc = @"<root><c></c></root>";
    ZKXmlDeserializer *d = [self deser:doc];
    // check that asking for a blob that doesn't exist doesn't barf
    XCTAssertNil([d blob:@"b"]);
}

-(void)testStrings {
    NSString *doc = @"<root><a>one</a><a>two</a></root>";
    ZKXmlDeserializer *d = [self deser:doc];
    NSArray *exp = @[@"one", @"two"];
    XCTAssertEqualObjects(exp, [d strings:@"a"]);
}

-(void)testDeserializerType {
    NSString *doc = @"<root><comp><displayLines>4</displayLines><tabOrder>1</tabOrder><type>foo</type><value>bob</value></comp></root>";
    ZKXmlDeserializer *d = [self deser:doc];
    ZKDescribeLayoutComponent *c = [d complexTypeArrayFromElements:@"comp" cls:[ZKDescribeLayoutComponent class]].lastObject;
    XCTAssertEqual((NSInteger)4, c.displayLines);
    XCTAssertEqual((NSInteger)1, c.tabOrder);
    XCTAssertEqualObjects(@"foo", c.type);
    XCTAssertEqualObjects(@"bob", c.value);
}

-(void)testExtensionDeserializerType {
    NSString *doc = @"<root xmlns:x='http://www.w3.org/2001/XMLSchema-instance'><comp x:type='s:ReportChartComponent'><displayLines>4</displayLines><tabOrder>1</tabOrder><type>foo</type><value>bob</value><cacheData>true</cacheData></comp></root>";
    ZKXmlDeserializer *d = [self deser:doc];
    ZKReportChartComponent *c = [d complexTypeArrayFromElements:@"comp" cls:[ZKDescribeLayoutComponent class]].lastObject;
    XCTAssertTrue([c isKindOfClass:[ZKReportChartComponent class]]);
    XCTAssertEqual((NSInteger)4, c.displayLines);
    XCTAssertEqual((NSInteger)1, c.tabOrder);
    XCTAssertEqualObjects(@"foo", c.type);
    XCTAssertEqualObjects(@"bob", c.value);
    XCTAssertTrue(c.cacheData);
}

-(void)testSObject {
    NSString *doc = @"<root><a><type>Account</type><Id>001123</Id><bob>Bob</bob></a></root>";
    ZKXmlDeserializer *d = [self deser:doc];
    ZKSObject *o = [d sObject:@"a"];
    XCTAssertEqualObjects(@"Account", [o type]);
    XCTAssertEqualObjects(@"001123", [o id]);
    XCTAssertEqualObjects(@"Bob", [o fieldValue:@"bob"]);
}

-(void)testQueryResult {
    NSString *doc = @"<root><q><done>false</done><queryLocator>123</queryLocator><records><type>Account</type><Id>1</Id></records><size>1</size></q></root>";
    ZKXmlDeserializer *d = [self deser:doc];
    ZKQueryResult *qr = [d queryResult:@"q"];
    XCTAssertFalse([qr done]);
    XCTAssertEqualObjects(@"123", [qr queryLocator]);
    XCTAssertEqualObjects(@"Account", [(ZKSObject *)[[qr records] lastObject] type]);
    XCTAssertEqual(1, [qr size]);
}

-(void)testSubClassesCacheValue {
    NSString *doc = @"<root><values>a</values><values>b</values></root>";
    ZKElement *e = [ZKParser parseData:[doc dataUsingEncoding:NSUTF8StringEncoding]];
    ZKStringList *l = [[ZKStringList alloc] initWithXmlElement:e];
    NSArray *v = l.values;
    XCTAssertEqualObjects((@[@"a",@"b"]), v);
    XCTAssertEqual(v, l.values);
}

@end
