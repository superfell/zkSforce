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

#import "ZKSoapDateTests.h"
#import "ZKSoapDate.h"

@implementation ZKSoapDateTests

-(void)setUp {
    [super setUp];
    cal = [[NSCalendar alloc] initWithCalendarIdentifier:(NSString *)kCFGregorianCalendar];
    [cal setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
}

-(void)tearDown {
    [cal release];
    [super tearDown];
}

-(void)assertDate:(NSDate *)date equalsYear:(NSInteger)yr month:(NSInteger)month day:(NSInteger)day {
    NSDateComponents *dc = [cal components:-1 fromDate:date];
    XCTAssertEqual(yr, [dc year]);
    XCTAssertEqual(month, [dc month]);
    XCTAssertEqual(day, [dc day]);
}

-(void)assertDateTime:(NSDate *)date equalsYears:(NSInteger)yr month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour mins:(NSInteger)mins seconds:(NSInteger)seconds {
    [self assertDate:date equalsYear:yr month:month day:day];
    NSDateComponents *dc = [cal components:-1 fromDate:date];
    XCTAssertEqual(hour, [dc hour]);
    XCTAssertEqual(mins, [dc minute]);
    XCTAssertEqual(seconds, [dc second]);
}

-(void)testDateFromString {
    NSDate *d = [[ZKSoapDate instance] fromDateString:@"2013-11-24"];
    [self assertDate:d equalsYear:2013 month:11 day:24];
}

-(void)testDateTimeFromString {
    NSDate *d = [[ZKSoapDate instance] fromDateTimeString:@"2013-11-24T23:12:49.000Z"];
    [self assertDateTime:d equalsYears:2013 month:11 day:24 hour:23 mins:12 seconds:49];
}

-(void)testToDateString {
    NSDateComponents *c = [[[NSDateComponents alloc] init] autorelease];
    [c setYear:2013];
    [c setMonth:11];
    [c setDay:23];
    NSDate *d = [[NSCalendar currentCalendar] dateFromComponents:c];
    XCTAssertEqualObjects(@"2013-11-23", [[ZKSoapDate instance] toDateString:d]);
}

-(void)testToDateTimeString {
    // TODO, this depends on the current users timezone
    NSDateComponents *c = [[[NSDateComponents alloc] init] autorelease];
    [c setYear:2013];
    [c setMonth:12];
    [c setDay:5];
    [c setHour:19];
    [c setMinute:18];
    [c setSecond:59];
    NSDate *d = [[NSCalendar currentCalendar] dateFromComponents:c];
    XCTAssertEqualObjects(@"2013-12-05T19:18:59.0000-08:00", [[ZKSoapDate instance] toDateTimeString:d]);
}

@end
