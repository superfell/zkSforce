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


#import "zkSforceClient.h"
#import "zkSforceClient+Operations.h"

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
            failBlock:(zkFailWithExceptionBlock)failBlock 
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
          failBlock:(zkFailWithExceptionBlock)failBlock 
      completeBlock:(zkCompleteQueryResultBlock)completeBlock {

    [self performRequest:^NSObject *(void) {
            return [self query:query];
        } 
            failBlock:failBlock
        completeBlock:^(NSObject *r) {
            if (completeBlock) completeBlock((ZKQueryResult *)r);
        }];
}

-(void)performSearch:(NSString *)query 
           failBlock:(zkFailWithExceptionBlock)failBlock 
       completeBlock:(zkCompleteArrayBlock)completeBlock {

    [self performRequest:^NSObject *(void) {
            return [self search:query];
        } 
               failBlock:failBlock 
           completeBlock:^(NSObject *r) {
               if (completeBlock) completeBlock((NSArray *)r);
        }];
}

-(void) performQueryMore:(NSString *)queryLocator 
               failBlock:(zkFailWithExceptionBlock)failBlock 
           completeBlock:(zkCompleteQueryResultBlock)completeBlock {
    
    [self performRequest:^NSObject *(void) {
            return [self queryMore:queryLocator];
        } 
               failBlock:failBlock
           completeBlock:^(NSObject *r) {
               if (completeBlock) completeBlock((ZKQueryResult *)r);
           }];
}

-(void) performQueryAll:(NSString *)soqlQuery 
              failBlock:(zkFailWithExceptionBlock)failBlock 
          completeBlock:(zkCompleteQueryResultBlock)completeBlock {
    
    [self performRequest:^NSObject *(void) {
            return [self queryAll:soqlQuery];
        } 
               failBlock:failBlock
           completeBlock:^(NSObject *r) {
               if (completeBlock) completeBlock((ZKQueryResult *)r);
           }];

}

-(void) performRetrieve:(NSString *)fields 
                sobject:(NSString *)sobjectType 
                    ids:(NSArray *)ids 
              failBlock:(zkFailWithExceptionBlock)failBlock 
          completeBlock:(zkCompleteDictionaryBlock)completeBlock {  // NSString (Id) -> ZKSObject
    
    [self performRequest:^NSObject *(void) {
        return [self retrieve:fields sobject:sobjectType ids:ids];
    } 
               failBlock:failBlock
           completeBlock:^(NSObject *r) {
               if (completeBlock) completeBlock((NSDictionary *)r);
           }];
}

-(void) performCreate:(NSArray *)sobjects 
            failBlock:(zkFailWithExceptionBlock)failBlock 
        completeBlock:(zkCompleteArrayBlock)completeBlock{  // array of ZKSaveResult

    [self performRequest:^NSObject *(void) {
            return [self create:sobjects];
        } 
               failBlock:failBlock
           completeBlock:^(NSObject *r) {
               if (completeBlock) completeBlock((NSArray *)r);
           }];
}

-(void) performUpdate:(NSArray *)sobjects 
            failBlock:(zkFailWithExceptionBlock)failBlock 
        completeBlock:(zkCompleteArrayBlock)completeBlock {  // array of ZKSaveResult

    [self performRequest:^NSObject *(void) {
            return [self update:sobjects];
        } 
               failBlock:failBlock
           completeBlock:^(NSObject *r) {
               if (completeBlock) completeBlock((NSArray *)r);
           }];
}

-(void) performDelete:(NSArray *)sobjectIds 
            failBlock:(zkFailWithExceptionBlock)failBlock 
        completeBlock:(zkCompleteArrayBlock)completeBlock {  // array of ZKSaveResult

    [self performRequest:^NSObject *(void) {
            return [self delete:sobjectIds];
        } 
               failBlock:failBlock
           completeBlock:^(NSObject *r) {
               if (completeBlock) completeBlock((NSArray *)r);
           }];
}

-(void) performDescribeGlobalWithFailBlock:(zkFailWithExceptionBlock)failBlock 
                             completeBlock:(zkCompleteArrayBlock)completeBlock {   // array of ZKDescribeGlobalSObject
    
    [self performRequest:^NSObject *(void) {
            return [self describeGlobal];
        }
               failBlock:failBlock
           completeBlock:^(NSObject *r) {
               if (completeBlock) completeBlock((NSArray *)r);
           }];
}

-(void) performDescribeSObject:(NSString *)sobjectType 
                     failBlock:(zkFailWithExceptionBlock)failBlock 
                 completeBlock:(zkCompleteSObjectDescribeBlock)completeBlock{

    [self performRequest:^NSObject *(void) {
            return (NSObject *)[self describeSObject:sobjectType];
        }
               failBlock:failBlock
           completeBlock:^(NSObject *r) {
               if (completeBlock) completeBlock((ZKDescribeSObject *)r);
           }];
}

-(void) performDescribeLayout:(NSString *)sobjectType 
                recordTypeIds:(NSArray *)recordTypeIds 
                    failBlock:(zkFailWithExceptionBlock)failBlock 
                completeBlock:(zkCompleteLayoutResultBlock)completeBlock {

    [self performRequest:^NSObject *(void) {
            return [self describeLayout:sobjectType recordTypeIds:recordTypeIds];
        }
               failBlock:failBlock
           completeBlock:^(NSObject *r) {
               if (completeBlock) completeBlock((ZKDescribeLayoutResult *)r);
           }];
    
}

-(void) performDescribeTabsWithFailBlock:(zkFailWithExceptionBlock)failBlock 
                           completeBlock:(zkCompleteArrayBlock)completeBlock {
    
    [self performRequest:^NSObject *(void) {
            return [self describeTabs];
        }
               failBlock:failBlock
           completeBlock:^(NSObject *r) {
               if (completeBlock) completeBlock((NSArray *)r);
           }];
}


-(void) performSetPassword:(NSString *)userId
                  password:(NSString *)newPassword
                 failBlock:(zkFailWithExceptionBlock)failBlock 
             completeBlock:(zkCompleteVoidBlock)completeBlock {
    
    [self performRequest:^NSObject *(void) {
        [self setPassword:userId password:newPassword];
        return nil;
    } 
               failBlock:failBlock
           completeBlock:^(NSObject *r) {
               if (completeBlock) completeBlock();
           }];
}

-(void) performGetServerTimestampWithFailBlock:(zkFailWithExceptionBlock)failBlock
                                 completeBlock:(zkCompleteServerTimestampBlock)completeBlock {
    
    [self performRequest:^NSObject *(void) {
        return [self getServerTimestamp];
    }
               failBlock:failBlock
           completeBlock:^(NSObject *r) {
               if (completeBlock) completeBlock((ZKGetServerTimestampResult *)r);
           }];
    
}

@end
