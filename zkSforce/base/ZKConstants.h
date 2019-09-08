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
extern NSString *const NS_URI_XSI;
extern NSString *const NS_URI_XSD;
extern NSString *const NS_SOAP_ENV;

// Our domain for NSErrors
extern NSString *const ZKErrorDomain;

// NSError user Info keys
extern NSString *const ZKSoapFaultCodeKey;

// Our NSError error codes
extern const NSInteger kHttpError;

extern const NSInteger kInvalidXml;

// The HTTP response should be a SOAP 1.1 Envelope, but we received something else
extern const NSInteger kNotSoapEnvelope;

// the HTTP status code said the response should be a soap fault
// but there was no soap:Fault element in the response message.
extern const NSInteger kSoapFaultMissingFault;

// the Server returned a SOAP Fault message
extern const NSInteger kSoapFault;

// Authentication must be performed before this call can be made.
// i.e. you can call create without logging in.
extern const NSInteger kAuthenticationRequired;

// Failed to parse the parameters from an OAuth callback.
extern const NSInteger kOAuthParsingError;

#endif /* ZKConstants_h */
