// Copyright (c) 2014 Simon Fell
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
// 
// Note: This file was generated by WSDL2ZKSforce. 
//		  see https://github.com/superfell/WSDL2ZKSforce
//       DO NOT HAND EDIT.
//

#import "ZKAddress.h"
#import "zkEnvelope.h"

@implementation ZKAddress

@synthesize city, country, countryCode, geocodeAccuracy, postalCode, state, stateCode, street;

-(instancetype)init {
    self = [super init];
    return self;
}

-(instancetype)initWithZKXmlDeserializer:(ZKXmlDeserializer *)d {
    self = [super initWithZKXmlDeserializer:d];
	self.city = [d string:@"city"];
	self.country = [d string:@"country"];
	self.countryCode = [d string:@"countryCode"];
	self.geocodeAccuracy = [d string:@"geocodeAccuracy"];
	self.postalCode = [d string:@"postalCode"];
	self.state = [d string:@"state"];
	self.stateCode = [d string:@"stateCode"];
	self.street = [d string:@"street"];
    return self;
}

-(instancetype)initWithXmlElement:(zkElement *)e {
    ZKXmlDeserializer *d = [[ZKXmlDeserializer alloc] initWithXmlElement:e];
    return [self initWithZKXmlDeserializer:d];
}

-(void)serializeToEnvelope:(ZKEnvelope *)env elemName:(NSString *)elemName {
	[env startElement:elemName type:@"address"];
	[env addDoubleElement:@"latitude"  elemValue:self.latitude];
	[env addDoubleElement:@"longitude" elemValue:self.longitude];
	[env addElement:@"city"            elemValue:self.city            nillable:YES optional:NO];
	[env addElement:@"country"         elemValue:self.country         nillable:YES optional:NO];
	[env addElement:@"countryCode"     elemValue:self.countryCode     nillable:YES optional:NO];
	[env addElement:@"geocodeAccuracy" elemValue:self.geocodeAccuracy nillable:YES optional:NO];
	[env addElement:@"postalCode"      elemValue:self.postalCode      nillable:YES optional:NO];
	[env addElement:@"state"           elemValue:self.state           nillable:YES optional:NO];
	[env addElement:@"stateCode"       elemValue:self.stateCode       nillable:YES optional:NO];
	[env addElement:@"street"          elemValue:self.street          nillable:YES optional:NO];
	[env endElement:elemName];
}
@end
