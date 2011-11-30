/* 
 * Copyright (c) 2011, Jonathan Hersh, Simon Fell
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

#import "zkSforceClient+zkAsyncQuery.h"

@implementation ZKSforceClient (zkAsyncQuery)

-(BOOL)confirmLoggedIn {
    if (![self loggedIn]) {
        NSLog(@"ZKSforceClient does not have a valid session. request not executed");
        return NO;
    }
    return YES;
}

// This method implements the meat of all the perform* calls,
// it handles making the relevant call in a background thread/queue, 
// and then calling the fail or complete block on the UI thread.
// You don't appear to be able to have generic type'd blocks
// so the perform* methods all have shim completeBlock to cast 
// back to the relevant type from NSObject * that's used here.
//
-(void)performRequest:(NSObject * (^)(void))requestBlock 
            failBlock:(void (^)(NSException *))failBlock 
        completeBlock:(void (^)(NSObject *))completeBlock {
  
    // sanity check that we're actually logged in and ready to go.
    if (![self confirmLoggedIn]) return;
    
    // run this block async on the default queue
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^(void) {
        @try {
            NSObject *result = requestBlock();
            // run the completeBlock on the main thread.
            dispatch_async(dispatch_get_main_queue(), ^(void) {            
                completeBlock(result);
            });
            
        } @catch (NSException *ex) {
            // run the failBlock on the main thread.
            if (failBlock) {
                dispatch_async(dispatch_get_main_queue(), ^(void) {
                    failBlock(ex);
                });
            }
        }
    });
}

-(void)performQuery:(NSString *)query 
            failBlock:(void (^)(NSException *))failBlock 
        completeBlock:(void (^)(ZKQueryResult *))completeBlock {

    [self performRequest:^NSObject *(void) {
            return [self query:query];
        } 
            failBlock:failBlock
        completeBlock:^(NSObject *r) {
            if (completeBlock) completeBlock((ZKQueryResult *)r);
        }];
}

-(void)performSearch:(NSString *)query 
           failBlock:(void (^)(NSException *))failBlock 
       completeBlock:(void (^)(NSArray *))completeBlock {

    [self performRequest:^NSObject *(void) {
            return [self search:query];
        } 
               failBlock:failBlock 
           completeBlock:^(NSObject *r) {
               if (completeBlock) completeBlock((NSArray *)r);
        }];
}

-(void) performQueryMore:(NSString *)queryLocator
               failBlock:(void(^)(NSException *e))failBlock
           completeBlock:(void(^)(ZKQueryResult *result))completeBlock {
    
    [self performRequest:^NSObject *(void) {
            return [self queryMore:queryLocator];
        } 
               failBlock:failBlock
           completeBlock:^(NSObject *r) {
               if (completeBlock) completeBlock((ZKQueryResult *)r);
           }];
}

-(void) performQueryAll:(NSString *)soqlQuery
              failBlock:(void(^)(NSException *e))failBlock
          completeBlock:(void(^)(ZKQueryResult *result))completeBlock {
    
    [self performRequest:^NSObject *(void) {
            return [self queryAll:soqlQuery];
        } 
               failBlock:failBlock
           completeBlock:^(NSObject *r) {
               if (completeBlock) completeBlock((ZKQueryResult *)r);
           }];

}

-(void) performRetrieve:(NSString *)fields sobject:(NSString *)sobjectType ids:(NSArray *)ids
              failBlock:(void(^)(NSException *e))failBlock
          completeBlock:(void(^)(NSDictionary *result))completeBlock {  // NSString (Id) -> ZKSObject
    
    [self performRequest:^NSObject *(void) {
        return [self retrieve:fields sobject:sobjectType ids:ids];
    } 
               failBlock:failBlock
           completeBlock:^(NSObject *r) {
               if (completeBlock) completeBlock((NSDictionary *)r);
           }];
}

-(void) performCreate:(NSArray *)sobjects
            failBlock:(void(^)(NSException *e))failBlock
        completeBlock:(void(^)(NSArray *result))completeBlock {  // array of ZKSaveResult

    [self performRequest:^NSObject *(void) {
            return [self create:sobjects];
        } 
               failBlock:failBlock
           completeBlock:^(NSObject *r) {
               if (completeBlock) completeBlock((NSArray *)r);
           }];
}

-(void) performUpdate:(NSArray *)sobjects
            failBlock:(void(^)(NSException *e))failBlock
        completeBlock:(void(^)(NSArray *result))completeBlock {  // array of ZKSaveResult

    [self performRequest:^NSObject *(void) {
            return [self update:sobjects];
        } 
               failBlock:failBlock
           completeBlock:^(NSObject *r) {
               if (completeBlock) completeBlock((NSArray *)r);
           }];
}

-(void) performDelete:(NSArray *)sobjectIds
            failBlock:(void(^)(NSException *e))failBlock
        completeBlock:(void(^)(NSArray *result))completeBlock {  // array of ZKSaveResult

    [self performRequest:^NSObject *(void) {
            return [self delete:sobjectIds];
        } 
               failBlock:failBlock
           completeBlock:^(NSObject *r) {
               if (completeBlock) completeBlock((NSArray *)r);
           }];
}

-(void) performDescribeGlobalWithFailBlock:(void(^)(NSException *e))failBlock
                             completeBlock:(void(^)(NSArray *))completeBlock {   // array of ZKDescribeGlobalSObject
    
    [self performRequest:^NSObject *(void) {
            return [self describeGlobal];
        }
               failBlock:failBlock
           completeBlock:^(NSObject *r) {
               if (completeBlock) completeBlock((NSArray *)r);
           }];
}

-(void) performDescribeSObject:(NSString *)sobjectType
                     failBlock:(void(^)(NSException *e))failBlock
                 completeBlock:(void(^)(ZKDescribeSObject *))completeBlock {

    [self performRequest:^NSObject *(void) {
            return [self describeSObject:sobjectType];
        }
               failBlock:failBlock
           completeBlock:^(NSObject *r) {
               if (completeBlock) completeBlock((ZKDescribeSObject *)r);
           }];
}

-(void) performDescribeLayout:(NSString *)sobjectType recordTypeIds:(NSArray *)recordTypeIds
                    failBlock:(void(^)(NSException *e))failBlock
                completeBlock:(void(^)(ZKDescribeLayoutResult *))completeBlock {

    [self performRequest:^NSObject *(void) {
            return [self describeLayout:sobjectType recordTypeIds:recordTypeIds];
        }
               failBlock:failBlock
           completeBlock:^(NSObject *r) {
               if (completeBlock) completeBlock((ZKDescribeLayoutResult *)r);
           }];
    
}

-(void) performDescribeTabsWithFailBlock:(void(^)(NSException *e))failBlock
                           completeBlock:(void(^)(NSArray *))completeBlock {
    
    [self performRequest:^NSObject *(void) {
            return [self describeTabs];
        }
               failBlock:failBlock
           completeBlock:^(NSObject *r) {
               if (completeBlock) completeBlock((NSArray *)r);
           }];
}


-(void) performSetPassword:(NSString *)newPassword forUserId:(NSString *)userId
                 failBlock:(void(^)(NSException *e))failBlock
             completeBlock:(void(^)(void))completeBlock {
    
    [self performRequest:^NSObject *(void) {
        [self setPassword:newPassword forUserId:userId];
        return nil;
    } 
               failBlock:failBlock
           completeBlock:^(NSObject *r) {
               if (completeBlock) completeBlock();
           }];
}

-(void) performServerTimestampWithFailBlock:(void(^)(NSException *e))failBlock
                              completeBlock:(void(^)(NSString *))completeBlock {
    
    [self performRequest:^NSObject *(void) {
        return [self serverTimestamp];
    }
               failBlock:failBlock
           completeBlock:^(NSObject *r) {
               if (completeBlock) completeBlock((NSString *)r);
           }];
    
}

@end
