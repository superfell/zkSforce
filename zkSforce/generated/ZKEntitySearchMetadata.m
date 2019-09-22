// Copyright (c) 2017 Simon Fell
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

#import "ZKEntitySearchMetadata.h"
#import "ZKEntityErrorMetadata.h"
#import "ZKEntityIntentQueryMetadata.h"
#import "ZKEntitySearchPromotionMetadata.h"
#import "ZKEntitySpellCorrectionMetadata.h"
#import "ZKFieldLevelSearchMetadata.h"

@implementation ZKEntitySearchMetadata

-(NSString *)entityName {
    return [self string:@"entityName"];
}
			
-(ZKEntityErrorMetadata *)errorMetadata {
    return [self complexTypeArrayFromElements:@"errorMetadata" cls:[ZKEntityErrorMetadata class]].lastObject;
}
			
-(NSArray *)fieldMetadata {
    return [self complexTypeArrayFromElements:@"fieldMetadata" cls:[ZKFieldLevelSearchMetadata class]];
}
			
-(ZKEntityIntentQueryMetadata *)intentQueryMetadata {
    return [self complexTypeArrayFromElements:@"intentQueryMetadata" cls:[ZKEntityIntentQueryMetadata class]].lastObject;
}
			
-(ZKEntitySearchPromotionMetadata *)searchPromotionMetadata {
    return [self complexTypeArrayFromElements:@"searchPromotionMetadata" cls:[ZKEntitySearchPromotionMetadata class]].lastObject;
}
			
-(ZKEntitySpellCorrectionMetadata *)spellCorrectionMetadata {
    return [self complexTypeArrayFromElements:@"spellCorrectionMetadata" cls:[ZKEntitySpellCorrectionMetadata class]].lastObject;
}
			
@end
