// Copyright (c) 2006-2014,2018,2020 Simon Fell
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

@class ZKElement;
@class ZKQueryResult;
@class ZKAddress;
@class ZKLocation;
@class ZKDescribeSObject;

/** ZKSObject represents a row of data in Salesforce [either already in salesforce, or one we're in
    the process of constructing to be sent to Salesforce */
@interface ZKSObject : NSObject {
}

+ (instancetype) withType:(NSString *)type;
+ (instancetype) withTypeAndId:(NSString *)type sfId:(NSString *)sfId;
+ (instancetype) fromXmlNode:(ZKElement *)node;

- (instancetype) init NS_UNAVAILABLE;
- (instancetype) initWithXmlElement:(ZKElement *)node;
- (instancetype) initWithType:(NSString *)type NS_DESIGNATED_INITIALIZER;
- (instancetype) copyWithZone:(NSZone *)zone;

// setters

// setting a fieldValue to nil will automatically put it in the fieldsToNull collection
// setting a fieldValue to non nil will automatically remove it from the fieldsToNull collection
- (void)setFieldValue:(NSObject *)value field:(NSString *)field;
- (void)setFieldDateTimeValue:(NSDate *)value field:(NSString *)field;
- (void)setFieldDateValue:(NSDate *)value field:(NSString *)field;
- (void)setFieldTimeValue:(NSDate *)value field:(NSString *)field;
- (void)setFieldToNull:(NSString *)field;

// basic getters
@property (strong) NSString *id;
@property (strong) NSString *type;
@property (readonly, strong) NSArray *fieldsToNull;
@property (readonly, strong) NSDictionary *fields;

- (id)fieldValue:(NSString *)field;
- (BOOL)isFieldToNull:(NSString *)field;

// typed getters

/** Returns a strongly typed instance of the named field, using the field type from the describe if needed.
    The typed instances are created on demand and cached, so repeatedly asking for the same field value will
    get you the same object instance. If the type is not resolvable, then you'll get the string value for primitives.
 */
- (id)typedValueOfField:(NSString *)field withDescribe:(ZKDescribeSObject*)desc;

- (BOOL)boolValue:(NSString *)field;
- (NSDate *)dateTimeValue:(NSString *)field;
- (NSDate *)dateValue:(NSString *)field;
- (NSDate *)timeValue:(NSString *)field;
- (long long)intValue:(NSString *)field;
- (float)floatValue:(NSString *)field;
- (double)doubleValue:(NSString *)field;

- (ZKQueryResult *)queryResultValue:(NSString *)field;
- (ZKAddress *)addressValue:(NSString *)field;
- (ZKLocation *)locationValue:(NSString *)field;

// others
@property (readonly) NSArray *orderedFieldNames;

/** returns true if there is a value for this field. Includes fields that were marked as xsi:nil by the server. */
- (BOOL)containsField:(NSString *)field;

/** returns the xml type of the named field if it was specified in the object sent from the server. */
- (NSString*)typeOfField:(NSString *)field;

/** returns the xml type of the named field, falling back to the metadata from the describe if its available.*/
- (NSString*)typeOfField:(NSString *)field withDescribe:(ZKDescribeSObject*)desc;

@end
