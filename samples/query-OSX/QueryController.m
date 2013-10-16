// Copyright (c) 2010 Simon Fell
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
#import "zkSforce.h"
#import "zkQueryResult+NSTableView.h"
#import "ZKLimitInfoHeader.h"

@interface QueryController ()
@property (retain) ZKSforceClient *client;
@property (retain) ZKQueryResult *result;
@end

@implementation QueryController

@synthesize username, password, client, loginInProgress, result, apiLimitInfo;

-(void)dealloc {
	[username release];
	[password release];
	[client release];
	[result release];
    [apiLimitInfo release];
	[super dealloc];
}

// Helper function to show an error dialog/sheet from a soap exception
-(void)showError:(NSException *)ex {
    NSString *txt = [ex isKindOfClass:[ZKSoapException class]] ? [(ZKSoapException *)ex faultCode] : @"Error";
	NSAlert *a = [NSAlert	alertWithMessageText:txt
							defaultButton:@"Close" 
							alternateButton:nil 
							otherButton:nil 
							informativeTextWithFormat:[ex reason]];
	[a	beginSheetModalForWindow:window 
		modalDelegate:nil 
		didEndSelector:nil 
		contextInfo:nil];
}

-(void)updateApiLimitInfo {
    ZKLimitInfoHeader *h = [client lastLimitInfoHeader];
    self.apiLimitInfo = [[h limitInfoOfType:@"API REQUESTS"] description];
}

// run the query on a background thread, and when we get the results, update the UI (from the main thread)
-(IBAction)runQuery:(id)sender {
    NSString *query = @"select id, name from account order by SystemModStamp desc limit 20";
    [client performQuery:query 
            failBlock:^(NSException *ex) {
				[self setLoginInProgress:NO];
				[self showError:ex];
            } 
            completeBlock:^(ZKQueryResult *qr) {
				[self setResult:qr];
                [self updateApiLimitInfo];
				[table setDataSource:qr];
				[table reloadData];
				[self setLoginInProgress:NO];
            }];
}

// Called when the user clicks the Login button, we call login, and if successful, we run the query to populate the table.
-(IBAction)performLogin:(id)sender {
	// zkSforceClient makes synchronous HTTP calls, you dont' really want to
	// do them on the main UI thread, so we use blocks to have the login
	// request happen on another thread, then switch back to the UI
	// thread at the end to update the UI state.
	[self setLoginInProgress:YES];
	dispatch_async ( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		ZKSforceClient *theClient = [[[ZKSforceClient alloc] init] autorelease];
		@try {
			[theClient login:username password:password];
			dispatch_async(dispatch_get_main_queue(), ^{
				[self willChangeValueForKey:@"isLoggedIn"];
				[self setClient:theClient];
				[self didChangeValueForKey:@"isLoggedIn"];
                [self updateApiLimitInfo];
				[self runQuery:self];
			});
		} @catch (ZKSoapException *ex) {
			dispatch_async(dispatch_get_main_queue(), ^{
				[self setLoginInProgress:NO];
				[self showError:ex];
			});
		}
	});
}

-(IBAction)showServerTimestamp:(id)sender {
    [client performServerTimestampWithFailBlock:^(NSException *e) {
        NSLog(@"Error fetching timestamp : %@", e);
    } completeBlock:^(NSString *str) {
        [self updateApiLimitInfo];
        [[NSAlert alertWithMessageText:@"Server Timestamp"
                         defaultButton:@"Close"
                       alternateButton:nil
                           otherButton:nil
             informativeTextWithFormat:@"Server Time : %@", str] runModal];
    }];
}
@end
