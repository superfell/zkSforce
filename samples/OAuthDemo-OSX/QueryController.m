// Copyright (c) 2011 Simon Fell
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

#import "QueryController.h"
#import "zkSforceClient.h"
#import "zkQueryResult.h"
#import "zkQueryResult_NSTableView.h"
#import "zkAuthentication.h"

@implementation QueryController

@synthesize results, client;

// This tells KVO (and theirfore the UI binding, that the 'CanQuery' property value is affected by changes to the 'Client' property
+(NSSet *)keyPathsForValuesAffectingCanQuery {
    return [NSSet setWithObject:@"client"];
}

-(BOOL)canQuery {
    return [client loggedIn];
}

-(IBAction)runQuery:(id)sender {
    ZKQueryResult *qr = [client query:@"select id,name from account limit 25"];
    self.results = qr;
    [table setDataSource:qr];
    [table reloadData];
}

-(IBAction)refreshSid:(id)sender {
    // normally you wouldn't need to do this, but its handy to see how it works.
    [[client authenticationInfo] refresh];
}


@end
