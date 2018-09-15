// Copyright (c) 2016 Simon Fell
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


#import <XCTest/XCTest.h>
#import "zkAuthentication.h"
#import "ZKEnvelope.h"

@interface ZKAuthenticationTests : XCTestCase

@end

@implementation ZKAuthenticationTests

- (void)testPortalEnvelope {
    id pl = [ZKSoapPortalLogin soapPortalLoginWithUsername:@"bob@example.org"
                                                               password:@"password"
                                                               authHost:nil
                                                             apiVersion:38
                                                               clientId:nil
                                                               delegate:nil
                                                                  orgId:@"00D000000000001123"
                                                               portalId:@"123123123123123123"];
    ZKEnvelope *env = [pl newEnvelope];
    NSString *soap =env.end;
    XCTAssertEqualObjects(soap, @"<s:Envelope xmlns:s='http://schemas.xmlsoap.org/soap/envelope/' xmlns:x='http://www.w3.org/2001/XMLSchema-instance' xmlns='urn:partner.soap.sforce.com'><s:Header><LoginScopeHeader><organizationId>00D000000000001123</organizationId><portalId>123123123123123123</portalId></LoginScopeHeader></s:Header><s:Body></s:Body></s:Envelope>");
}

@end
