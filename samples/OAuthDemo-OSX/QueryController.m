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
#import "ZKSforce.h"

@interface SObjectList : NSObject<NSTableViewDataSource>
@property NSArray *sobjects;
@end

@implementation SObjectList
@synthesize sobjects;

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return sobjects.count;
}

-(nullable id)tableView:(NSTableView *)tableView objectValueForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row {
    ZKDescribeGlobalSObject *o = sobjects[row];
    return o.name;
}

@end

@implementation QueryController

@synthesize results, client, sobjects;

// This tells KVO (and theirfore the UI binding, that the 'CanQuery' property value is affected by changes to the 'Client' property
+(NSSet *)keyPathsForValuesAffectingCanQuery {
    return [NSSet setWithObject:@"client"];
}

-(BOOL)canQuery {
    return client.loggedIn;
}

-(IBAction)runQuery:(id)sender {
    [client query:@"select id,name from account limit 25"
        failBlock:^(NSError *err) {
               [[NSAlert alertWithError:err] runModal];
           }
    completeBlock:^(ZKQueryResult *qr) {
               self.results = qr;
               self->queryTable.dataSource = qr;
               [self->queryTable reloadData];
           }];
}

-(void)runDescGlobal:(id)sender {
    [client describeGlobalWithFailBlock:^(NSError *result) {
        [[NSAlert alertWithError:result] runModal];
    } completeBlock:^(NSArray *result) {
        SObjectList *l = [[SObjectList alloc] init];
        l.sobjects = result;
        self.sobjects = l;
        self->objectList.dataSource = l;
    }];
}

-(IBAction)refreshSid:(id)sender {
    // normally you wouldn't need to do this, but its handy to see how it works.
    [client.authenticationInfo refresh:^(NSError *err) {
        if (err != nil) {
            [[NSAlert alertWithError:err] runModal];
            return;
        }
        NSLog(@"SID Refreshed, now %@", self.client.sessionId);
    }];
}

-(void)setClient:(ZKSforceClient *)c {
    self->client = c;
    [self runQuery:self];
    [self runDescGlobal:self];
}


@end
