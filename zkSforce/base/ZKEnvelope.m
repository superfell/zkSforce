// Copyright (c) 2006,2013 Simon Fell
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


#import "ZKEnvelope.h"
#import "ZKXMLSerializable.h"
#import "ZKConstants.h"
#import "ZKSObject.h"

@implementation ZKEnvelope

enum envState {
    inEnvelope = 1,
    inHeaders = 2,
    inBody = 3
};

- (void)start:(NSString *)primaryNamespceUri {
    [self startElement:@"s:Envelope" prefixes:@[@"s",@"x",@""] uris:@[NS_SOAP_ENV, NS_URI_XSI, primaryNamespceUri]];
    state = inEnvelope;
}

- (void)moveToHeaders {
    if (state == inBody)
        @throw [NSException exceptionWithName:@"Illegal State Exception" reason:@"Unable to write headers once we've moved to the body" userInfo:nil];
    if (state == inHeaders) return;
    [self startElement:@"s:Header"];
    state = inHeaders;
}

- (void)writeSessionHeader:(NSString *)sessionId {
    if (sessionId.length == 0) return;
    [self moveToHeaders];
    [self startElement:@"SessionHeader"];
    [self addElement:@"sessionId" elemValue:sessionId];
    [self endElement:@"SessionHeader"];
}

- (void)writeCallOptionsHeader:(NSString *)clientId {
    if (clientId.length == 0) return;
    [self moveToHeaders];
    [self startElement:@"CallOptions"];
    [self addElement:@"client" elemValue:clientId];
    [self endElement:@"CallOptions"];
}

- (void)writeMruHeader:(BOOL)updateMru {
    if (!updateMru) return;
    [self moveToHeaders];
    [self startElement:@"MruHeader"];
    [self addElement:@"updateMru" elemValue:@"true"];
    [self endElement:@"MruHeader"];
}

- (void) moveToBody {
    if (state == inHeaders)
        [self endElement:@"s:Header"];
    if (state != inBody) 
        [self startElement:@"s:Body"];
    state = inBody;
}

// TODO, can we delete this?
- (void) addElementSObject:(NSString *)elemName elemValue:(ZKSObject *)sobject {
    [sobject serializeTo:self elemName:elemName];
}

- (NSString *)end {
    if (state == inHeaders)
        [self endElement:@"s:Header"];
    if (state == inBody)
        [self endElement:@"s:Body"];
    [self endElement:@"s:Envelope"];
    return env;
}

@end
