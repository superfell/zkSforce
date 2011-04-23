//
//  OAuthDemoAppDelegate.h
//  OAuthDemo
//
//  Created by Simon Fell on 4/23/11.
//

#import <Cocoa/Cocoa.h>

@interface OAuthDemoAppDelegate : NSObject <NSApplicationDelegate> {
@private
    NSWindow *window;
}

@property (assign) IBOutlet NSWindow *window;

@end
