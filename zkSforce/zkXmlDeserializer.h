// Copyright (c) 2006,2013,2014,2016 Simon Fell
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


@class zkElement;
@class ZKSObject;
@class ZKQueryResult;
@class ZKNamespacedName;
@class ZKXsdAnyType;

@interface ZKXmlDeserializer : NSObject<NSCopying> {
	zkElement *node;
	NSMutableDictionary *values;
}
- (id)initWithXmlElement:(zkElement *)e;

- (NSString *)string:(NSString *)elem;
- (BOOL)boolean:(NSString *)elem;
- (int)integer:(NSString *)elem;
- (double)double:(NSString *)elem;
- (NSArray *)strings:(NSString *)elem;
- (NSData *)blob:(NSString *)elem;
- (NSDate *)date:(NSString *)elem;
- (NSDate *)time:(NSString *)elem;
- (NSDate *)dateTime:(NSString *)elem;
- (ZKSObject *)sObject:(NSString *)elem;
- (ZKQueryResult *)queryResult:(NSString *)elem;
- (ZKXsdAnyType *)anyType:(NSString *)elem;

- (NSString *)string:(NSString *)elemName fromXmlElement:(zkElement*)xmlElement;
- (NSArray *)complexTypeArrayFromElements:(NSString *)elemName cls:(Class)type;
- (Class) complexTypeClassForType:(ZKNamespacedName *)xsiType baseClass:(Class)base;

@end
