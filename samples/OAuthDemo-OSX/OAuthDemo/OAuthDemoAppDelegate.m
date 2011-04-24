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

#import "OAuthDemoAppDelegate.h"
#import "zkSforceClient.h"
#import "QueryController.h"

static NSString *OAUTH_CLIENTID = @"3MVG99OxTyEMCQ3hP1_9.Mh8dF9TWo9xz6pJ7Hn_6m5irZ1id.xk4XR89yKEuRufdqMbJuBobXTVOqnD0xri_";
static NSString *OAUTH_CALLBACK = @"compocketsoapoauthdemo:///done";

@implementation OAuthDemoAppDelegate

-(IBAction)startLogin:(id)sender {
    // build the URL to the oauth page with our client_id & callback URL set.
    NSString *login = [NSString stringWithFormat:@"https://login.salesforce.com/services/oauth2/authorize?response_type=token&client_id=%@&redirect_uri=%@",
                       [OAUTH_CLIENTID stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                       [OAUTH_CALLBACK stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURL *url = [NSURL URLWithString:login];

    // ask the OS to open browser to the URL
    [[NSWorkspace sharedWorkspace] openURL:url];
}

-(void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // tell the event manager what to do when it gets asked to open a URL (the oauth completion callback) 
    // this callback URL is registered to this app in the info.plist file
    [[NSAppleEventManager sharedAppleEventManager] setEventHandler:self 
                                                   andSelector:@selector(getUrl:withReplyEvent:) 
                                                   forEventClass:kInternetEventClass 
                                                   andEventID:kAEGetURL];
}

- (void)getUrl:(NSAppleEventDescriptor *)event withReplyEvent:(NSAppleEventDescriptor *)replyEvent {
	NSString *url = [[event paramDescriptorForKeyword:keyDirectObject] stringValue];

	// Now you can parse the URL and perform whatever action is needed
    
    ZKSforceClient *client = [[[ZKSforceClient alloc] init] autorelease];
    [client loginFromOAuthCallbackUrl:url oAuthConsumerKey:OAUTH_CLIENTID];

    // in a real app, you'd save the refresh_token & auth host to the keychain, and on
    // relaunch, try and intialize your client from that first, so that you can skip
    // the login step.
    
    [controller setClient:client];
}


-(IBAction)createNewClient:(id)sender {
    // if you've saved the refresh token & auth host away, you can
    // build a new client from that, and it'll get a sessionId as needed.

    // in this case we're just going to get the token out of the existing client object, 
    // normally, you'd be storing this in the key chain so that is preserved across restarts.
    ZKOAuthInfo *oauth = (ZKOAuthInfo *)[[controller client] authenticationInfo];
    NSString *refreshToken = [oauth refreshToken];
    NSURL *authHost = [oauth authHostUrl];
    
    ZKSforceClient *c = [[[ZKSforceClient alloc] init] autorelease];
    [c loginWithRefreshToken:refreshToken authUrl:authHost oAuthConsumerKey:OAUTH_CLIENTID];
    [controller setClient:c];
}


@end
