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

#import "ZKSoapDate.h"

@implementation ZKSoapDate

static ZKSoapDate *INSTANCE;

+(void)initialize {
    INSTANCE = [[ZKSoapDate alloc] init];
}

-(id)init {
    self = [super init];
	dateTimeFormatter = [[NSDateFormatter alloc] init];
	[dateTimeFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSSZZZZZ"];
    dateTimeFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    dateTimeFormatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];

    dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd"];
    dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    return self;
}

-(void)dealloc {
    [dateTimeFormatter release];
    [dateFormatter release];
    [super dealloc];
}

+(ZKSoapDate *)instance {
    return INSTANCE;
}

-(NSString *)toDateString:(NSDate *)aDate {
    return [dateFormatter stringFromDate:aDate];
}

-(NSString *)toDateTimeString:(NSDate *)aDateTime {
    return [NSMutableString stringWithString:[dateTimeFormatter stringFromDate:aDateTime]];
}

-(NSDate *)fromDateString:(NSString *)aDate {
    return [dateFormatter dateFromString:aDate];
}

-(NSDate *)fromDateTimeString:(NSString *)aDateTime {
	return [dateTimeFormatter dateFromString:aDateTime];
}

@end
