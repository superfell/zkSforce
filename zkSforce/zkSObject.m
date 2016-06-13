// Copyright (c) 2006,2014 Simon Fell
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


#import "zkSObject.h"
#import "zkQueryResult.h"
#import "zkParser.h"
#import "ZKSoapDate.h"
#import "ZKAddress.h"

@implementation ZKSObject

+ (id)withType:(NSString *)type {
	return [[[ZKSObject alloc] initWithType:type] autorelease];
}

+ (id)withTypeAndId:(NSString *)type sfId:(NSString *)sfId {
	ZKSObject *s = [ZKSObject withType:type];
	[s setId:sfId];
	return s;
}

+ (id) fromXmlNode:(zkElement *)node {
	return [[[ZKSObject alloc] initWithXmlElement:node] autorelease];
}

- (id) initWithType:(NSString *)aType {
	self = [super init];	
	type = [aType retain];
	fieldsToNull = [[NSMutableSet alloc] init];
	fields = [[NSMutableDictionary alloc] init];
	fieldOrder = [[NSMutableArray alloc] init];
	return self;
}

- (id) initWithXmlElement:(zkElement *)node {
	self = [super init];
	NSUInteger i, childCount;
	Id = [[[node childElement:@"Id"] stringValue] copy];
	type = [[[node childElement:@"type"] stringValue] copy];
	fields = [[NSMutableDictionary alloc] init];
	fieldOrder = [[NSMutableArray alloc] init];
	fieldsToNull = [[NSMutableSet alloc] init];
	NSArray *children = [node childElements];
	childCount = [children count];
	// start at 2 to skip Id & Type
	for (i = 2; i < childCount; i++)
	{
		zkElement *f = [children objectAtIndex:i];
		NSString *xsiNil = [f attributeValue:@"nil" ns:NS_URI_XSI];
		id fieldVal;
		if (xsiNil != nil && [xsiNil isEqualToString:@"true"]) 
			fieldVal = [NSNull null];
		else {
			NSString *xsiType = [f attributeValue:@"type" ns:NS_URI_XSI];
			if ([xsiType hasSuffix:@"QueryResult"]) 
				fieldVal = [[[ZKQueryResult alloc] initWithXmlElement:f] autorelease];
			else if ([xsiType hasSuffix:@"sObject"])
				fieldVal = [[[ZKSObject alloc] initWithXmlElement:f] autorelease];
            else if ([xsiType hasSuffix:@"address"])
                fieldVal = [[[ZKAddress alloc] initWithXmlElement:f] autorelease];
            else if ([xsiType hasSuffix:@"location"])
                fieldVal = [[[ZKLocation alloc] initWithXmlElement:f] autorelease];
			else
				fieldVal = [f stringValue];
		}
		[fields setValue:fieldVal forKey:[f name]];
		[fieldOrder addObject:[f name]];
	}
	return self;
}

-(id)initWithId:(NSString *)anId type:(NSString *)t fieldsToNull:(NSSet *)ftn fields:(NSDictionary *)f fieldOrder:(NSArray *)fo {
	self = [super init];
	Id = [anId copy];
	type = [t copy];
	fieldsToNull = [[NSMutableSet setWithSet:ftn] retain];
	fields = [[NSMutableDictionary dictionaryWithDictionary:f] retain];
	fieldOrder = [[NSMutableArray arrayWithArray:fo] retain];
	return self;
}

-(id)copyWithZone:(NSZone *)zone {
	return [[ZKSObject alloc] initWithId:Id type:type fieldsToNull:fieldsToNull fields:fields fieldOrder:fieldOrder];
}

- (void)dealloc {
	[Id release];
	[type release];
	[fieldsToNull release];
	[fields release];
	[fieldOrder release];
	[super dealloc];
}

- (id)description {
	return [NSString stringWithFormat:@"%@ %@ fields=%@ toNull=%@", type, Id, fields, fieldsToNull];
}

- (NSArray *)orderedFieldNames {
	return fieldOrder;
}

- (void)setId:(NSString *)theId {
	[Id autorelease];
	Id = [theId retain];
}

- (void)setType:(NSString *)t {
	[type autorelease];
	type = [t retain];
}

- (void)setFieldToNull:(NSString *)field {
	[fieldsToNull addObject:field];
	[fields removeObjectForKey:field];
	[fieldOrder removeObject:field];
}

- (void)setFieldValue:(NSObject *)value field:(NSString *)field {
	if ((value == nil) || (value == [NSNull null]) || ([value isKindOfClass:[NSString class]] && [(NSString *)value length] == 0)) {
		[self setFieldToNull:field];
	} else {
		[fieldsToNull removeObject:field];
		[fields setObject:value forKey:field];
		if (![fieldOrder containsObject:field])
			[fieldOrder addObject:field];
	}
}

- (void)setFieldDateTimeValue:(NSDate *)value field:(NSString *)field {
    [self setFieldValue:[[ZKSoapDate instance] toDateTimeString:value] field:field];
}

- (void)setFieldDateValue:(NSDate *)value field:(NSString *)field {
	[self setFieldValue:[[ZKSoapDate instance] toDateString:value] field:field];
}	

- (id)fieldValue:(NSString *)field {
	id v = [fields objectForKey:field];
	return v == [NSNull null] ? nil : v;
}

- (BOOL)isFieldToNull:(NSString *)field {
	return [fieldsToNull containsObject:field];
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

- (NSString *)id {
	return Id;
}

- (NSString *)type {
	return type;
}

- (NSArray *)fieldsToNull {
	return [fieldsToNull allObjects];
}

- (NSDictionary *)fields {
	return fields;
}

@end
