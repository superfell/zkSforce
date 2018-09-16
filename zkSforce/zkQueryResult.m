// Copyright (c) 2006 Simon Fell
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


#import "zkQueryResult.h"
#import "zkSObject.h"
#import "zkParser.h"

@implementation ZKQueryResult

- (instancetype)initWithXmlElement:(zkElement *)node {
    self = [super init];
    int i = 0;
    size = [node childElement:@"size"].stringValue.intValue;
    NSString * strDone = [node childElement:@"done"].stringValue; 
    done = [strDone isEqualToString:@"true"];
    if (done == NO)
        queryLocator = [[node childElement:@"queryLocator"].stringValue copy];
        
    NSArray * nodes = [node childElements:@"records"];
    NSMutableArray * recArray = [NSMutableArray arrayWithCapacity:nodes.count];
    ZKSObject * o;
    for (i = 0; i < nodes.count; i++)
    {
        zkElement * n = nodes[i];
        NSString *xsiNil = [n attributeValue:@"nil" ns:NS_URI_XSI];
        if (xsiNil != nil && [xsiNil isEqualToString:@"true"])
            continue;
        o = [[ZKSObject alloc] initWithXmlElement:n];
        [recArray addObject:o];
    }    
    records = recArray;
    return self;
}

- (instancetype)initWithRecords:(NSArray *)r size:(int)s done:(BOOL)d queryLocator:(NSString *)ql {
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

- (int)size {
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

@end
