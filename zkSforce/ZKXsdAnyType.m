// Copyright (c) 2016,2018 Simon Fell
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

- (instancetype)initWithXmlElement:(zkElement *)e {
    self = [super initWithXmlElement:e];
    xsiType = node.xsiType;
    return self;
}

-(NSObject *)value {
    if (val == nil) {
        val = self.decodeValue;
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
    if (node.xsiNil) {
        return [NSNull null];
    }
    if ((xsiType.namespaceURI).length == 0) {
        return node.stringValue;
    }
    if ([xsiType.namespaceURI isEqualToString:NS_URI_XSD]) {
        NSString *ln = xsiType.localname;
        if ([ln isEqualToString:@"string"]) {
            return node.stringValue;
        } else if ([ln isEqualToString:@"boolean"]) {
            return node.stringValue.ZKBoolean;
        } else if ([ln isEqualToString:@"decimal"]) {
            return node.stringValue.ZKDecimal;
        } else if ([ln isEqualToString:@"integer"]) {
            return node.stringValue.ZKInteger;
        } else if ([ln isEqualToString:@"float"]) {
            return node.stringValue.ZKFloat;
        } else if ([ln isEqualToString:@"double"]) {
            return node.stringValue.ZKDouble;
        } else if ([ln isEqualToString:@"dateTime"]) {
            return node.stringValue.ZKDateTime;
        } else if ([ln isEqualToString:@"time"]) {
            return node.stringValue.ZKTime;
        } else if ([ln isEqualToString:@"date"]) {
            return node.stringValue.ZKDate;
        } else if ([ln isEqualToString:@"base64Binary"]) {
            return node.stringValue.ZKBase64Binary;
        } else {
            NSLog(@"xsd:anyType found element with standard type %@ with no deserializer registered, returning NSString*", xsiType.localname);
            return node.stringValue;
        }
    }
    Class complexType = [self complexTypeClassForType:xsiType baseClass:[NSObject class]];
    id complexTypeInst = [complexType alloc];
    if (![complexTypeInst respondsToSelector:@selector(initWithXmlElement:)]) {
        NSLog(@"Unable to find a class for type %@ [mapped class was %@", xsiType, complexType);
        return node;
    }
    return [complexTypeInst initWithXmlElement:node];
}

@end
