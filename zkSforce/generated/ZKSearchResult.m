// Copyright (c) 2013 Simon Fell
//
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the "Software"),
// to deal in the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following conditions
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
// 
// Note: This file was generated by WSDL2ZKSforce.
//		  see https://github.com/superfell/WSDL2ZKSforce
//       DO NOT HAND EDIT.
//

#import "ZKSearchResult.h"
#import "ZKEnvelope.h"
#import "ZKSearchRecord.h"
#import "ZKSearchResultsMetadata.h"

@interface ZKSearchResult()
@property (strong,nonatomic) NSString                 *queryId__v;
@property (strong,nonatomic) NSArray                  *searchRecords__v;
@property (strong,nonatomic) ZKSearchResultsMetadata  *searchResultsMetadata__v;
@end

@implementation ZKSearchResult


+(void)load {
    [self registerType:self xmlName:@"SearchResult"];
}

-(NSString *)queryId {
    if ((fields__set[0] & 0x1) == 0) {
        self.queryId__v = [self string:@"queryId"];
        fields__set[0] |= 0x1; 
    }
    return self.queryId__v;
}
        

-(void)setQueryId:(NSString *)v {
    self.queryId__v = v;
    fields__set[0] |= 0x1; 
}
        

-(NSArray *)searchRecords {
    if ((fields__set[0] & 0x2) == 0) {
        self.searchRecords__v = [self complexTypeArrayFromElements:@"searchRecords" cls:[ZKSearchRecord class]];
        fields__set[0] |= 0x2; 
    }
    return self.searchRecords__v;
}
        

-(void)setSearchRecords:(NSArray *)v {
    self.searchRecords__v = v;
    fields__set[0] |= 0x2; 
}
        

-(ZKSearchResultsMetadata *)searchResultsMetadata {
    if ((fields__set[0] & 0x4) == 0) {
        self.searchResultsMetadata__v = [self complexTypeArrayFromElements:@"searchResultsMetadata" cls:[ZKSearchResultsMetadata class]].lastObject;
        fields__set[0] |= 0x4; 
    }
    return self.searchResultsMetadata__v;
}
        

-(void)setSearchResultsMetadata:(ZKSearchResultsMetadata *)v {
    self.searchResultsMetadata__v = v;
    fields__set[0] |= 0x4; 
}
        
-(void)serializeTo:(ZKXmlWriter *)env elemName:(NSString *)elemName {
	[env startElement:elemName];
	[env addElement:@"queryId"               elemValue:self.queryId               nillable:NO  optional:NO];
	[env addElementArray:@"searchRecords"    elemValue:self.searchRecords];
	[env addElement:@"searchResultsMetadata" elemValue:self.searchResultsMetadata nillable:YES optional:YES];
	[env endElement:elemName];
}
@end
