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
#import "ZKBaseClient.h"
#import "ZKParser.h"
#import "ZKErrors.h"

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

-(void)startRequest:(NSString *)payload name:(NSString *)callName handler:(void(^)(ZKElement *root, NSError *err))handler {
    uint64_t start = mach_absolute_time();
    NSObject<ZKBaseClientDelegate> *del = self.delegate;
    NSURLSession *s = urlSession;
    if (s == nil) s = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [self createRequest:payload name:callName];
    NSURLSessionDataTask *t = [s dataTaskWithRequest:request
                                   completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable err) {

        NSError *error = err;
        ZKElement *root = [self processResponse:(NSHTTPURLResponse *)response data:data fromRequest:request name:callName error:&error];
        if (del != nil) {
            [del client:self sentRequest:payload named:callName to:self.endpointUrl withResponse:root error:error in:intervalFrom(start)];
        }
        handler(root, error);
    }];
    [t resume];
}

/** Process this Response that was generated from the Request. Should return the root element of the response, or throw an exception */
-(ZKElement *)processResponse:(NSHTTPURLResponse *)resp
                         data:(NSData *)respPayload
                  fromRequest:(NSMutableURLRequest *)request
                         name:(NSString *)callName
                        error:(NSError **)err {
    if (err && *err) {
        NSLog(@"Got error sending API request %@ : %@", request, *err);
        return nil;
    }
    if (!err) {
        NSError __autoreleasing *dummy = nil;
        err = &dummy;
    }
    //NSLog(@"response \r\n%@", [NSString stringWithCString:[respPayload bytes] length:[respPayload length]]);
    ZKElement *root = [ZKParser parseData:respPayload];
    if (root == nil) {
        [self logInvalidResponse:resp payload:respPayload note:@"Unable to parse XML"];
        *err = [ZKErrors errorWithCode:kInvalidXml message:@"Unable to parse XML returned by server"];
        return nil;
    }
    if (![root.name isEqualToString:@"Envelope"]) {
        [self logInvalidResponse:resp payload:respPayload note:[NSString stringWithFormat:@"Root element was %@, but should be Envelope", root.name]];
        *err = [ZKErrors errorWithCode:kNotSoapEnvelope message:[NSString stringWithFormat:@"response XML not valid SOAP, root element should be Envelope, but was %@", root.name]];
        return root;
    }
    if (![root.namespace isEqualToString:NS_SOAP_ENV]) {
        [self logInvalidResponse:resp payload:respPayload note:[NSString stringWithFormat:@"Root element namespace was %@, but should be %@", root.namespace, NS_SOAP_ENV]];
        *err = [ZKErrors errorWithCode:kNotSoapEnvelope message:[NSString stringWithFormat:@"response XML not valid SOAP, root namespace should be %@ but was %@", NS_SOAP_ENV, root.namespace]];
        return root;
    }
    ZKElement *header = [root childElement:@"Header" ns:NS_SOAP_ENV];
    [self handleResponseSoapHeaders:header];
    
    if (500 == resp.statusCode) {
        ZKElement *body = [root childElement:@"Body" ns:NS_SOAP_ENV];
        ZKElement *fault = [body childElement:@"Fault" ns:NS_SOAP_ENV];
        if (fault == nil) {
            *err = [ZKErrors errorWithCode:kSoapFaultMissingFault message:@"Fault status code returned, but unable to find soap:Fault element"];
        } else {
            NSString *fc = [fault childElement:@"faultcode"].stringValue;
            NSString *fm = [fault childElement:@"faultstring"].stringValue;
            *err = [ZKErrors errorWithSoapFault:fc message:fm];
        }
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

-(void)handleResponseSoapHeaders:(ZKElement *)soapHeaders {
}

@end
