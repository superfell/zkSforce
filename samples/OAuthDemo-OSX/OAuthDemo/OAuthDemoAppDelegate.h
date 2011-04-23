//
//  OAuthDemoAppDelegate.h
//  OAuthDemo
//
//  Created by Simon Fell on 4/23/11.
//

#import <Cocoa/Cocoa.h>

@class QueryController;

@interface OAuthDemoAppDelegate : NSObject <NSApplicationDelegate> {
    IBOutlet QueryController *controller;
}

-(IBAction)startLogin:(id)sender;

@end
