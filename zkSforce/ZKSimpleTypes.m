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

#import "ZKSimpleTypes.h"
#import "ZKBase64.h"
#import "ZKSoapDate.h"

@implementation NSString(ZKSimpleTypes)

-(NSNumber *)ZKBoolean {
    return [NSNumber numberWithBool:[self isEqualToString:@"true"] || [self isEqualToString:@"1"]];
}

-(NSDecimalNumber *)ZKDecimal {
    return [NSDecimalNumber decimalNumberWithString:self locale:[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]];
}

-(NSNumber *)ZKInteger {
    return [NSNumber numberWithLongLong:[self longLongValue]];
}

-(NSNumber *)ZKFloat {
    return [NSNumber numberWithFloat:[self floatValue]];
}

-(NSNumber *)ZKDouble {
    return [NSNumber numberWithDouble:[self doubleValue]];
}

-(NSDate *)ZKDateTime {
    return [[ZKSoapDate instance] fromDateTimeString:self];
}

-(NSDate *)ZKTime {
    return [[ZKSoapDate instance] fromTimeString:self];
}

-(NSDate *)ZKDate {
    return [[ZKSoapDate instance] fromDateString:self];
}

-(NSData *)ZKBase64Binary {
    return [self ZKBase64Decode];
}

@end