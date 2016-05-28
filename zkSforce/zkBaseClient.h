// Copyright (c) 2006-2008,2013 Simon Fell
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


@class zkElement;
@class ZKBaseClient;

@protocol ZKBaseClientDelegate
-(void)client:(ZKBaseClient *)client sentRequest:(NSString *)payload named:(NSString *)callName to:(NSURL *)destination withResponse:(zkElement *)response in:(NSTimeInterval)time;
-(void)client:(ZKBaseClient *)client sentRequest:(NSString *)payload named:(NSString *)callName to:(NSURL *)destination withException:(NSException *)ex    in:(NSTimeInterval)time;
@end

@interface ZKBaseClient : NSObject {
    NSURL                           *endpointUrl;
    zkElement                       *responseHeaders;
    NSObject<ZKBaseClientDelegate>  *delegate;
}

@property (assign) NSObject<ZKBaseClientDelegate> *delegate;
@property (retain) NSURL *endpointUrl;

- (zkElement *)sendRequest:(NSString *)payload name:(NSString *)callName;
- (zkElement *)sendRequest:(NSString *)payload name:(NSString *)callName returnRoot:(BOOL)root;

/** @return the Soap:Header element from the response payload. */
- (zkElement *)lastResponseSoapHeaders;

@end

/** Your ZKBaseClient can override this to do any processing it wants on the response soap headers, this is called before the client:sentRequest:named:... delegate is fired. */
@interface ZKBaseClient (ZKHeaders)

/** soapHeaders can be nil if there's no soap:Header element in the response */
-(void)handleResponseSoapHeaders:(zkElement *)soapHeaders;

@end