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

#import "iOSQueryDemoAppDelegate.h"
#import "zkSforceClient.h"
#import "RootViewController.h"

@implementation iOSQueryDemoAppDelegate

@synthesize window=_window;
@synthesize navigationController=_navigationController;

static NSString *OAUTH_CLIENTID = @"3MVG99OxTyEMCQ3hP1_9.Mh8dF9TWo9xz6pJ7Hn_6m5irZ1id.xk4XR89yKEuRufdqMbJuBobXTVOqnD0xri_";
static NSString *OAUTH_CALLBACK = @"compocketsoapoauthdemo:///done";

// Build the URL to start the oauth flow, and launch it in a browser.
-(IBAction)startLogin:(id)sender {
    NSString *login = [NSString stringWithFormat:@"https://login.salesforce.com/services/oauth2/authorize?display=touch&response_type=token&client_id=%@&redirect_uri=%@", 
                       [OAUTH_CLIENTID stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                       [OAUTH_CALLBACK stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:login]];
}

// When the oauth flow completes, this will get called.
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    NSString *u = [url absoluteString];
    if (![u hasPrefix:OAUTH_CALLBACK]) return FALSE;

    // In a real app, at this point you'd save the refresh_token & authHost to the keychain
    // and on restart, initialize your client from that instead of doing the login flow again.
    
    ZKSforceClient *client = [[ZKSforceClient alloc] init];
    [client loginFromOAuthCallbackUrl:u oAuthConsumerKey:OAUTH_CLIENTID];
    ((RootViewController *)self.navigationController.topViewController).client =client;
    return TRUE;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // Add the navigation controller's view to the window and display.
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc {
    [_window release];
    [_navigationController release];
    [super dealloc];
}

@end
