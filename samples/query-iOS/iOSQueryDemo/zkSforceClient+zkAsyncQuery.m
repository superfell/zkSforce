//
//  zkSforceClient+zkAsyncQuery.m
//  iOSQueryDemo
//
//  Created by Jonathan Hersh on 11/22/11.
//  Copyright (c) 2011 Salesforce.com. All rights reserved.
//

#import "zkSforceClient+zkAsyncQuery.h"

@implementation ZKSforceClient (zkAsyncQuery)

- (void)performSOQLQuery:(NSString *)query 
               failBlock:(void (^)(NSException *))failBlock 
           completeBlock:(void (^)(ZKQueryResult *))completeBlock {
    
    if( !query || [query length] == 0 ) {
        NSLog(@"SOQL: No query specified.");
        return;
    }
    
    if( ![self loggedIn] ) {
        NSLog(@"SOQL: Invalid client, or client does not have a valid session.");
        return;
    }
    
    NSLog(@"SOQL: %@", query);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^(void) {
        ZKQueryResult *qr = nil;
        
        @try {
            qr = [self query:query];
        } @catch( NSException *e ) {                        
            if( failBlock )
                failBlock(e);
            
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {            
            if( completeBlock )
                completeBlock(qr);
        });
    });
}

- (void)performSOSLQuery:(NSString *)query 
               failBlock:(void (^)(NSException *))failBlock 
           completeBlock:(void (^)(NSArray *))completeBlock {
    
    if( !query || [query length] == 0 ) {
        NSLog(@"SOSL: No query specified.");
        return;
    }
    
    if( ![self loggedIn] ) {
        NSLog(@"SOSL: Invalid client, or client does not have a valid session.");
        return;
    }
    
    NSLog(@"SOSL: %@", query);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^(void) {
        NSArray *qr = nil;
        
        @try {
            qr = [self search:query];
        } @catch( NSException *e ) {            
            if( failBlock )
                failBlock(e);
            
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {            
            if( completeBlock )
                completeBlock(qr);
        });
    });
}

@end
