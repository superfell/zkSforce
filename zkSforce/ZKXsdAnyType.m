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

#import "ZKXsdAnyType.h"
#import "zkParser.h"
#import "ZKSimpleTypes.h"

@interface ZKXsdAnyType()

-(NSObject *)decodeValue;

@end

@implementation ZKXsdAnyType

- (id)initWithXmlElement:(zkElement *)e {
    self = [super initWithXmlElement:e];
    xsiType = [[node xsiType] retain];
    return self;
}

-(void)dealloc {
    [xsiType autorelease];
    [val autorelease];
    [super dealloc];
}

-(id)value {
    if (val == nil) {
        val = [[self decodeValue] retain];
    }
    return val == [NSNull null] ? nil : val;
}

-(NSString*)typeNamespaceURI {
    return xsiType.namespaceURI;
}

-(NSString*)typeName {
    return xsiType.localname;
}

-(NSObject *)decodeValue {
    if ([node isXsiNil]) {
        return [NSNull null];
    }
    if ([xsiType.namespaceURI length] == 0) {
        return [node stringValue];
    }
    if ([xsiType.namespaceURI isEqualToString:NS_URI_XSD]) {
        SEL standardType = NSSelectorFromString(xsiType.localname);
        if ([self respondsToSelector:standardType]) {
            return [self performSelector:standardType withObject:nil];
        } else {
            NSLog(@"xsd:anyType found element with standard type %@ with no deserializer registered, returning NSString*", xsiType.localname);
            return [node stringValue];
        }
    }
    Class complexType = [self complexTypeClassForType:xsiType baseClass:[NSObject class]];
    id complexTypeInst = [complexType alloc];
    if (![complexTypeInst respondsToSelector:@selector(initWithXmlElement:)]) {
        NSLog(@"Unable to find a class for type %@ [mapped class was %@", xsiType, complexType);
        return node;
    }
    return [[complexTypeInst initWithXmlElement:node] autorelease];
}

-(NSString *)string {
    return [node stringValue];
}

-(NSNumber *)boolean {
    return [[node stringValue] ZKBoolean];
}

-(NSDecimalNumber *)decimal {
    return [[node stringValue] ZKDecimal];
}

-(NSNumber *)integer {
    return [[node stringValue] ZKInteger];
}

-(NSNumber *)float {
    return [[node stringValue] ZKFloat];
}

-(NSNumber *)double {
    return [[node stringValue] ZKDouble];
}

// TODO duration

-(NSDate *)dateTime {
    return [[node stringValue] ZKDateTime];
}

-(NSDate *)time {
    return [[node stringValue] ZKTime];
}

-(NSDate *)date {
    return [[node stringValue] ZKDate];
}

-(NSData *)base64Binary {
    return [[node stringValue] ZKBase64Binary];
}


@end
