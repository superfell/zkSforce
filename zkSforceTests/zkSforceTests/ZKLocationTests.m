// Copyright (c) 2021 Simon Fell
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

#import <XCTest/XCTest.h>
#import "ZKLocation.h"
#import "ZKEnvelope.h"

@interface ZKLocationTests : XCTestCase
@end

@implementation ZKLocationTests

- (void)testDeser {
    NSString *doc = @"<loc><longitude>1</longitude><latitude>2</latitude></loc>";
    ZKElement *e = [ZKParser parseData:[doc dataUsingEncoding:NSUTF8StringEncoding]];
    ZKLocation *l = [[ZKLocation alloc] initWithXmlElement:e];
    XCTAssertEqual(1.0, l.longitude);
    XCTAssertEqual(2.0, l.latitude);
}

-(void)testSerialize {
    ZKLocation *l = [[ZKLocation alloc] init];
    l.longitude = 3.5;
    l.latitude = 4.4;
    ZKXmlWriter *env = [[ZKXmlWriter alloc] init];
    [l serializeTo:env elemName:@"loc"];
    XCTAssertEqualObjects(@"<loc><latitude>4.4</latitude><longitude>3.5</longitude></loc>", env.output);
}

-(void)testRoundTripNoEdits {
    NSString *doc = @"<loc><longitude>1</longitude><latitude>2</latitude></loc>";
    ZKElement *e = [ZKParser parseData:[doc dataUsingEncoding:NSUTF8StringEncoding]];
    ZKLocation *l = [[ZKLocation alloc] initWithXmlElement:e];
    XCTAssertEqual(1.0, l.longitude);
    XCTAssertEqual(2.0, l.latitude);
    ZKXmlWriter *env = [[ZKXmlWriter alloc] init];
    [l serializeTo:env elemName:@"loc"];
    XCTAssertEqualObjects(@"<loc><latitude>2</latitude><longitude>1</longitude></loc>", env.output);
}

-(void)testRoundTripWithEdits {
    NSString *doc = @"<loc><longitude>1</longitude><latitude>2</latitude></loc>";
    ZKElement *e = [ZKParser parseData:[doc dataUsingEncoding:NSUTF8StringEncoding]];
    ZKLocation *l = [[ZKLocation alloc] initWithXmlElement:e];
    XCTAssertEqual(1.0, l.longitude);
    XCTAssertEqual(2.0, l.latitude);
    l.longitude = 5.5;
    l.latitude = 1.1;
    XCTAssertEqual(5.5, l.longitude);
    XCTAssertEqual(1.1, l.latitude);
    ZKXmlWriter *env = [[ZKXmlWriter alloc] init];
    [l serializeTo:env elemName:@"loc"];
    XCTAssertEqualObjects(@"<loc><latitude>1.1</latitude><longitude>5.5</longitude></loc>", env.output);
}

@end
