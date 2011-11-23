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
