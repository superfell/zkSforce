// Copyright (c) 2006,2018 Simon Fell
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

@class ZKElement;

@interface ZKQueryResult : NSObject <NSCopying> {
    NSInteger   size;
    BOOL        done;
    NSString    *queryLocator;
    NSArray     *records;
}

- (instancetype)initWithXmlElement:(ZKElement *)node NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithRecords:(NSArray *)records size:(NSInteger)s done:(BOOL)d queryLocator:(NSString *)ql NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

/** @return the total size of the query results [if this is larger than one page, this is only a hint] */
@property (readonly) NSInteger size;

/** @return true if this is the last page of results for this query, or false if there are more pages available via QueryMore */
@property (readonly) BOOL done;

/** @return a queryLocator that can be used with QueryMore to fetch the next page of results */
@property (readonly, strong) NSString *queryLocator;

/** @return the query result records that are in this page of results */
@property (readonly, strong) NSArray *records;

/** @return the value for a dotted path of field name at a particular index in records. e.g. valueForFieldPath:@"Contact.Name" row:0 */
- (NSObject *)valueForFieldPath:(NSString *)path row:(NSInteger)row;

@end
