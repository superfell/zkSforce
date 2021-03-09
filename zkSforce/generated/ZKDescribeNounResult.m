// Copyright (c) 2015 Simon Fell
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

#import "ZKDescribeNounResult.h"
#import "ZKEnvelope.h"
#import "ZKNameCaseValue.h"

@interface ZKDescribeNounResult()
@property (strong,nonatomic) NSArray   *caseValues__v;
@property (strong,nonatomic) NSString  *developerName__v;
@property (strong,nonatomic) NSString  *gender__v;
@property (strong,nonatomic) NSString  *name__v;
@property (strong,nonatomic) NSString  *pluralAlias__v;
@property (strong,nonatomic) NSString  *startsWith__v;
@end

@implementation ZKDescribeNounResult


+(void)load {
    [self registerType:self xmlName:@"DescribeNounResult"];
}

-(NSArray *)caseValues {
    if ((fields__set[0] & 0x1) == 0) {
        self.caseValues__v = [self complexTypeArrayFromElements:@"caseValues" cls:[ZKNameCaseValue class]];
        fields__set[0] |= 0x1; 
    }
    return self.caseValues__v;
}
        

-(void)setCaseValues:(NSArray *)v {
    self.caseValues__v = v;
    fields__set[0] |= 0x1; 
}
        

-(NSString *)developerName {
    if ((fields__set[0] & 0x2) == 0) {
        self.developerName__v = [self string:@"developerName"];
        fields__set[0] |= 0x2; 
    }
    return self.developerName__v;
}
        

-(void)setDeveloperName:(NSString *)v {
    self.developerName__v = v;
    fields__set[0] |= 0x2; 
}
        

-(NSString *)gender {
    if ((fields__set[0] & 0x4) == 0) {
        self.gender__v = [self string:@"gender"];
        fields__set[0] |= 0x4; 
    }
    return self.gender__v;
}
        

-(void)setGender:(NSString *)v {
    self.gender__v = v;
    fields__set[0] |= 0x4; 
}
        

-(NSString *)name {
    if ((fields__set[0] & 0x8) == 0) {
        self.name__v = [self string:@"name"];
        fields__set[0] |= 0x8; 
    }
    return self.name__v;
}
        

-(void)setName:(NSString *)v {
    self.name__v = v;
    fields__set[0] |= 0x8; 
}
        

-(NSString *)pluralAlias {
    if ((fields__set[0] & 0x10) == 0) {
        self.pluralAlias__v = [self string:@"pluralAlias"];
        fields__set[0] |= 0x10; 
    }
    return self.pluralAlias__v;
}
        

-(void)setPluralAlias:(NSString *)v {
    self.pluralAlias__v = v;
    fields__set[0] |= 0x10; 
}
        

-(NSString *)startsWith {
    if ((fields__set[0] & 0x20) == 0) {
        self.startsWith__v = [self string:@"startsWith"];
        fields__set[0] |= 0x20; 
    }
    return self.startsWith__v;
}
        

-(void)setStartsWith:(NSString *)v {
    self.startsWith__v = v;
    fields__set[0] |= 0x20; 
}
        
-(void)serializeTo:(ZKXmlWriter *)env elemName:(NSString *)elemName {
	[env startElement:elemName];
	[env addElementArray:@"caseValues" elemValue:self.caseValues];
	[env addElement:@"developerName"   elemValue:self.developerName nillable:NO  optional:NO];
	[env addElement:@"gender"          elemValue:self.gender        nillable:YES optional:NO];
	[env addElement:@"name"            elemValue:self.name          nillable:NO  optional:NO];
	[env addElement:@"pluralAlias"     elemValue:self.pluralAlias   nillable:YES optional:NO];
	[env addElement:@"startsWith"      elemValue:self.startsWith    nillable:YES optional:NO];
	[env endElement:elemName];
}
@end
