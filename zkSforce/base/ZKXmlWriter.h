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

#import <Foundation/Foundation.h>

@interface ZKXmlWriter : NSObject {
    NSMutableString     *env;
}
-(instancetype)init NS_DESIGNATED_INITIALIZER;

- (void) startElement:(NSString *)elemName;
- (void) startElement:(NSString *)elemName type:(NSString *)type;
- (void) startElement:(NSString *)elemName prefixes:(NSArray*)prefixes uris:(NSArray*)uris;

- (void) writeText:(NSString *)text;

- (void) endElement:(NSString *)elemName;

- (void) addElement:(NSString *)elemName elemValue:(id)elemValue;
- (void) addElement:(NSString *)elemName elemValue:(id)elemValue nillable:(BOOL)nillable optional:(BOOL)optional;

- (void) addNullElement:(NSString *)elemName;
- (void) addBoolElement:(NSString *)elemName elemValue:(BOOL)elemValue;
- (void) addIntElement:(NSString *)elemName elemValue:(NSInteger)elemValue;
- (void) addDoubleElement:(NSString *)elemName elemValue:(double)elemValue;
- (void) addElementArray:(NSString *)elemName   elemValue:(NSArray *)elemValues;
- (void) addElementString:(NSString *)elemName  elemValue:(NSString *)elemValue;

- (NSString *)output;

@end
