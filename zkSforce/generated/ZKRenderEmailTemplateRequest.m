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

#import "ZKRenderEmailTemplateRequest.h"
#import "ZKEnvelope.h"

@interface ZKRenderEmailTemplateRequest()
@property (assign,nonatomic) BOOL                  escapeHtmlInMergeFields__v;
@property (strong,nonatomic) NSArray<NSString *>  *templateBodies__v;
@property (strong,nonatomic) NSString             *whatId__v;
@property (strong,nonatomic) NSString             *whoId__v;
@end

@implementation ZKRenderEmailTemplateRequest


+(void)load {
    [self registerType:self xmlName:@"RenderEmailTemplateRequest"];
}

+(ZKComplexTypeInfo *)wsdlSchema {
   static ZKComplexTypeInfo *wsdlSchema;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
       wsdlSchema = [[ZKComplexTypeInfo alloc] initWithType:@"RenderEmailTemplateRequest" parent:nil
                    fields:@[
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"escapeHtmlInMergeFields" propertyName:@"escapeHtmlInMergeFields" optional:YES nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"templateBodies" propertyName:@"templateBodies" optional:NO nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"whatId" propertyName:@"whatId" optional:YES nillable:NO],
                        [[ZKComplexTypeFieldInfo alloc] initWithElementName:@"whoId" propertyName:@"whoId" optional:YES nillable:NO],

                    ]];
   });
   return wsdlSchema;
}
    

-(BOOL)escapeHtmlInMergeFields {
    if ((fields__set[0] & 0x1) == 0) {
        self.escapeHtmlInMergeFields__v = [self boolean:@"escapeHtmlInMergeFields"];
        fields__set[0] |= 0x1;
    }
    return self.escapeHtmlInMergeFields__v;
}

-(void)setEscapeHtmlInMergeFields:(BOOL)v {
    self.escapeHtmlInMergeFields__v = v;
    fields__set[0] |= 0x1;
}


-(NSArray<NSString *> *)templateBodies {
    if ((fields__set[0] & 0x2) == 0) {
        self.templateBodies__v = [self strings:@"templateBodies"];
        fields__set[0] |= 0x2;
    }
    return self.templateBodies__v;
}

-(void)setTemplateBodies:(NSArray<NSString *> *)v {
    self.templateBodies__v = v;
    fields__set[0] |= 0x2;
}


-(NSString *)whatId {
    if ((fields__set[0] & 0x4) == 0) {
        self.whatId__v = [self string:@"whatId"];
        fields__set[0] |= 0x4;
    }
    return self.whatId__v;
}

-(void)setWhatId:(NSString *)v {
    self.whatId__v = v;
    fields__set[0] |= 0x4;
}


-(NSString *)whoId {
    if ((fields__set[0] & 0x8) == 0) {
        self.whoId__v = [self string:@"whoId"];
        fields__set[0] |= 0x8;
    }
    return self.whoId__v;
}

-(void)setWhoId:(NSString *)v {
    self.whoId__v = v;
    fields__set[0] |= 0x8;
}

-(void)serializeTo:(ZKXmlWriter *)env elemName:(NSString *)elemName {
	[env startElement:elemName];
	[env addBoolElement:@"escapeHtmlInMergeFields" elemValue:self.escapeHtmlInMergeFields];
	[env addElementArray:@"templateBodies"         elemValue:self.templateBodies];
	[env addElement:@"whatId"                      elemValue:self.whatId                  nillable:NO  optional:YES];
	[env addElement:@"whoId"                       elemValue:self.whoId                   nillable:NO  optional:YES];
	[env endElement:elemName];
}
@end
