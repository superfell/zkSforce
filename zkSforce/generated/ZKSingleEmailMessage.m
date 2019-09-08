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

#import "ZKSingleEmailMessage.h"
#import "ZKEmailFileAttachment.h"

@implementation ZKSingleEmailMessage

-(NSArray *)bccAddresses {
    return [self strings:@"bccAddresses"];
}
			
-(NSArray *)ccAddresses {
    return [self strings:@"ccAddresses"];
}
			
-(NSString *)charset {
    return [self string:@"charset"];
}
			
-(NSArray *)documentAttachments {
    return [self strings:@"documentAttachments"];
}
			
-(NSArray *)entityAttachments {
    return [self strings:@"entityAttachments"];
}
			
-(NSArray *)fileAttachments {
    return [self complexTypeArrayFromElements:@"fileAttachments" cls:[ZKEmailFileAttachment class]];
}
			
-(NSString *)htmlBody {
    return [self string:@"htmlBody"];
}
			
-(NSString *)inReplyTo {
    return [self string:@"inReplyTo"];
}
			
-(NSString *)optOutPolicy {
    return [self string:@"optOutPolicy"];
}
			
-(NSString *)orgWideEmailAddressId {
    return [self string:@"orgWideEmailAddressId"];
}
			
-(NSString *)plainTextBody {
    return [self string:@"plainTextBody"];
}
			
-(NSString *)references {
    return [self string:@"references"];
}
			
-(NSString *)targetObjectId {
    return [self string:@"targetObjectId"];
}
			
-(NSString *)templateId {
    return [self string:@"templateId"];
}
			
-(NSString *)templateName {
    return [self string:@"templateName"];
}
			
-(NSArray *)toAddresses {
    return [self strings:@"toAddresses"];
}
			
-(BOOL)treatBodiesAsTemplate {
    return [self boolean:@"treatBodiesAsTemplate"];
}
			
-(BOOL)treatTargetObjectAsRecipient {
    return [self boolean:@"treatTargetObjectAsRecipient"];
}
			
-(NSString *)whatId {
    return [self string:@"whatId"];
}
			
@end
