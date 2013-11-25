// Copyright (c) 2013 Simon Fell
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

#import "ZKDescribeQuickActionResult.h"
#import "ZKDescribeColor.h"
#import "ZKDescribeIcon.h"
#import "ZKDescribeLayoutSection.h"
#import "ZKDescribeQuickActionDefaultValue.h"

@implementation ZKDescribeQuickActionResult

-(NSString *)canvasApplicationName {
    return [self string:@"canvasApplicationName"];
}
			
-(NSArray *)colors {
    return [self complexTypeArrayFromElements:@"colors" cls:[ZKDescribeColor class]];
}
			
-(NSArray *)defaultValues {
    return [self complexTypeArrayFromElements:@"defaultValues" cls:[ZKDescribeQuickActionDefaultValue class]];
}
			
-(NSInteger)height {
    return [self integer:@"height"];
}
			
-(NSString *)iconName {
    return [self string:@"iconName"];
}
			
-(NSString *)iconUrl {
    return [self string:@"iconUrl"];
}
			
-(NSArray *)icons {
    return [self complexTypeArrayFromElements:@"icons" cls:[ZKDescribeIcon class]];
}
			
-(NSString *)label {
    return [self string:@"label"];
}
			
-(NSArray *)layout {
    return [self complexTypeArrayFromElements:@"layout" cls:[ZKDescribeLayoutSection class]];
}
			
-(NSString *)miniIconUrl {
    return [self string:@"miniIconUrl"];
}
			
-(NSString *)name {
    return [self string:@"name"];
}
			
-(NSString *)sourceSobjectType {
    return [self string:@"sourceSobjectType"];
}
			
-(NSString *)targetParentField {
    return [self string:@"targetParentField"];
}
			
-(NSString *)targetRecordTypeId {
    return [self string:@"targetRecordTypeId"];
}
			
-(NSString *)targetSobjectType {
    return [self string:@"targetSobjectType"];
}
			
-(NSString *)type {
    return [self string:@"type"];
}
			
-(NSString *)visualforcePageName {
    return [self string:@"visualforcePageName"];
}
			
-(NSInteger)width {
    return [self integer:@"width"];
}
			
@end
