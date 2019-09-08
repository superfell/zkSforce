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

#include <mach/mach.h>
#include <mach/mach_time.h>
#import "zkBaseClient.h"
#import "zkSoapException.h"
#import "zkParser.h"
#import "ZKConstants.h"

@implementation ZKBaseClient

@synthesize endpointUrl, delegate, urlSession;

-(void)logInvalidResponse:(NSHTTPURLResponse *)resp payload:(NSData *)data note:(NSString *)note {
    NSString *payload = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"Got invalid API response: %@\r\nRequestURL: %@\r\nHTTP StatusCode: %d\r\nresponseData:\r\n%@", note, resp.URL.absoluteString, (int)resp.statusCode, payload);
}

NSTimeInterval intervalFrom(uint64_t start) {
    uint64_t elapsed = mach_absolute_time() - start;
    
    // If this is the first time we've run, get the timebase.
    // We can use denom == 0 to indicate that sTimebaseInfo is
    // uninitialised because it makes no sense to have a zero
    // denominator in a fraction.
    static mach_timebase_info_data_t sTimebaseInfo;
    if ( sTimebaseInfo.denom == 0 ) {
        (void) mach_timebase_info(&sTimebaseInfo);
    }
    uint64_t elapsedNano = elapsed * sTimebaseInfo.numer / sTimebaseInfo.denom;
    NSTimeInterval duration = elapsedNano / 1000000000.0;
    return duration;
}

-(void)startRequest:(NSString *)payload name:(NSString *)callName handler:(void(^)(zkElement *root, NSError *err))handler {
    uint64_t start = mach_absolute_time();
    NSURLSession *s = urlSession;
    if (s == nil) s = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [self createRequest:payload name:callName];
    NSURLSessionDataTask *t = [s dataTaskWithRequest:request
                                   completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable err) {
       @try {
           zkElement *root = [self processResponse:(NSHTTPURLResponse *)response data:data error:err fromRequest:request name:callName];
           if (self.delegate != nil) {
               [self.delegate client:self sentRequest:payload named:callName to:self.endpointUrl withResponse:root in:intervalFrom(start)];
           }
           handler(root, nil);
           
       } @catch (NSException *ex) {
           if (self.delegate != nil) {
               [self.delegate client:self
                         sentRequest:payload
                               named:callName
                                  to:self.endpointUrl
                       withException:ex
                                  in:intervalFrom(start)];
           }
           handler(nil, ex);
       }
    }];
    [t resume];
}

/** Process this Response that was generated from the Request. Should return the root element of the response, or throw an exception */
-(zkElement *)processResponse:(NSHTTPURLResponse *)resp
                         data:(NSData *)respPayload
                  fromRequest:(NSMutableURLRequest *)request
                         name:(NSString *)callName
                        error:(NSError **)err {
    if (err && *err) {
        NSLog(@"Got error sending API request %@ : %@", request, *err);
        *err = [N]
        @throw [NSException exceptionWithName:@"Http error" reason:[NSString stringWithFormat:@"Unable to complete API request: %@", err] userInfo:nil];
    }
    //NSLog(@"response \r\n%@", [NSString stringWithCString:[respPayload bytes] length:[respPayload length]]);
    zkElement *root = [zkParser parseData:respPayload];
    if (root == nil) {
        [self logInvalidResponse:resp payload:respPayload note:@"Unable to parse XML"];
        @throw [NSException exceptionWithName:@"Xml error" reason:@"Unable to parse XML returned by server" userInfo:nil];
    }
    if (![root.name isEqualToString:@"Envelope"]) {
        [self logInvalidResponse:resp payload:respPayload note:[NSString stringWithFormat:@"Root element was %@, but should be Envelope", root.name]];
        @throw [NSException exceptionWithName:@"Xml error" reason:[NSString stringWithFormat:@"response XML not valid SOAP, root element should be Envelope, but was %@", root.name] userInfo:nil];
    }
    if (![root.namespace isEqualToString:NS_SOAP_ENV]) {
        [self logInvalidResponse:resp payload:respPayload note:[NSString stringWithFormat:@"Root element namespace was %@, but should be %@", root.namespace, NS_SOAP_ENV]];
        @throw [NSException exceptionWithName:@"Xml error" reason:[NSString stringWithFormat:@"response XML not valid SOAP, root namespace should be %@ but was %@", NS_SOAP_ENV, root.namespace] userInfo:nil];
    }
    zkElement *header = [root childElement:@"Header" ns:NS_SOAP_ENV];
    [self handleResponseSoapHeaders:header];
    
    zkElement *body = [root childElement:@"Body" ns:NS_SOAP_ENV];
    if (500 == resp.statusCode) {
        zkElement *fault = [body childElement:@"Fault" ns:NS_SOAP_ENV];
        if (fault == nil)
            @throw [NSException exceptionWithName:@"Xml error" reason:@"Fault status code returned, but unable to find soap:Fault element" userInfo:nil];
        NSString *fc = [fault childElement:@"faultcode"].stringValue;
        NSString *fm = [fault childElement:@"faultstring"].stringValue;
        @throw [ZKSoapException exceptionWithFaultCode:fc faultString:fm];
    }
    return root;
}

-(NSMutableURLRequest *)createRequest:(NSString *)payload name:(NSString *)callName {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:endpointUrl];
    request.HTTPMethod = @"POST";
    [request addValue:@"text/xml; charset=UTF-8" forHTTPHeaderField:@"content-type"];
    [request addValue:@"\"\"" forHTTPHeaderField:@"SOAPAction"];
    request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    [request setHTTPShouldHandleCookies:NO];
    
    NSData *data = [payload dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = data;
    return request;
}

-(void)handleResponseSoapHeaders:(zkElement *)soapHeaders {
}

@end
