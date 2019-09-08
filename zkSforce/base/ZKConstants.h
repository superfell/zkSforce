// Copyright (c) 2019 Simon Fell
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

#ifndef ZKConstants_h
#define ZKConstants_h

// XML Namespace URIs
FOUNDATION_EXPORT NSString *const NS_URI_XSI;
FOUNDATION_EXPORT NSString *const NS_URI_XSD;
FOUNDATION_EXPORT NSString *const NS_SOAP_ENV;

// Our domain for NSErrors
FOUNDATION_EXPORT NSString *const ZKErrorDomain;

// NSError user Info keys
FOUNDATION_EXPORT NSString *const ZKSoapFaultCodeKey;

// Our NSError error codes
const NSInteger kInvalidXml             = -100;

// The HTTP response should be a SOAP 1.1 Envelope, but we received something else
const NSInteger kNotSoapEnvelope        = -101;

// the HTTP status code said the response should be a soap fault
// but there was no soap:Fault element in the response message.
const NSInteger kSoapFaultMissingFault  = -102;

// the Server returned a SOAP Fault message
const NSInteger kSoapFault              = -103;

#endif /* ZKConstants_h */
