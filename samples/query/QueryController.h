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


#import <Cocoa/Cocoa.h>

@class ZKSforceClient;
@class ZKQueryResult;

@interface QueryController : NSObject {
	IBOutlet NSWindow	 *window;
	IBOutlet NSTableView *table;

	NSString			 *username, *password;

	ZKSforceClient		 *client;
	BOOL				 loginInProgress;
	ZKQueryResult		 *result;
}

// We use binding to have the UI automatically set these when they're edited.
@property (retain) NSString *username;
@property (retain) NSString *password;
@property (assign) BOOL loginInProgress;


// The Login button in the UI is wired up to call this method
-(IBAction)performLogin:(id)sender;

@end
