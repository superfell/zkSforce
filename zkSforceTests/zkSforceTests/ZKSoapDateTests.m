// Copyright (c) 2013,2016 Simon Fell
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

-(void)testTimeFromString {
    NSDate *d = [[ZKSoapDate instance] fromTimeString:@"11:05:01.3Z"];
    [self assertTime:d equalsHour:11 minute:5 seconds:1];
}

-(void)testDateFromString {
    NSDate *d = [[ZKSoapDate instance] fromDateString:@"2013-11-24"];
    [self assertDate:d equalsYear:2013 month:11 day:24];
}

-(void)testDateTimeFromString {
    NSDate *d = [[ZKSoapDate instance] fromDateTimeString:@"2013-11-24T23:12:49.1Z"];
    [self assertDateTime:d equalsYears:2013 month:11 day:24 hour:23 mins:12 seconds:49];
}

-(void)testToDateString {
    NSDateComponents *c = [[[NSDateComponents alloc] init] autorelease];
    c.year = 2013;
    c.month = 11;
    c.day = 23;
    NSDate *d = [[NSCalendar currentCalendar] dateFromComponents:c];
    XCTAssertEqualObjects(@"2013-11-23", [[ZKSoapDate instance] toDateString:d]);
}

-(void)testToDateTimeString {
    NSDateComponents *c = [[[NSDateComponents alloc] init] autorelease];
    c.year = 2013;
    c.month = 12;
    c.day = 5;
    c.hour = 19;
    c.minute = 18;
    c.second = 59;
    NSDate *d = [cal dateFromComponents:c];
    XCTAssertEqualObjects(@"2013-12-05T19:18:59.0000Z", [[ZKSoapDate instance] toDateTimeString:d]);
}

-(void)testToTimeString {
    NSDateComponents *c = [[[NSDateComponents alloc] init] autorelease];
    c.hour = 10;
    c.minute = 30;
    c.second = 15;
    NSDate *d = [cal dateFromComponents:c];
    XCTAssertEqualObjects(@"10:30:15.0000Z", [[ZKSoapDate instance] toTimeString:d]);
}
@end
