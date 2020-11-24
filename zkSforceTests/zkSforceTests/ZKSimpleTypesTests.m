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
#import "ZKSimpleTypes.h"

@interface ZKSimpleTypesTests : NSDateAsserts
@end

@implementation ZKSimpleTypesTests

-(void)testBoolean {
    XCTAssertEqualObjects([NSNumber numberWithBool:TRUE], [@"true" ZKBoolean]);
    XCTAssertEqualObjects([NSNumber numberWithBool:TRUE], [@"1" ZKBoolean]);
    XCTAssertEqualObjects([NSNumber numberWithBool:FALSE], [@"false" ZKBoolean]);
    XCTAssertEqualObjects([NSNumber numberWithBool:FALSE], [@"0" ZKBoolean]);
}

-(void)testDecimal {
    XCTAssertEqualObjects([NSDecimalNumber one], [@"1.0" ZKDecimal]);
    XCTAssertEqualObjects([NSDecimalNumber decimalNumberWithMantissa:12345 exponent:-3 isNegative:YES], [@"-12.345" ZKDecimal]);
}

-(void)testInteger {
    XCTAssertEqualObjects([NSNumber numberWithLongLong:0], [@"0" ZKInteger]);
    XCTAssertEqualObjects([NSNumber numberWithLongLong:-1234], [@"-1234" ZKInteger]);
    XCTAssertEqualObjects([NSNumber numberWithLongLong:123456], [@"123456" ZKInteger]);
}

-(void)testLong {
    XCTAssertEqualObjects([NSNumber numberWithLongLong:0], [@"0" ZKLong]);
    XCTAssertEqualObjects([NSNumber numberWithLongLong:-1234], [@"-1234" ZKLong]);
    XCTAssertEqualObjects([NSNumber numberWithLongLong:9223372036854775807], [@"9223372036854775807" ZKLong]);
}

-(void)testFloat {
    XCTAssertEqualObjects([NSNumber numberWithFloat:1.0], [@"1.0" ZKFloat]);
    XCTAssertEqualObjects([NSNumber numberWithFloat:-123.12], [@"-123.12" ZKFloat]);
    XCTAssertEqualObjects([NSNumber numberWithFloat:42.42], [@"42.42" ZKFloat]);
}

-(void)testDouble {
    XCTAssertEqualObjects(@1.0, [@"1.0" ZKDouble]);
    XCTAssertEqualObjects(@-123.12, [@"-123.12" ZKDouble]);
    XCTAssertEqualObjects(@42.42, [@"42.42" ZKDouble]);
}

-(void)testDateTime {
    [self assertDateTime:(@"2016-06-29T20:21:22.0000Z").ZKDateTime equalsYears:2016 month:06 day:29 hour:20 mins:21 seconds:22];
}

-(void)testDate {
    [self assertDate:(@"2016-11-12").ZKDate equalsYear:2016 month:11 day:12];
}

-(void)testTime {
    [self assertTime:(@"22:23:24.0000Z").ZKTime equalsHour:22 minute:23 seconds:24];
}

-(void)testBase64Binary {
    NSData *d = (@"Ym9iIQ==").ZKBase64Binary;
    NSString *ds = [[NSString alloc] initWithData:d encoding:NSUTF8StringEncoding];
    XCTAssertEqualObjects(@"bob!", ds);
}
@end
