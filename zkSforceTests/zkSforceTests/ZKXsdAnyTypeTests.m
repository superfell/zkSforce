// Copyright (c) 2016 Simon Fell
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

#import "NSDateAsserts.h"
#import "ZKXsdAnyType.h"
#import "zkParser.h"
#import "ZKQueryResult.h"
#import "ZKSObject.h"

@interface ZKXsdAnyTypeTests : NSDateAsserts

@end

@implementation ZKXsdAnyTypeTests

-(ZKXsdAnyType*)buildAndParseAny:(NSString *)xmlTrailer {
    NSString *doc = [NSString stringWithFormat:@"<r xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:x='http://www.w3.org/2001/XMLSchema' %@", xmlTrailer];
    zkElement *e = [zkParser parseData:[doc dataUsingEncoding:NSUTF8StringEncoding]];
    ZKXsdAnyType *any = [[ZKXsdAnyType alloc] initWithXmlElement:e];
    return any;
}

-(void)testSimpleTypes {
    XCTAssertNil([[self buildAndParseAny:@"xsi:nil='true'/>"] value]);
    XCTAssertEqualObjects([NSNumber numberWithBool:TRUE], [[self buildAndParseAny:@"xsi:type='x:boolean'>true</r>"] value]);
    XCTAssertEqualObjects([NSNumber numberWithLongLong:42], [[self buildAndParseAny:@"xsi:type='x:integer'>42</r>"] value]);
    XCTAssertEqualObjects(@42.42, [[self buildAndParseAny:@"xsi:type='x:double'>42.42</r>"] value]);
    [self assertDateTime:(NSDate *)[self buildAndParseAny:@"xsi:type='x:dateTime'>2016-11-12T13:14:15.0000Z</r>"].value equalsYears:2016 month:11 day:12 hour:13 mins:14 seconds:15];
}

-(void)testXsiType {
    ZKXsdAnyType *a = [self buildAndParseAny:@"xsi:type='x:integer'>42</r>"];
    XCTAssertEqualObjects(NS_URI_XSD, [a typeNamespaceURI]);
    XCTAssertEqualObjects(@"integer", [a typeName]);
}

-(void)testQueryResult {
    ZKXsdAnyType *a = [self buildAndParseAny:@"xmlns:p='urn:partner.soap.sforce.com' xsi:type='p:QueryResult'><done>false</done><size>42</size><queryLocator>bob</queryLocator><records><type>Account</type><Id>123</Id><Name>Foo</Name></records></r>"];
    XCTAssertEqualObjects(@"urn:partner.soap.sforce.com", [a typeNamespaceURI]);
    XCTAssertEqualObjects(@"QueryResult", [a typeName]);
    XCTAssertEqualObjects([ZKQueryResult class], [[a value] class]);
    ZKQueryResult *qr = (ZKQueryResult *)a.value;
    XCTAssertFalse([qr done]);
    XCTAssertEqual(42, [qr size]);
    XCTAssertEqualObjects(@"bob", [qr queryLocator]);
    XCTAssertEqual(1, [[qr records] count]);
    ZKSObject *acc = qr.records.lastObject;
    XCTAssertEqualObjects(@"Account", [acc type]);
    XCTAssertEqualObjects(@"123", [acc id]);
    XCTAssertEqualObjects(@"Foo", [acc fieldValue:@"Name"]);
}
@end
