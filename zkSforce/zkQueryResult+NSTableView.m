// Copyright (c) 2006-2010 Simon Fell
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

#import "zkQueryResult+NSTableView.h"
#import "ZKSObject.h"

// Only build on OSX
#ifdef __MAC_OS_X_VERSION_MAX_ALLOWED

@implementation ZKQueryResult (NSTableViewAdditions)

- (NSUInteger)numberOfRowsInTableView:(NSTableView *)v {
	return [records count];
}

- (id)tableView:(NSTableView *)view objectValueForTableColumn:(NSTableColumn *)tc row:(int)rowIdx {
	NSArray *path = [[tc identifier] componentsSeparatedByString:@"."];
	NSObject *val = [records objectAtIndex:rowIdx];
	for (NSString *step in path) {
        if ([val isKindOfClass:[ZKSObject class]]) {
            val = [(ZKSObject *)val fieldValue:step];
        } else {
            val = [val valueForKey:step];
        }
    }
	return val;
}

@end

#endif