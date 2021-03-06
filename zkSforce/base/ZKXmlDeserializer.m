// Copyright (c) 2006,2013,2014,2016,2018 Simon Fell
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

#import "ZKXmlDeserializer.h"
#import "ZKParser.h"
#import "ZKBase64.h"
#import "ZKSObject.h"
#import "ZKQueryResult.h"
#import "ZKSimpleTypes.h"
#import "ZKXsdAnyType.h"

@implementation ZKXmlDeserializer

static NSMutableDictionary *registeredComplexTypes;

+(void)load {
    registeredComplexTypes = [[NSMutableDictionary alloc] init];
}

+ (void)registerType:(Class)cls xmlName:(NSString *)name {
    id inst = [cls alloc];
    NSAssert([inst conformsToProtocol:@protocol(ZKXmlInitable)], @"registered type %@ does not conform to xmlInitable protocol", cls);
    [registeredComplexTypes setObject:cls forKey:name];
}

+ (NSObject<ZKXmlInitable>*)instanceOfXmlType:(NSString *)localName {
    Class c = [registeredComplexTypes objectForKey:localName];
    return [c alloc];
}

-(instancetype)initWithXmlElement:(ZKElement *)e {
    self = [super init];
    node = e;
    return self;
}

- (instancetype)init {
    self = [super init];
    return self;
}

- (NSString *)string:(NSString *)elem {
    return [self string:elem fromXmlElement:node];
}

- (BOOL)boolean:(NSString *)elem {
    return [self string:elem].ZKBoolean.boolValue;
}

- (int)integer:(NSString *)elem {
    return [self string:elem].intValue;
}

- (int64_t)int64:(NSString *)elem {
    return [self string:elem].longLongValue;
}

- (double)double:(NSString *)elem {
    return [self string:elem].doubleValue;
}

- (NSDate *)time:(NSString *)elem {
    return [self string:elem].ZKTime;
}

- (NSDate *)date:(NSString *)elem {
    return [self string:elem].ZKDate;
}

- (NSDate *)dateTime:(NSString *)elem {
    return [self string:elem].ZKDateTime;
}

- (ZKSObject *)sObject:(NSString *)elem {
    return [self complexTypeArrayFromElements:elem cls:[ZKSObject class]].lastObject;
}

- (ZKQueryResult *)queryResult:(NSString *)elem {
    return [self complexTypeArrayFromElements:elem cls:[ZKQueryResult class]].lastObject;
}

- (ZKXsdAnyType *)anyType:(NSString *)elem {
    return [[ZKXsdAnyType alloc] initWithXmlElement:[node childElement:elem]];
}

- (NSData *)blob:(NSString *)elem {
    return [self string:elem fromXmlElement:node].ZKBase64Decode;
}

- (NSArray *)strings:(NSString *)elem {
    NSArray *nodes = [node childElements:elem];
    NSMutableArray *s = [NSMutableArray arrayWithCapacity:nodes.count];
    for (ZKElement *e in nodes) {
        [s addObject:e.stringValue];
    }
    return s;
}

- (NSString *)string:(NSString *)elemName fromXmlElement:(ZKElement*)xmlElement {
    return [xmlElement childElement:elemName].stringValue;
}

- (Class) complexTypeClassForType:(ZKNamespacedName *)xsiType baseClass:(Class)base {
    if (xsiType == nil || (xsiType.localname).length == 0) return base;
    Class cls = [registeredComplexTypes objectForKey:xsiType.localname];
    return cls != nil && [cls isSubclassOfClass:base] ? cls : base;
}

- (NSArray *)complexTypeArrayFromElements:(NSString *)elemName cls:(Class)type {
    NSArray *elements = [node childElements:elemName];
    NSMutableArray *results = [NSMutableArray arrayWithCapacity:elements.count];
    for(ZKElement *childNode in elements) {
        Class actualType = [self complexTypeClassForType:childNode.xsiType baseClass:type];
        NSObject *child = [[actualType alloc] initWithXmlElement:childNode];
        [results addObject:child];
    }
    return results;
}

-(NSString *)description {
    NSString *objectName = [NSString stringWithFormat:@"<%@: %p>", NSStringFromClass([self class]), self];
    if ([self respondsToSelector:@selector(name)]) {
        objectName = [NSString stringWithFormat:@"%@ name: %@", objectName, [self performSelector:@selector(name) withObject:nil]];
    }
    return objectName;
}

@end
