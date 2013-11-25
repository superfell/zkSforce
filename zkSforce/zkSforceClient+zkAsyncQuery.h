/* 
 * Copyright (c) 2011, Jonathan Hersh, Simon Fell
 * Authors: Jonathan Hersh jon@her.sh
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

@interface ZKSforceClient (zkAsyncQuery)

typedef void (^zkFailWithExceptionBlock)        (NSException *e);
typedef void (^zkCompleteQueryResultBlock)      (ZKQueryResult *qr);
typedef void (^zkCompleteArrayBlock)            (NSArray *arr);
typedef void (^zkCompleteDictionaryBlock)       (NSDictionary *arr);
typedef void (^zkCompleteStringBlock)           (NSString *str);
typedef void (^zkCompleteLayoutResultBlock)     (ZKDescribeLayoutResult *lr);
typedef void (^zkCompleteSObjectDescribeBlock)  (ZKDescribeSObject *arr);
typedef void (^zkCompleteServerTimestampBlock)  (ZKGetServerTimestampResult *res);
typedef void (^zkCompleteVoidBlock)             (void);

/**
 ** Asynchronously perform a SOQL query using zksforce over SOAP. Example usage:
 
 [client performQuery:@"select id from user limit 10"
            failBlock:^(NSException *e) {
                   NSLog(@"SOQL failed with exception: %@", e);
        }
        completeBlock:^(ZKQueryResult *qr) {
            if( qr && [qr records] && [[qr records] count] > 0 )
                NSLog(@"Received some objects! %@", [qr records]);
            else
                NSLog(@"Received no objects. :(");
        }];
 
 Both the failBlock and completeBlock are run on the main thread.
 
 ** @param query SOQL query.
 ** @param failBlock A block to be executed if the query fails. Takes an NSException. 
 ** @param completeBlock A block to be executed if the query succeeds. Takes a ZKQueryResult.
 **/
-(void) performQuery:(NSString *)soqlQuery 
           failBlock:(zkFailWithExceptionBlock)failBlock
       completeBlock:(zkCompleteQueryResultBlock)completeBlock;

/**
 ** Asynchronously perform a SOSL search using zksforce over SOAP. Example usage:
 
 [client performQuery:@"FIND {batman*} IN NAME FIELDS RETURNING User (id,name)"
            failBlock:^(NSException *e) {
                NSLog(@"SOSL failed with exception: %@", e);
            }
        completeBlock:^(NSArray *results) {
                if( results && [results count] > 0 )
                     NSLog(@"SOSL received some results: %@", results);
                else
                     NSLog(@"SOSL received no results. :(");
        }];
 
 Both the failBlock and completeBlock are run on the main thread.

 ** @param query SOSL query.
 ** @param failBlock A block to be executed if the search fails. Takes an NSException
 ** @param completeBlock A block to be executed if the search succeeds. Takes an NSArray (of ZKSObject)
 **/
-(void) performSearch:(NSString *)soslQuery 
            failBlock:(zkFailWithExceptionBlock)failBlock
        completeBlock:(zkCompleteArrayBlock)completeBlock;

// Remaining methods all work similarly to the above 2.

-(void) performQueryMore:(NSString *)queryLocator
               failBlock:(zkFailWithExceptionBlock)failBlock
           completeBlock:(zkCompleteQueryResultBlock)completeBlock;

-(void) performQueryAll:(NSString *)soqlQuery
              failBlock:(zkFailWithExceptionBlock)failBlock
          completeBlock:(zkCompleteQueryResultBlock)completeBlock;

-(void) performRetrieve:(NSString *)fields 
                sobject:(NSString *)sobjectType 
                    ids:(NSArray *)ids
              failBlock:(zkFailWithExceptionBlock)failBlock
          completeBlock:(zkCompleteDictionaryBlock)completeBlock;  // NSString (Id) -> ZKSObject


// CRUD calls
-(void) performCreate:(NSArray *)sobjects
            failBlock:(zkFailWithExceptionBlock)failBlock
        completeBlock:(zkCompleteArrayBlock)completeBlock;  // array of ZKSaveResult

-(void) performUpdate:(NSArray *)sobjects
            failBlock:(zkFailWithExceptionBlock)failBlock
        completeBlock:(zkCompleteArrayBlock)completeBlock;  // array of ZKSaveResult

-(void) performDelete:(NSArray *)sobjectIds
            failBlock:(zkFailWithExceptionBlock)failBlock
        completeBlock:(zkCompleteArrayBlock)completeBlock;  // array of ZKSaveResult


// Describes
-(void) performDescribeGlobalWithFailBlock:(zkFailWithExceptionBlock)failBlock
                             completeBlock:(zkCompleteArrayBlock)completeBlock;   // array of ZKDescribeGlobalSObject

-(void) performDescribeSObject:(NSString *)sobjectType
                     failBlock:(zkFailWithExceptionBlock)failBlock
                 completeBlock:(zkCompleteSObjectDescribeBlock)completeBlock;

-(void) performDescribeLayout:(NSString *)sobjectType 
                recordTypeIds:(NSArray *)recordTypeIds
                    failBlock:(zkFailWithExceptionBlock)failBlock
                completeBlock:(zkCompleteLayoutResultBlock)completeBlock;

-(void) performDescribeTabsWithFailBlock:(zkFailWithExceptionBlock)failBlock
                           completeBlock:(zkCompleteArrayBlock)completeBlock;


// Utility methods
-(void) performSetPassword:(NSString *)userId
                 password:(NSString *)newPassword
                 failBlock:(zkFailWithExceptionBlock)failBlock
             completeBlock:(zkCompleteVoidBlock)completeBlock;

-(void) performGetServerTimestampWithFailBlock:(zkFailWithExceptionBlock)failBlock
                                 completeBlock:(zkCompleteServerTimestampBlock)completeBlock;

@end
