// Copyright (c) 2013 Simon Fell
//
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the "Software"),
// to deal in the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following conditions
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

#import "ZKDescribeSoftphoneLayoutCallType.h"
#import "ZKEnvelope.h"
#import "ZKDescribeSoftphoneLayoutInfoField.h"
#import "ZKDescribeSoftphoneLayoutSection.h"
#import "ZKDescribeSoftphoneScreenPopOption.h"

@interface ZKDescribeSoftphoneLayoutCallType()
@property (strong,nonatomic) NSArray   *infoFields__v;
@property (strong,nonatomic) NSString  *name__v;
@property (strong,nonatomic) NSArray   *screenPopOptions__v;
@property (strong,nonatomic) NSString  *screenPopsOpenWithin__v;
@property (strong,nonatomic) NSArray   *sections__v;
@end

@implementation ZKDescribeSoftphoneLayoutCallType


+(void)load {
    [self registerType:self xmlName:@"DescribeSoftphoneLayoutCallType"];
}

-(NSArray *)infoFields {
    if ((fields__set[0] & 0x1) == 0) {
        self.infoFields__v = [self complexTypeArrayFromElements:@"infoFields" cls:[ZKDescribeSoftphoneLayoutInfoField class]];
        fields__set[0] |= 0x1; 
    }
    return self.infoFields__v;
}
        

-(void)setInfoFields:(NSArray *)v {
    self.infoFields__v = v;
    fields__set[0] |= 0x1; 
}
        

-(NSString *)name {
    if ((fields__set[0] & 0x2) == 0) {
        self.name__v = [self string:@"name"];
        fields__set[0] |= 0x2; 
    }
    return self.name__v;
}
        

-(void)setName:(NSString *)v {
    self.name__v = v;
    fields__set[0] |= 0x2; 
}
        

-(NSArray *)screenPopOptions {
    if ((fields__set[0] & 0x4) == 0) {
        self.screenPopOptions__v = [self complexTypeArrayFromElements:@"screenPopOptions" cls:[ZKDescribeSoftphoneScreenPopOption class]];
        fields__set[0] |= 0x4; 
    }
    return self.screenPopOptions__v;
}
        

-(void)setScreenPopOptions:(NSArray *)v {
    self.screenPopOptions__v = v;
    fields__set[0] |= 0x4; 
}
        

-(NSString *)screenPopsOpenWithin {
    if ((fields__set[0] & 0x8) == 0) {
        self.screenPopsOpenWithin__v = [self string:@"screenPopsOpenWithin"];
        fields__set[0] |= 0x8; 
    }
    return self.screenPopsOpenWithin__v;
}
        

-(void)setScreenPopsOpenWithin:(NSString *)v {
    self.screenPopsOpenWithin__v = v;
    fields__set[0] |= 0x8; 
}
        

-(NSArray *)sections {
    if ((fields__set[0] & 0x10) == 0) {
        self.sections__v = [self complexTypeArrayFromElements:@"sections" cls:[ZKDescribeSoftphoneLayoutSection class]];
        fields__set[0] |= 0x10; 
    }
    return self.sections__v;
}
        

-(void)setSections:(NSArray *)v {
    self.sections__v = v;
    fields__set[0] |= 0x10; 
}
        
-(void)serializeTo:(ZKXmlWriter *)env elemName:(NSString *)elemName {
	[env startElement:elemName];
	[env addElementArray:@"infoFields"       elemValue:self.infoFields];
	[env addElement:@"name"                  elemValue:self.name                 nillable:NO  optional:NO];
	[env addElementArray:@"screenPopOptions" elemValue:self.screenPopOptions];
	[env addElement:@"screenPopsOpenWithin"  elemValue:self.screenPopsOpenWithin nillable:NO  optional:YES];
	[env addElementArray:@"sections"         elemValue:self.sections];
	[env endElement:elemName];
}
@end
