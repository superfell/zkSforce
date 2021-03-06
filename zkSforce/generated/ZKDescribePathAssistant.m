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

#import "ZKDescribePathAssistant.h"
#import "ZKEnvelope.h"
#import "ZKDescribeAnimationRule.h"
#import "ZKDescribePathAssistantStep.h"
#import "ZKPicklistForRecordType.h"

@interface ZKDescribePathAssistant()
@property (assign,nonatomic) BOOL                                     active__v;
@property (strong,nonatomic) NSArray<ZKDescribeAnimationRule *>      *animationRule__v;
@property (strong,nonatomic) NSString                                *apiName__v;
@property (strong,nonatomic) NSString                                *label__v;
@property (strong,nonatomic) NSString                                *pathPicklistField__v;
@property (strong,nonatomic) NSArray<ZKPicklistForRecordType *>      *picklistsForRecordType__v;
@property (strong,nonatomic) NSString                                *recordTypeId__v;
@property (strong,nonatomic) NSArray<ZKDescribePathAssistantStep *>  *steps__v;
@end

@implementation ZKDescribePathAssistant


+(void)load {
    [self registerType:self xmlName:@"DescribePathAssistant"];
}

+(ZKComplexTypeInfo *)wsdlSchema {
   static ZKComplexTypeInfo *wsdlSchema;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
       wsdlSchema = [[ZKComplexTypeInfo alloc] initWithType:@"DescribePathAssistant" parent:nil
                    fields:@[
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"active" propertyName:@"active" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"animationRule" propertyName:@"animationRule" optional:YES nillable:YES],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"apiName" propertyName:@"apiName" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"label" propertyName:@"label" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"pathPicklistField" propertyName:@"pathPicklistField" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"picklistsForRecordType" propertyName:@"picklistsForRecordType" optional:YES nillable:YES],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"recordTypeId" propertyName:@"recordTypeId" optional:NO nillable:YES],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"steps" propertyName:@"steps" optional:YES nillable:NO],

                    ]];
   });
   return wsdlSchema;
}
    

-(BOOL)active {
    if ((fields__set[0] & 0x1) == 0) {
        self.active__v = [self boolean:@"active"];
        fields__set[0] |= 0x1;
    }
    return self.active__v;
}

-(void)setActive:(BOOL)v {
    self.active__v = v;
    fields__set[0] |= 0x1;
}


-(NSArray<ZKDescribeAnimationRule *> *)animationRule {
    if ((fields__set[0] & 0x2) == 0) {
        self.animationRule__v = [self complexTypeArrayFromElements:@"animationRule" cls:[ZKDescribeAnimationRule class]];
        fields__set[0] |= 0x2;
    }
    return self.animationRule__v;
}

-(void)setAnimationRule:(NSArray<ZKDescribeAnimationRule *> *)v {
    self.animationRule__v = v;
    fields__set[0] |= 0x2;
}


-(NSString *)apiName {
    if ((fields__set[0] & 0x4) == 0) {
        self.apiName__v = [self string:@"apiName"];
        fields__set[0] |= 0x4;
    }
    return self.apiName__v;
}

-(void)setApiName:(NSString *)v {
    self.apiName__v = v;
    fields__set[0] |= 0x4;
}


-(NSString *)label {
    if ((fields__set[0] & 0x8) == 0) {
        self.label__v = [self string:@"label"];
        fields__set[0] |= 0x8;
    }
    return self.label__v;
}

-(void)setLabel:(NSString *)v {
    self.label__v = v;
    fields__set[0] |= 0x8;
}


-(NSString *)pathPicklistField {
    if ((fields__set[0] & 0x10) == 0) {
        self.pathPicklistField__v = [self string:@"pathPicklistField"];
        fields__set[0] |= 0x10;
    }
    return self.pathPicklistField__v;
}

-(void)setPathPicklistField:(NSString *)v {
    self.pathPicklistField__v = v;
    fields__set[0] |= 0x10;
}


-(NSArray<ZKPicklistForRecordType *> *)picklistsForRecordType {
    if ((fields__set[0] & 0x20) == 0) {
        self.picklistsForRecordType__v = [self complexTypeArrayFromElements:@"picklistsForRecordType" cls:[ZKPicklistForRecordType class]];
        fields__set[0] |= 0x20;
    }
    return self.picklistsForRecordType__v;
}

-(void)setPicklistsForRecordType:(NSArray<ZKPicklistForRecordType *> *)v {
    self.picklistsForRecordType__v = v;
    fields__set[0] |= 0x20;
}


-(NSString *)recordTypeId {
    if ((fields__set[0] & 0x40) == 0) {
        self.recordTypeId__v = [self string:@"recordTypeId"];
        fields__set[0] |= 0x40;
    }
    return self.recordTypeId__v;
}

-(void)setRecordTypeId:(NSString *)v {
    self.recordTypeId__v = v;
    fields__set[0] |= 0x40;
}


-(NSArray<ZKDescribePathAssistantStep *> *)steps {
    if ((fields__set[0] & 0x80) == 0) {
        self.steps__v = [self complexTypeArrayFromElements:@"steps" cls:[ZKDescribePathAssistantStep class]];
        fields__set[0] |= 0x80;
    }
    return self.steps__v;
}

-(void)setSteps:(NSArray<ZKDescribePathAssistantStep *> *)v {
    self.steps__v = v;
    fields__set[0] |= 0x80;
}

-(void)serializeTo:(ZKXmlWriter *)env elemName:(NSString *)elemName {
	[env startElement:elemName];
	[env addBoolElement:@"active"                  elemValue:self.active];
	[env addElementArray:@"animationRule"          elemValue:self.animationRule];
	[env addElement:@"apiName"                     elemValue:self.apiName                nillable:NO  optional:NO];
	[env addElement:@"label"                       elemValue:self.label                  nillable:NO  optional:NO];
	[env addElement:@"pathPicklistField"           elemValue:self.pathPicklistField      nillable:NO  optional:NO];
	[env addElementArray:@"picklistsForRecordType" elemValue:self.picklistsForRecordType];
	[env addElement:@"recordTypeId"                elemValue:self.recordTypeId           nillable:YES optional:NO];
	[env addElementArray:@"steps"                  elemValue:self.steps];
	[env endElement:elemName];
}
@end
