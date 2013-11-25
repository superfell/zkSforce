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

#import "ZKDescribeSObjectResult.h"
#import "ZKChildRelationship.h"
#import "ZKDescribeField.h"
#import "ZKRecordTypeInfo.h"

@implementation ZKDescribeSObjectResult

-(BOOL)activateable {
    return [self boolean:@"activateable"];
}
			
-(NSArray *)childRelationships {
    return [self complexTypeArrayFromElements:@"childRelationships" cls:[ZKChildRelationship class]];
}
			
-(BOOL)compactLayoutable {
    return [self boolean:@"compactLayoutable"];
}
			
-(BOOL)createable {
    return [self boolean:@"createable"];
}
			
-(BOOL)custom {
    return [self boolean:@"custom"];
}
			
-(BOOL)customSetting {
    return [self boolean:@"customSetting"];
}
			
-(BOOL)deletable {
    return [self boolean:@"deletable"];
}
			
-(BOOL)deprecatedAndHidden {
    return [self boolean:@"deprecatedAndHidden"];
}
			
-(BOOL)feedEnabled {
    return [self boolean:@"feedEnabled"];
}
			
-(NSArray *)fields {
    return [self complexTypeArrayFromElements:@"fields" cls:[ZKDescribeField class]];
}
			
-(NSString *)keyPrefix {
    return [self string:@"keyPrefix"];
}
			
-(NSString *)label {
    return [self string:@"label"];
}
			
-(NSString *)labelPlural {
    return [self string:@"labelPlural"];
}
			
-(BOOL)layoutable {
    return [self boolean:@"layoutable"];
}
			
-(BOOL)mergeable {
    return [self boolean:@"mergeable"];
}
			
-(NSString *)name {
    return [self string:@"name"];
}
			
-(BOOL)queryable {
    return [self boolean:@"queryable"];
}
			
-(NSArray *)recordTypeInfos {
    return [self complexTypeArrayFromElements:@"recordTypeInfos" cls:[ZKRecordTypeInfo class]];
}
			
-(BOOL)replicateable {
    return [self boolean:@"replicateable"];
}
			
-(BOOL)retrieveable {
    return [self boolean:@"retrieveable"];
}
			
-(BOOL)searchLayoutable {
    return [self boolean:@"searchLayoutable"];
}
			
-(BOOL)searchable {
    return [self boolean:@"searchable"];
}
			
-(BOOL)triggerable {
    return [self boolean:@"triggerable"];
}
			
-(BOOL)undeletable {
    return [self boolean:@"undeletable"];
}
			
-(BOOL)updateable {
    return [self boolean:@"updateable"];
}
			
-(NSString *)urlDetail {
    return [self string:@"urlDetail"];
}
			
-(NSString *)urlEdit {
    return [self string:@"urlEdit"];
}
			
-(NSString *)urlNew {
    return [self string:@"urlNew"];
}
			
@end
