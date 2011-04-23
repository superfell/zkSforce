//
//  QueryController.m
//  OAuthDemo
//
//  Created by Simon Fell on 4/23/11.
//

#import "QueryController.h"
#import "zkSforceClient.h"
#import "zkQueryResult.h"
#import "zkQueryResult_NSTableView.h"

@implementation QueryController

@synthesize client, results;

// This tells KVO (and theirfore the UI binding, that the 'CanQuery' property value is affected by changes to the 'Client' property
+(NSSet *)keyPathsForValuesAffectingCanQuery {
    return [NSSet setWithObject:@"client"];
}

-(BOOL)canQuery {
    return [client loggedIn];
}

-(IBAction)runQuery:(id)sender {
    ZKQueryResult *qr = [client query:@"select id,name from account limit 25"];
    self.results = qr;
    [table setDataSource:qr];
    [table reloadData];
}

@end
