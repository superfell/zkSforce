//
//  zkSforceClient+zkAsyncQuery.h
//  iOSQueryDemo
//
//  Created by Jonathan Hersh on 11/22/11.
//  Copyright (c) 2011 Salesforce.com. All rights reserved.
//

#import "zkSforce.h"

@interface ZKSforceClient (zkAsyncQuery)

/**
 ** Asynchronously perform a SOQL query using zksforce over SOAP. Example usage:
 
 [client performSOQLQuery:@"select id from user limit 10"
                failBlock:^(NSException *e) {
                    NSLog(@"SOQL failed with exception: %@", e);
                }
             completeBlock:^(ZKQueryResult *qr) {
 if( qr && [qr records] && [[qr records] count] > 0 )
 NSLog(@"Received some objects! %@", [qr records]);
 else
 NSLog(@"Received no objects. :(");
 }];
 
 
 ** @param query SOQL query.
 ** @param failBlock A block to be executed if the query fails. Takes an NSException
 ** @param completeBlock A block to be executed if the query succeeds. Takes a ZKQueryResult
 **/
- (void) performSOQLQuery:(NSString *)query 
                failBlock:(void(^)(NSException *e))failBlock
            completeBlock:(void(^)(ZKQueryResult *result))completeBlock;

/**
 ** Asynchronously perform a SOSL query using zksforce over SOAP. Example usage:
 
 [client performSOSLQuery:@"FIND {batman*} IN NAME FIELDS RETURNING User (id,name)"
                failBlock:^(NSException *e) {
                     NSLog(@"SOSL failed with exception: %@", e);
                }
            completeBlock:^(NSArray *results) {
                if( results && [results count] > 0 )
                     NSLog(@"SOSL received some results: %@", results);
                else
                     NSLog(@"SOSL received no results. :(");
        }];
 
 ** @param query SOSL query.
 ** @param client The current shared client object.
 ** @param failBlock A block to be executed if the query fails. Takes an NSException
 ** @param completeBlock A block to be executed if the query succeeds. Takes a ZKQueryResult
 **/
- (void) performSOSLQuery:(NSString *)query 
                failBlock:(void(^)(NSException *e))failBlock
            completeBlock:(void(^)(NSArray *result))completeBlock;



@end
