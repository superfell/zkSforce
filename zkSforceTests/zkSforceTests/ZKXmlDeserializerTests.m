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

@implementation ZKXmlDeserializerTests

-(ZKXmlDeserializer *)deser:(NSString *)doc {
    zkElement *e = [zkParser parseData:[doc dataUsingEncoding:NSUTF8StringEncoding]];
    return [[[ZKXmlDeserializer alloc] initWithXmlElement:e] autorelease];
}

-(void)testSimpleTypes {
    NSString *doc = @"<root><str>hello world</str><num>123</num><float>12.13</float><date>2013-11-25</date><dateTime>2013-11-25T13:14:15.000Z</dateTime><bool>true</bool></root>";
    ZKXmlDeserializer *d = [self deser:doc];
    STAssertEqualObjects([d string:@"str"], @"hello world", nil);
    STAssertEquals(123, [d integer:@"num"], nil);
    STAssertEquals(12.13, [d double:@"float"], nil);
    STAssertTrue([d boolean:@"bool"], nil);
    NSDateComponents *c = [[NSCalendar currentCalendar] components:-1 fromDate:[d date:@"date"]];
    STAssertEquals((NSInteger)2013, [c year], nil);
    STAssertEquals((NSInteger)11, [c month], nil);
    STAssertEquals((NSInteger)25, [c day], nil);
    c = [[NSCalendar currentCalendar] components:-1 fromDate:[d dateTime:@"dateTime"]];
    NSInteger offset = [[[NSCalendar currentCalendar] timeZone] secondsFromGMTForDate:[d dateTime:@"dateTime"]];
    STAssertEquals((NSInteger)2013, [c year], nil);
    STAssertEquals((NSInteger)11, [c month], nil);
    STAssertEquals((NSInteger)25, [c day], nil);
    STAssertEquals((NSInteger)13 + (offset/3600), [c hour], nil);
    STAssertEquals((NSInteger)14, [c minute], nil);
    STAssertEquals((NSInteger)15, [c second], nil);
}

-(void)testBlob {
    NSString *doc = @"<root><b>Ym9iIQ==</b></root>";
    ZKXmlDeserializer *d = [self deser:doc];
    NSData *expected = [@"bob!" dataUsingEncoding:NSUTF8StringEncoding];
    NSData *actual = [d blob:@"b"];
    STAssertEqualObjects(expected, actual, nil);
}

-(void)testStrings {
    NSString *doc = @"<root><a>one</a><a>two</a></root>";
    ZKXmlDeserializer *d = [self deser:doc];
    NSArray *exp = [NSArray arrayWithObjects:@"one", @"two", nil];
    STAssertEqualObjects(exp, [d strings:@"a"], nil);
}

-(void)testDeserializerType {
    NSString *doc = @"<root><comp><displayLines>4</displayLines><tabOrder>1</tabOrder><type>foo</type><value>bob</value></comp></root>";
    ZKXmlDeserializer *d = [self deser:doc];
    ZKDescribeLayoutComponent *c = [[d complexTypeArrayFromElements:@"comp" cls:[ZKDescribeLayoutComponent class]] lastObject];
    STAssertEquals((NSInteger)4, c.displayLines, nil);
    STAssertEquals((NSInteger)1, c.tabOrder, nil);
    STAssertEqualObjects(@"foo", c.type, nil);
    STAssertEqualObjects(@"bob", c.value, nil);
}

-(void)testExtensionDeserializerType {
    NSString *doc = @"<root xmlns:x='http://www.w3.org/2001/XMLSchema-instance'><comp x:type='s:ReportChartComponent'><displayLines>4</displayLines><tabOrder>1</tabOrder><type>foo</type><value>bob</value><cacheData>true</cacheData></comp></root>";
    ZKXmlDeserializer *d = [self deser:doc];
    ZKReportChartComponent *c = [[d complexTypeArrayFromElements:@"comp" cls:[ZKDescribeLayoutComponent class]] lastObject];
    STAssertTrue([c isKindOfClass:[ZKReportChartComponent class]], nil);
    STAssertEquals((NSInteger)4, c.displayLines, nil);
    STAssertEquals((NSInteger)1, c.tabOrder, nil);
    STAssertEqualObjects(@"foo", c.type, nil);
    STAssertEqualObjects(@"bob", c.value, nil);
    STAssertTrue(c.cacheData, nil);
}

-(void)testSObject {
    NSString *doc = @"<root><a><type>Account</type><Id>001123</Id><bob>Bob</bob></a></root>";
    ZKXmlDeserializer *d = [self deser:doc];
    ZKSObject *o = [d sObject:@"a"];
    STAssertEqualObjects(@"Account", [o type], nil);
    STAssertEqualObjects(@"001123", [o id], nil);
    STAssertEqualObjects(@"Bob", [o fieldValue:@"bob"], nil);
}

-(void)testQueryResult {
    NSString *doc = @"<root><q><done>false</done><queryLocator>123</queryLocator><records><type>Account</type><Id>1</Id></records><size>1</size></q></root>";
    ZKXmlDeserializer *d = [self deser:doc];
    ZKQueryResult *qr = [d queryResult:@"q"];
    STAssertFalse([qr done], nil);
    STAssertEqualObjects(@"123", [qr queryLocator], nil);
    STAssertEqualObjects(@"Account", [(ZKSObject *)[[qr records] lastObject] type], nil);
    STAssertEquals(1, [qr size], nil);
}

-(void)testNSCopying {
    NSString *doc = @"<root><field>f</field><format>fmt</format><label>lbl</label><name>n</name></root>";
    zkElement *e = [zkParser parseData:[doc dataUsingEncoding:NSUTF8StringEncoding]];
    ZKDescribeColumn *l = [[[ZKDescribeColumn alloc] initWithXmlElement:e] autorelease];
    STAssertEqualObjects([ZKDescribeColumn class], [l class], @"original of wrong type");
    STAssertEqualObjects(@"f", [l field], @"field is wrong");
    STAssertEqualObjects(@"fmt", [l format],  @"format is wrong");
    STAssertEqualObjects(@"lbl", [l label],  @"label is wrong");
    STAssertEqualObjects(@"n", [l name],  @"name is wrong");
    ZKDescribeColumn *copy = [[l copyWithZone:nil] autorelease];
    STAssertNotNil(copy, @"copy was nil");
    STAssertEqualObjects([ZKDescribeColumn class], [copy class], @"copy of wrong type");
    STAssertEqualObjects(@"f", [copy field], @"field is wrong");
    STAssertEqualObjects(@"fmt", [copy format],  @"format is wrong");
    STAssertEqualObjects(@"lbl", [copy label],  @"label is wrong");
    STAssertEqualObjects(@"n", [copy name],  @"name is wrong");
}

@end
