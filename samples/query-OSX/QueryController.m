// Copyright (c) 2010,2013 Simon Fell
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

@interface QueryController ()
@property (strong) ZKSforceClient *client;
@property (strong) ZKQueryResult *result;
@end

@implementation QueryController

@synthesize username, password, client, loginInProgress, result, apiLimitInfo;


// Helper function to show an error dialog/sheet from a soap exception
-(void)showError:(NSError *)err {
    NSAlert *a = [NSAlert alertWithError:err];
    [a beginSheetModalForWindow:window completionHandler:^(NSModalResponse returnCode) {
    }];
}

-(void)updateApiLimitInfo {
    ZKLimitInfoHeader *h = client.lastLimitInfoHeader;
    ZKLimitInfo *i = [h limitInfoOfType:@"API REQUESTS"];
    if (i != nil)
        self.apiLimitInfo = i.description;
}

// run the query on a background thread, and when we get the results, update the UI (from the main thread)
-(IBAction)runQuery:(id)sender {
    NSString *query = @"select id, name from account order by SystemModStamp desc limit 20";
    [client query:query
        failBlock:^(NSError *ex) {
            [self setLoginInProgress:NO];
            [self showError:ex];
        }
    completeBlock:^(ZKQueryResult *qr) {
            self.result = qr;
            self->table.dataSource = qr;
            [self->table reloadData];
            [self setLoginInProgress:NO];
        }];
}

// Called when the user clicks the Login button, we call login, and if successful, we run the query to populate the table.
-(IBAction)performLogin:(id)sender {
    [self setLoginInProgress:YES];
    ZKSforceClient *theClient = [[ZKSforceClient alloc] init];
    theClient.delegate = self;
    [theClient login:username password:password failBlock:^(NSError *res) {
        [self setLoginInProgress:NO];
        [self showError:res];
    } completeBlock:^(ZKLoginResult *result) {
        [self willChangeValueForKey:@"isLoggedIn"];
        self.client = theClient;
        [self didChangeValueForKey:@"isLoggedIn"];
        [self runQuery:self];
    }];
}

-(IBAction)showServerTimestamp:(id)sender {
    [client getServerTimestampWithFailBlock:^(NSError *e) {
        [self showError:e];
    } completeBlock:^(ZKGetServerTimestampResult *str) {
        NSAlert *a  = [[NSAlert alloc] init];
        a.messageText = @"Server Timestamp";
        a.alertStyle = NSAlertStyleInformational;
        [a addButtonWithTitle:@"Close"];
        a.informativeText = [NSString stringWithFormat:@"Server Time : %@", str.timestamp];
        [a runModal];
    }];
}

-(void)client:(ZKBaseClient *)client
  sentRequest:(NSString *)payload
        named:(NSString *)callName
           to:(NSURL *)destination
 withResponse:(ZKElement *)response
        error:(NSError *)error
           in:(NSTimeInterval)time {

    if (error != nil) {
        NSLog(@"%@ took %f with error %@", callName, time, error);
    } else {
        NSLog(@"%@ took %f", callName, time);
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self updateApiLimitInfo];
    });
}

@end
