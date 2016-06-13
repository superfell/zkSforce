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
    NSLocale *posix =[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    NSTimeZone *utc =[NSTimeZone timeZoneForSecondsFromGMT:0];
	dateTimeFormatter = [[NSDateFormatter alloc] init];
	[dateTimeFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSSZZZZZ"];
    dateTimeFormatter.locale =posix;
    dateTimeFormatter.timeZone =utc;

    dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd"];
    dateFormatter.locale = posix;
    
    timeFormatter = [[NSDateFormatter alloc] init];
    timeFormatter.locale = posix;
    timeFormatter.timeZone =utc;
    [timeFormatter setDateFormat:@"HH:mm:ss.SSSSZZZZZ"];
    
    return self;
}

-(void)dealloc {
    [dateTimeFormatter release];
    [dateFormatter release];
    [timeFormatter release];
    [super dealloc];
}

+(ZKSoapDate *)instance {
    return INSTANCE;
}

-(NSString *)toDateString:(NSDate *)aDate {
    return [dateFormatter stringFromDate:aDate];
}

-(NSString *)toDateTimeString:(NSDate *)aDateTime {
    return [dateTimeFormatter stringFromDate:aDateTime];
}

-(NSString *)toTimeString:(NSDate *)aTime {
    return [timeFormatter stringFromDate:aTime];
}

-(NSDate *)fromDateString:(NSString *)aDate {
    return [dateFormatter dateFromString:aDate];
}

-(NSDate *)fromDateTimeString:(NSString *)aDateTime {
	return [dateTimeFormatter dateFromString:aDateTime];
}

-(NSDate *)fromTimeString:(NSString *)aTime {
    return [timeFormatter dateFromString:aTime];
}

@end
