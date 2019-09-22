// Copyright (c) 2006,2014,2018 Simon Fell
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


#import "ZKSObject.h"
#import "ZKQueryResult.h"
#import "ZKParser.h"
#import "ZKSoapDate.h"
#import "ZKAddress.h"
#import "ZKConstants.h"

@interface ZKSObject()
@property (strong) NSMutableSet *fieldsToNullSet;
@property (strong) NSMutableDictionary *fieldsDict;
@property (strong) NSMutableArray *fieldOrder;
@end

@implementation ZKSObject

@synthesize fields, fieldOrder;

+ (instancetype)withType:(NSString *)type {
    return [[ZKSObject alloc] initWithType:type];
}

+ (instancetype)withTypeAndId:(NSString *)type sfId:(NSString *)sfId {
    ZKSObject *s = [ZKSObject withType:type];
    s.id = sfId;
    return s;
}

+ (instancetype) fromXmlNode:(ZKElement *)node {
    return [[ZKSObject alloc] initWithXmlElement:node];
}

- (instancetype) initWithType:(NSString *)aType {
    self = [super init];    
    self.type = aType;
    self.fieldsToNullSet = [[NSMutableSet alloc] init];
    self.fieldsDict = [[NSMutableDictionary alloc] init];
    self.fieldOrder = [[NSMutableArray alloc] init];
    return self;
}

- (instancetype) initWithXmlElement:(ZKElement *)node {
    NSString *type = [[node childElement:@"type"].stringValue copy];
    self = [self initWithType:type];
    self.id = [[node childElement:@"Id"].stringValue copy];
    NSArray *children = node.childElements;
    NSUInteger childCount = children.count;
    // start at 2 to skip Id & Type
    for (NSUInteger i = 2; i < childCount; i++)
    {
        ZKElement *f = children[i];
        NSString *xsiNil = [f attributeValue:@"nil" ns:NS_URI_XSI];
        id fieldVal;
        if (xsiNil != nil && [xsiNil isEqualToString:@"true"]) 
            fieldVal = [NSNull null];
        else {
            NSString *xsiType = [f attributeValue:@"type" ns:NS_URI_XSI];
            if ([xsiType hasSuffix:@"QueryResult"]) 
                fieldVal = [[ZKQueryResult alloc] initWithXmlElement:f];
            else if ([xsiType hasSuffix:@"sObject"])
                fieldVal = [[ZKSObject alloc] initWithXmlElement:f];
            else if ([xsiType hasSuffix:@"address"])
                fieldVal = [[ZKAddress alloc] initWithXmlElement:f];
            else if ([xsiType hasSuffix:@"location"])
                fieldVal = [[ZKLocation alloc] initWithXmlElement:f];
            else
                fieldVal = f.stringValue;
        }
        [self.fieldsDict setValue:fieldVal forKey:f.name];
        [self.fieldOrder addObject:f.name];
    }
    return self;
}

-(instancetype)copyWithZone:(NSZone *)zone {
    ZKSObject *c = [[ZKSObject alloc] initWithType:self.type];
    c.id = self.id;
    c.fieldsToNullSet = self.fieldsToNull.mutableCopy;
    c.fieldsDict = self.fieldsDict.mutableCopy;
    c.fieldOrder = self.fieldOrder.mutableCopy;
    return c;
}

- (id)description {
    return [NSString stringWithFormat:@"%@ %@ fields=%@ toNull=%@", self.type,self.id, self.fieldsDict, self.fieldsToNullSet];
}

- (NSArray *)orderedFieldNames {
    return [NSArray arrayWithArray:fieldOrder];
}

- (NSDictionary *)fields {
    return self.fieldsDict;
}

- (void)setFieldToNull:(NSString *)field {
    [self.fieldsToNullSet addObject:field];
    [self.fieldsDict removeObjectForKey:field];
    [self.fieldOrder removeObject:field];
}

- (void)setFieldValue:(NSObject *)value field:(NSString *)field {
    if ((value == nil) || (value == [NSNull null]) || ([value isKindOfClass:[NSString class]] && ((NSString *)value).length == 0)) {
        [self setFieldToNull:field];
    } else {
        [self.fieldsToNullSet removeObject:field];
        self.fieldsDict[field] = value;
        if (![self.fieldOrder containsObject:field])
            [self.fieldOrder addObject:field];
    }
}

- (void)setFieldDateTimeValue:(NSDate *)value field:(NSString *)field {
    [self setFieldValue:[[ZKSoapDate instance] toDateTimeString:value] field:field];
}

- (void)setFieldDateValue:(NSDate *)value field:(NSString *)field {
    [self setFieldValue:[[ZKSoapDate instance] toDateString:value] field:field];
}    

- (id)fieldValue:(NSString *)field {
    id v = self.fieldsDict[field];
    return v == [NSNull null] ? nil : v;
}

- (BOOL)isFieldToNull:(NSString *)field {
    return [self.fieldsToNullSet containsObject:field];
}

- (BOOL)boolValue:(NSString *)field {
    return [[self fieldValue:field] isEqualToString:@"true"];
}

- (NSDate *)dateTimeValue:(NSString *)field {
    return [[ZKSoapDate instance] fromDateTimeString:[self fieldValue:field]];
}

- (NSDate *)dateValue:(NSString *)field {
    return [[ZKSoapDate instance] fromDateString:[self fieldValue:field]];
}

- (int)intValue:(NSString *)field {
    return [[self fieldValue:field] intValue];
}

- (double)doubleValue:(NSString *)field {
    return [[self fieldValue:field] doubleValue];
}

- (ZKQueryResult *)queryResultValue:(NSString *)field {
    return [self fieldValue:field];
}

- (ZKAddress *)addressValue:(NSString *)field {
    return [self fieldValue:field];
}

- (ZKLocation *)locationValue:(NSString *)field {
    return [self fieldValue:field];
}

- (NSArray *)fieldsToNull {
    return self.fieldsToNullSet.allObjects;
}

@end
