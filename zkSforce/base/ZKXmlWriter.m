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

#import "ZKXmlWriter.h"
#import "ZKXMLSerializable.h"
#import "ZKConstants.h"

@interface ZKXmlWriter()
@property NSMutableDictionary *prefixes;
@end

@implementation ZKXmlWriter

-(instancetype)init {
    self = [super init];
    env = [[NSMutableString alloc] initWithCapacity:256];
    self.prefixes = [[NSMutableDictionary alloc] init];
    return self;
}

- (void)startElement:(NSString *)elemName prefixes:(NSArray*)prefixes uris:(NSArray*)uris {
    [env appendFormat:@"<%@", elemName];
    for (int i = 0; i < prefixes.count; i++) {
        if ([prefixes[i] length] == 0) {
            [env appendFormat:@" xmlns='%@'", uris[i]];
        } else {
            [env appendFormat:@" xmlns:%@='%@'", prefixes[i], uris[i]];
        }
        [self.prefixes setObject:prefixes[i] forKey:uris[i]];
    }
    [env appendString:@">"];
}

- (void)startElement:(NSString *)elemName {
    [env appendFormat:@"<%@>", elemName];
}

- (void) startElement:(NSString *)elemName type:(NSString *)xmlType {
    [env appendFormat:@"<%@ %@:type=\"%@\">", elemName, self.prefixes[NS_URI_XSI], xmlType];
}

- (void )endElement:(NSString *)elemName {
    [env appendFormat:@"</%@>", elemName];
}

- (void) writeText:(NSString *)text  {
    unichar c;
    NSUInteger i, len = text.length;
    for (i = 0; i < len; i++)
    {
        c = [text characterAtIndex:i];
        switch (c)
        {
            case '<' : [env appendString:@"&lt;"]; break;
            case '>' : [env appendString:@"&gt;"]; break;
            case '&' : [env appendString:@"&amp;"]; break;
            default  : [env appendFormat:@"%C", c];
        }
    }
}

- (void) addNullElement:(NSString *)elemName {
    [env appendFormat:@"<%@ %@:nil='true'/>", elemName, self.prefixes[NS_URI_XSI]];
}

- (void) addBoolElement:(NSString *)elemName elemValue:(BOOL)elemValue {
    [self addElement:elemName elemValue:(elemValue ? @"true" :@"false")];
}

- (void) addIntElement:(NSString *)elemName elemValue:(NSInteger)elemValue {
    [self addElement:elemName elemValue:@(elemValue)];
}

- (void) addDoubleElement:(NSString *)elemName elemValue:(double)elemValue {
    [self addElement:elemName elemValue:@(elemValue)];
}

- (void) addElement:(NSString *)elemName elemValue:(id)elemValue {
    [self addElement:elemName elemValue:elemValue nillable:NO optional:NO];
}

- (void) addElementArray:(NSString *)elemName elemValue:(NSArray *)elemValues {
    for (id o in elemValues) {
        [self addElement:elemName elemValue:o];
    }
}

- (void) addElementString:(NSString *)elemName elemValue:(NSString *)elemValue {
    [self startElement:elemName];
    [self writeText:elemValue];
    [self endElement:elemName];
}

- (void) addElement:(NSString *)elemName elemValue:(id)elemValue nillable:(BOOL)nillable optional:(BOOL)optional {
    if (elemValue == nil) {
        if (optional) {
            return;
        }
        if (nillable) {
            [self addNullElement:elemName];
        } else {
            [self addElementString:elemName elemValue:@""];
        }
    } else if ([elemValue isKindOfClass:[NSString class]]) {
        [self addElementString:elemName elemValue:elemValue];
    } else if ([elemValue isKindOfClass:[NSArray class]]) {
        [self addElementArray:elemName elemValue:elemValue];
    } else if ([elemValue conformsToProtocol:@protocol(ZKXMLSerializable)]) {
        [elemValue serializeTo:self elemName:elemName];
    } else {
        [self addElementString:elemName elemValue:[elemValue stringValue]];
    }
}

- (NSString *)output {
    return env;
}

@end
