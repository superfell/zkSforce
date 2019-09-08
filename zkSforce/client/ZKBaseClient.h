// Copyright (c) 2006-2008,2013,2019 Simon Fell
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

#import <AvailabilityMacros.h>

@class zkElement;
@class ZKBaseClient;

@protocol ZKBaseClientDelegate

// Called after each request has been sent and the response parsed, but before
// any of the callbacks fire.
-(void)client:(ZKBaseClient *)client
  sentRequest:(NSString *)payload
        named:(NSString *)callName
           to:(NSURL *)destination
 withResponse:(zkElement *)response
        error:(NSError *)error
           in:(NSTimeInterval)time;

@end

@interface ZKBaseClient : NSObject

@property (weak) NSObject<ZKBaseClientDelegate> *delegate;
@property (strong) NSURL *endpointUrl;
@property (strong) NSURLSession *urlSession;

/** Starts the HTTP request for the supplied payload, and parse the response.
    The handler will get called once a response is available.
    The delegate if set will be called before the handler.
    The handler (and delegate if called) will be called on a random GCD thread.
    If there was an error after parsing was succesfully completed, then both
    root and err will be set
*/
-(void)startRequest:(NSString *)payload name:(NSString *)callName handler:(void(^)(zkElement *root, NSError *err))handler;

@end

/** Your ZKBaseClient can override this to do any processing it wants on the response soap headers,
    this is called before the client:sentRequest:named:... delegate is fired. */
@interface ZKBaseClient (ZKHeaders)

/** soapHeaders can be nil if there's no soap:Header element in the response */
-(void)handleResponseSoapHeaders:(zkElement *)soapHeaders;

@end

/** Your ZKBaseClient can override this to do any customization it wants to do on either generating the HTTP request,
    or in processing the results */
@interface ZKBaseClient(RequestProcessing)

-(NSMutableURLRequest *)createRequest:(NSString *)payload name:(NSString *)callName;

-(zkElement *)processResponse:(NSHTTPURLResponse *)resp
                         data:(NSData *)respPayload
                  fromRequest:(NSMutableURLRequest *)request
                         name:(NSString *)callName
                        // err might be set by the caller of this, or by the callee to report an error it found
                        error:(NSError **)err;
@end
