// Copyright (c) 2010 Ron Hess
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

#import "ZKRelatedList.h"
#import "ZKRelatedListColumn.h"
#import "ZKRelatedListSort.h"

@implementation ZKRelatedList

-(NSArray *)columns {
    return [self complexTypeArrayFromElements:@"columns" cls:[ZKRelatedListColumn class]];
}
			
-(BOOL)custom {
    return [self boolean:@"custom"];
}
			
-(NSString *)field {
    return [self string:@"field"];
}
			
-(NSString *)label {
    return [self string:@"label"];
}
			
-(NSInteger)limitRows {
    return [self integer:@"limitRows"];
}
			
-(NSString *)name {
    return [self string:@"name"];
}
			
-(NSString *)sobject {
    return [self string:@"sobject"];
}
			
-(NSArray *)sort {
    return [self complexTypeArrayFromElements:@"sort" cls:[ZKRelatedListSort class]];
}
			
@end
