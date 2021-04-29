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
#import "ZKDescribeField.h"
#import "ZKDescribeSObject.h"

@interface ZKDescribeSObjectTest : XCTestCase
@end

@implementation ZKDescribeSObjectTest

- (void)testFieldsSetterGetter {
    ZKDescribeField *f1 = [ZKDescribeField new];
    f1.name = @"Name";
    ZKDescribeField *f2 = [ZKDescribeField new];
    f2.name = @"Id";
    ZKDescribeSObject *o = [ZKDescribeSObject new];
    o.fields = @[f1,f2];
    XCTAssertEqualObjects((@[f1,f2]), o.fields);
}

@end
