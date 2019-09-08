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


#import "ZKQueryResult.h"
#import "ZKSObject.h"
#import "ZKParser.h"
#import "ZKConstants.h"

@implementation ZKQueryResult

- (instancetype)initWithXmlElement:(zkElement *)node {
    self = [super init];
    size = [node childElement:@"size"].stringValue.intValue;
    NSString * strDone = [node childElement:@"done"].stringValue; 
    done = [strDone isEqualToString:@"true"];
    if (done == NO)
        queryLocator = [[node childElement:@"queryLocator"].stringValue copy];
        
    NSArray * nodes = [node childElements:@"records"];
    NSMutableArray * recArray = [NSMutableArray arrayWithCapacity:nodes.count];
    ZKSObject * o;
    for (zkElement *n in nodes) {
        NSString *xsiNil = [n attributeValue:@"nil" ns:NS_URI_XSI];
        if (xsiNil != nil && [xsiNil isEqualToString:@"true"]) {
            continue;
        }
        o = [[ZKSObject alloc] initWithXmlElement:n];
        [recArray addObject:o];
    }    
    records = recArray;
    return self;
}

- (instancetype)initWithRecords:(NSArray *)r size:(NSInteger)s done:(BOOL)d queryLocator:(NSString *)ql {
    self = [super init];
    records = r;
    done = d;
    size = s;
    queryLocator = ql;
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return [[ZKQueryResult alloc] initWithRecords:records size:size done:done queryLocator:queryLocator];
}

- (NSInteger)size {
    return size;
}

- (BOOL)done {
    return done;
}

- (NSString *)queryLocator {
    return queryLocator;
}

- (NSArray *)records {
    return records;
}

- (NSObject *)valueForFieldPath:(NSString *)path row:(NSInteger)row {
    NSArray *fieldPath = [path componentsSeparatedByString:@"."];
    NSObject *val = records[row];
    for (NSString *step in fieldPath) {
        if ([val isKindOfClass:[ZKSObject class]]) {
            val = [(ZKSObject *)val fieldValue:step];
        } else {
            val = [val valueForKey:step];
        }
    }
    return val;
}

@end
