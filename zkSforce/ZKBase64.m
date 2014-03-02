// Copyright (c) 2013 Simon Fell
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

#import "ZKBase64.h"

#ifdef __MAC_OS_X_VERSION_MAX_ALLOWED
#import <Security/Security.h>
#endif

@implementation NSString (ZKBase64)

#ifdef __MAC_OS_X_VERSION_MAX_ALLOWED
// OSX 10.7+ Only
-(NSData *)ZKBase64Decode {
    SecTransformRef b64transform = SecDecodeTransformCreate(kSecBase64Encoding, NULL);
    SecTransformSetAttribute(b64transform, kSecTransformInputAttributeName, (CFTypeRef)[self dataUsingEncoding:NSASCIIStringEncoding], NULL);
    CFDataRef output = SecTransformExecute(b64transform, NULL);
    CFRelease(b64transform);
    return (NSData*)CFBridgingRelease(output);
}
#endif

#if __IPHONE_OS_VERSION_MIN_REQUIRED
// iOS 7
-(NSData *)ZKBase64Decode {
    return [[[NSData alloc] initWithBase64EncodedString:self options:0] autorelease];
}
#endif

@end

@implementation NSData (ZKBase64)

#ifdef __MAC_OS_X_VERSION_MAX_ALLOWED
// OSX 10.7+ Only
-(NSString *)ZKBase64Encode {
    SecTransformRef b64transform = SecEncodeTransformCreate(kSecBase64Encoding, NULL);
    SecTransformSetAttribute(b64transform, kSecTransformInputAttributeName, (CFTypeRef)self, NULL);
    CFDataRef output = SecTransformExecute(b64transform, NULL);
    CFRelease(b64transform);
    return [[[NSString alloc] initWithData:(NSData *)CFBridgingRelease(output) encoding:NSASCIIStringEncoding] autorelease];
}
#endif

#if __IPHONE_OS_VERSION_MIN_REQUIRED
// iOS 7
-(NSString *)ZKBase64Encode {
    return [self base64EncodedStringWithOptions:0];
}
#endif

@end
