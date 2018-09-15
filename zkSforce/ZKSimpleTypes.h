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

#import <Foundation/Foundation.h>

/** defines helpers to deserialize common XSD simple types. */
@interface NSString (ZKSimpleTypes)

@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSNumber *ZKBoolean;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSDecimalNumber *ZKDecimal;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSNumber *ZKInteger;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSNumber *ZKFloat;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSNumber *ZKDouble;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSDate *ZKDateTime;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSDate *ZKTime;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSDate *ZKDate;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSData *ZKBase64Binary;

@end
