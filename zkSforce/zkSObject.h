// Copyright (c) 2006-2014,2018 Simon Fell
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

#import "zkXmlDeserializer.h"

@class zkElement;
@class ZKQueryResult;
@class ZKAddress;
@class ZKLocation;

/** ZKSObject represents a row of data in Salesforce [either already in salesforce, or one we're in
    the process of constructing to be sent to Salesforce */
@interface ZKSObject : NSObject {
}

+ (instancetype) withType:(NSString *)type;
+ (instancetype) withTypeAndId:(NSString *)type sfId:(NSString *)sfId;
+ (instancetype) fromXmlNode:(zkElement *)node;

- (instancetype) init NS_UNAVAILABLE;
- (instancetype) initWithXmlElement:(zkElement *)node;
- (instancetype) initWithType:(NSString *)type NS_DESIGNATED_INITIALIZER;
- (instancetype) copyWithZone:(NSZone *)zone;

// setters

// setting a fieldValue to nil will automatically put it in the fieldsToNull collection
// setting a fieldValue to non nil will automatically remove it from the fieldsToNull collection
- (void)setFieldValue:(NSObject *)value field:(NSString *)field;
- (void)setFieldDateTimeValue:(NSDate *)value field:(NSString *)field;
- (void)setFieldDateValue:(NSDate *)value field:(NSString *)field;
- (void)setFieldToNull:(NSString *)field;

// basic getters
@property (NS_NONATOMIC_IOSONLY, strong) NSString *id;
@property (NS_NONATOMIC_IOSONLY, strong) NSString *type;
@property (NS_NONATOMIC_IOSONLY, readonly, strong) NSArray *fieldsToNull;
@property (NS_NONATOMIC_IOSONLY, readonly, strong) NSDictionary *fields;

- (id)fieldValue:(NSString *)field;
- (BOOL)isFieldToNull:(NSString *)field;

// typed getters
- (BOOL)boolValue:(NSString *)field;
- (NSDate *)dateTimeValue:(NSString *)field;
- (NSDate *)dateValue:(NSString *)field;
- (int)intValue:(NSString *)field;
- (double)doubleValue:(NSString *)field;

- (ZKQueryResult *)queryResultValue:(NSString *)field;
- (ZKAddress *)addressValue:(NSString *)field;
- (ZKLocation *)locationValue:(NSString *)field;

// others
@property (NS_NONATOMIC_IOSONLY, readonly, strong) NSArray *orderedFieldNames;

@end
