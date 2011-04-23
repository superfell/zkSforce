//
//  OAuthDemoAppDelegate.m
//  OAuthDemo
//
//  Created by Simon Fell on 4/23/11.
//

#import "OAuthDemoAppDelegate.h"

static NSString *OAUTH_CLIENTID = @"3MVG99OxTyEMCQ3hP1_9.Mh8dF9TWo9xz6pJ7Hn_6m5irZ1id.xk4XR89yKEuRufdqMbJuBobXTVOqnD0xri_";
static NSString *OAUTH_CALLBCAK = @"compocketsoapoauthdemo:///done";

@implementation OAuthDemoAppDelegate
@synthesize window;

-(void)startLogin {
    NSString *login = [NSString stringWithFormat:@"https://login.salesforce.com/services/oauth2/authorize?response_type=token&client_id=%@&redirect_uri=%@",
                       [OAUTH_CLIENTID stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                       [OAUTH_CALLBCAK stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURL *url = [NSURL URLWithString:login];
    
    [[NSWorkspace sharedWorkspace] openURL:url];
}

-(void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [[NSAppleEventManager sharedAppleEventManager] setEventHandler:self andSelector:@selector(getUrl:withReplyEvent:) forEventClass:kInternetEventClass andEventID:kAEGetURL];
    [self startLogin];
}

- (void)getUrl:(NSAppleEventDescriptor *)event withReplyEvent:(NSAppleEventDescriptor *)replyEvent
{
	NSString *url = [[event paramDescriptorForKeyword:keyDirectObject] stringValue];
	// Now you can parse the URL and perform whatever action is needed
    NSLog(@"got oauth callback : %@", url);
}
@end
