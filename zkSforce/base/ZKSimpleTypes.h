// Copyright (c) 2016,2020 Simon Fell
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

@property (readonly) NSNumber *ZKBoolean;
@property (readonly) NSDecimalNumber *ZKDecimal;
@property (readonly) NSNumber *ZKInteger;
@property (readonly) NSNumber *ZKLong;
@property (readonly) NSNumber *ZKFloat;
@property (readonly) NSNumber *ZKDouble;
@property (readonly) NSDate *ZKDateTime;
@property (readonly) NSDate *ZKTime;
@property (readonly) NSDate *ZKDate;
@property (readonly) NSData *ZKBase64Binary;

/** convert to the specified xml type. Returns one of the types listed above. */
-(id)ZKAsXmlType:(NSString *)xsdTypeLocalName;

@end
