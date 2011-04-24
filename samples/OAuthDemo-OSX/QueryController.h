//
//  QueryController.h
//  OAuthDemo
//
//  Created by Simon Fell on 4/23/11.
//

#import <Foundation/Foundation.h>

@class ZKSforceClient;
@class ZKQueryResult;

@interface QueryController : NSObject {
    ZKSforceClient       *client;
    IBOutlet NSTableView *table;
    
    ZKQueryResult       *results;
    NSString            *lastSid;
}

@property (nonatomic, retain) ZKSforceClient *client;
@property (readonly) BOOL canQuery;
@property (retain) ZKQueryResult *results;
@property (retain) NSString *lastSid;

-(IBAction)runQuery:(id)sender;
-(IBAction)refreshSid:(id)sender;

@end
