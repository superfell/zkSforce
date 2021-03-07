// Copyright (c) 2006,2014,2018,2020 Simon Fell
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
#import "ZKDescribeSObject+Extras.h"
#import "ZKDescribeField.h"
#import "ZKSimpleTypes.h"

@interface ZKSObject()
@property (strong) NSMutableSet<NSString*> *fieldsToNullSet;
@property (strong) NSMutableDictionary<NSString*,NSObject*> *fieldsDict;
@property (strong) NSMutableArray<NSString*> *fieldOrder;
@property (strong) NSMutableDictionary<NSString*,NSString*> *fieldTypes;
@property (strong) NSMutableDictionary<NSString*,NSObject*> *typedValues;
@end

@implementation ZKSObject

+(void)load {
    [ZKXmlDeserializer registerType:self xmlName:@"sObject"];
}

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
    self.fieldTypes = [[NSMutableDictionary alloc] init];
    NSArray *children = node.childElements;
    NSUInteger childCount = children.count;
    // start at 2 to skip Id & Type
    for (NSUInteger i = 2; i < childCount; i++) {
        ZKElement *f = children[i];
        id fieldVal = nil;
        if (f.isXsiNil) {
            fieldVal = [NSNull null];
        } else {
            NSString *xsiType = [f attributeValue:@"type" ns:NS_URI_XSI];
            if (xsiType != nil) {
                self.fieldTypes[f.name] = xsiType;
                NSString *localName = [self localName:xsiType];
                NSObject<ZKXmlInitable> *registeredType = [ZKXmlDeserializer instanceOfXmlType:localName];
                if (registeredType != nil) {
                    fieldVal = [registeredType initWithXmlElement:f];
                }
            }
            if (fieldVal == nil) {
                fieldVal = f.stringValue;
            }
        }
        self.fieldsDict[f.name] = fieldVal;
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
    c.fieldTypes = self.fieldTypes.mutableCopy;
    // typedValues is a cache, no need to copy it over.
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
    [self.fieldTypes removeObjectForKey:field];
    [self.typedValues removeObjectForKey:field];
}

- (void)setFieldValue:(NSObject *)value field:(NSString *)field {
    if ((value == nil) || (value == [NSNull null]) || ([value isKindOfClass:[NSString class]] && ((NSString *)value).length == 0)) {
        [self setFieldToNull:field];
    } else {
        [self.fieldsToNullSet removeObject:field];
        self.fieldsDict[field] = value;
        if (![self.fieldOrder containsObject:field])
            [self.fieldOrder addObject:field];
        [self.typedValues removeObjectForKey:field];
    }
}

- (void)setFieldDateTimeValue:(NSDate *)value field:(NSString *)field {
    [self setFieldValue:[[ZKSoapDate instance] toDateTimeString:value] field:field];
}

- (void)setFieldDateValue:(NSDate *)value field:(NSString *)field {
    [self setFieldValue:[[ZKSoapDate instance] toDateString:value] field:field];
}

- (void)setFieldTimeValue:(NSDate *)value field:(NSString *)field {
    [self setFieldValue:[[ZKSoapDate instance] toTimeString:value] field:field];
}

- (BOOL)containsField:(NSString *)field {
    return self.fieldsDict[field] != nil;
}

- (id)fieldValue:(NSString *)field {
    id v = self.fieldsDict[field];
    return v == [NSNull null] ? nil : v;
}

- (BOOL)isFieldToNull:(NSString *)field {
    return [self.fieldsToNullSet containsObject:field];
}

- (BOOL)boolValue:(NSString *)field {
    return [[[self fieldValue:field] ZKBoolean] boolValue];
}

- (NSDate *)dateTimeValue:(NSString *)field {
    return [[self fieldValue:field] ZKDateTime];
}

- (NSDate *)dateValue:(NSString *)field {
    return [[self fieldValue:field] ZKDate];
}

- (NSDate *)timeValue:(NSString *)field {
    return [[self fieldValue:field] ZKTime];
}

- (long long)intValue:(NSString *)field {
    return [[[self fieldValue:field] ZKInteger] longLongValue];
}

- (float)floatValue:(NSString *)field {
    return [[[self fieldValue:field] ZKFloat] floatValue];
}

- (double)doubleValue:(NSString *)field {
    return [[[self fieldValue:field] ZKDouble] doubleValue];
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

- (NSString *)typeOfField:(NSString *)field {
    return self.fieldTypes[field];
}

- (NSString *)typeOfField:(NSString *)field withDescribe:(ZKDescribeSObject*)desc {
    NSString *t = self.fieldTypes[field];
    if (t != nil) {
        return t;
    }
    return [[desc fieldWithName:field] soapType];
}

- (id)typedValueOfField:(NSString *)field withDescribe:(ZKDescribeSObject*)desc {
    id tv = self.typedValues[field];
    if (tv != nil) {
        return tv;
    }
    NSObject *fv = [self fieldValue:field];
    if ([fv isKindOfClass:[NSString class]]) {
        NSString *xmlTypeLocalName = [self localName:[self typeOfField:field withDescribe:desc]];
        tv = [(NSString*)fv ZKAsXmlType:xmlTypeLocalName];
        if (self.typedValues == nil) {
            self.typedValues = [[NSMutableDictionary alloc] init];
        }
        self.typedValues[field] = tv;
        return tv;
    }
    return fv;
}

-(NSString *)localName:(NSString *)qname {
    NSRange pos = [qname rangeOfString:@":"];
    if (pos.length == 0) {
        return qname;
    }
    return [qname substringFromIndex:pos.location+1];
}

@end
