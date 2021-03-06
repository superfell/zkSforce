// Copyright (c) 2011,2018,2019 Simon Fell
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


@protocol ZKAuthenticationInfo

@property (readonly) NSString *sessionId;     // return an API Session ID.
@property (readonly) NSURL *instanceUrl;      // return the full URL to the soap endpoint for the authentication user.
@property (readwrite) NSURLSession *urlSession; // Any HTTP requests that are made will use this session, if nil
                                                // will use the default one.

// Force the sessionId to be refreshed. The callback will be called when completed.
// If there was an error, it will be in the exception, otherwise it'll be nil.
// Callback will be executed on a random GCD queue.
-(void)refresh:(void(^)(NSError *ex))cb;

// Refresh the session if its needed. (this gets called before every soap call)
// The callback will include if the session was refreshed.
// Callback will be executed on a random GCD queue.
-(void)refreshIfNeeded:(void(^)(BOOL refreshed, NSError *ex))cb;

@end
