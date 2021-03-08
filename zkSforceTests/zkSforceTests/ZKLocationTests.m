//
//  ZKLocationTests.m
//  zkSforceTests
//
//  Created by Simon Fell on 3/7/21.
//

#import <XCTest/XCTest.h>
#import "ZKLocation.h"
#import "ZKEnvelope.h"

@interface ZKLocationTests : XCTestCase
@end

@implementation ZKLocationTests

- (void)testDeser {
    [self measureBlock:^{
        NSString *doc = @"<loc><longitude>1</longitude><latitude>2</latitude></loc>";
        ZKElement *e = [ZKParser parseData:[doc dataUsingEncoding:NSUTF8StringEncoding]];
        ZKLocation *l = [[ZKLocation alloc] initWithXmlElement:e];
        XCTAssertEqual(1.0, l.longitude);
        XCTAssertEqual(2.0, l.latitude);
    }];
}

-(void)testSerialize {
    [self measureBlock:^{
        ZKLocation *l = [[ZKLocation alloc] init];
        l.longitude = 3.5;
        l.latitude = 4.4;
        ZKXmlWriter *env = [[ZKXmlWriter alloc] init];
        [l serializeTo:env elemName:@"loc"];
        XCTAssertEqualObjects(@"<loc><latitude>4.4</latitude><longitude>3.5</longitude></loc>", env.output);
    }] ;
}

-(void)testRoundTripNoEdits {
    [self measureBlock:^{
        NSString *doc = @"<loc><longitude>1</longitude><latitude>2</latitude></loc>";
        ZKElement *e = [ZKParser parseData:[doc dataUsingEncoding:NSUTF8StringEncoding]];
        ZKLocation *l = [[ZKLocation alloc] initWithXmlElement:e];
        XCTAssertEqual(1.0, l.longitude);
        XCTAssertEqual(2.0, l.latitude);
        ZKXmlWriter *env = [[ZKXmlWriter alloc] init];
        [l serializeTo:env elemName:@"loc"];
        XCTAssertEqualObjects(@"<loc><latitude>2</latitude><longitude>1</longitude></loc>", env.output);
    }];
}

-(void)testRoundTripWithEdits {
    [self measureBlock:^{
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
    }];
}
@end
