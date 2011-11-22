/* 
 * Copyright (c) 2011, Jonathan Hersh
 * Author: Jonathan Hersh jon@her.sh
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without modification, are permitted provided 
 * that the following conditions are met:
 * 
 *    Redistributions of source code must retain the above copyright notice, this list of conditions and the 
 *    following disclaimer.
 *  
 *    Redistributions in binary form must reproduce the above copyright notice, this list of conditions and 
 *    the following disclaimer in the documentation and/or other materials provided with the distribution. 
 *    
 *    Neither the name of Jonathan Hersh nor the names of any contributors may be used to endorse or 
 *    promote products derived from this software without specific prior written permission.
 *  
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED 
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A 
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR 
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED 
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) 
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING 
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
 * POSSIBILITY OF SUCH DAMAGE.
 */

#import "zkSforce.h"

@interface zkAsyncQuery : NSObject

/**
 ** Asynchronously perform a SOQL query using zksforce over SOAP. Example usage:
 
 [zkAsyncQuery performSOQLQuery:@"select id from user limit 10"
                     withClient:client
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
 ** @param client The current shared client object.
 ** @param failBlock A block to be executed if the query fails. Takes an NSException
 ** @param completeBlock A block to be executed if the query succeeds. Takes a ZKQueryResult
 **/
+ (void) performSOQLQuery:(NSString *)query 
               withClient:(ZKSforceClient *)client
                failBlock:(void(^)(NSException *e))failBlock
            completeBlock:(void(^)(ZKQueryResult *result))completeBlock;

/**
 ** Asynchronously perform a SOSL query using zksforce over SOAP. Example usage:
 
 [zkAsyncQuery performSOSLQuery:@"FIND {batman*} IN NAME FIELDS RETURNING User (id,name)"
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
+ (void) performSOSLQuery:(NSString *)query 
               withClient:(ZKSforceClient *)client
                failBlock:(void(^)(NSException *e))failBlock
            completeBlock:(void(^)(NSArray *result))completeBlock;


@end
