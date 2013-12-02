// Copyright (c) 2011, Jonathan Hersh, Simon Fell
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
