// Copyright (c) 2021 Simon Fell
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

#import "ZKComplexTypeFieldInfo.h"

@protocol ZKComplexTypeProvider
+(ZKComplexTypeInfo*)wsdlSchema;
@end

@interface ZKComplexTypeFieldInfo()
@property (strong)    NSString    *elementName;
@property (strong)    NSString    *propertyName;
@property (assign)    BOOL        optional;
@property (assign)    BOOL        nillable;
@end

@implementation ZKComplexTypeFieldInfo
-(instancetype)initWithElementName:(NSString *)e
                      propertyName:(NSString *)p
                          optional:(BOOL)opt
                          nillable:(BOOL)n {
    self = [super init];
    self.elementName = e;
    self.propertyName = p;
    self.optional = opt;
    self.nillable = n;
    return self;
}

@end

@interface ZKComplexTypeInfo()
@property (strong) NSString *xmlType;
@property (strong) Class parentClass;
@property (strong) NSArray<ZKComplexTypeFieldInfo*> *fields;
@end

@implementation ZKComplexTypeInfo

-(instancetype)initWithType:(NSString *)t parent:(Class)parentClass fields:(NSArray<ZKComplexTypeFieldInfo*>*)fields {
    self = [super init];
    self.xmlType = t;
    self.parentClass = parentClass;
    self.fields = fields;
    return self;
}

-(ZKComplexTypeInfo*)parentType {
    return [self.parentClass wsdlSchema];
}

-(NSArray<ZKComplexTypeFieldInfo*>*) fieldsIncludingParents {
    NSArray *f = self.fields;
    ZKComplexTypeInfo *t = self.parentType;
    while (t != nil) {
        f = [f arrayByAddingObjectsFromArray:t.fields];
        t = t.parentType;
    }
    return f;
}

@end
