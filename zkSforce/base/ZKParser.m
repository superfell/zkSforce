// Copyright (c) 2008-2010,2016 Simon Fell
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

#import "ZKParser.h"
#import "ZKConstants.h"

@implementation ZKElement

-(instancetype)initWithDocument:(xmlDocPtr)d node:(xmlNodePtr)n parent:(ZKElement *)p {
    self = [super init];
    parent = p;
    doc = d;
    node = n;
    return self;
}

-(instancetype)initWithDocument:(xmlDocPtr)d {
    return [self initWithDocument:d node:xmlDocGetRootElement(d) parent:nil];
}

-(instancetype)initWithNode:(xmlNodePtr)n parent:(ZKElement *)p {
    return [self initWithDocument:nil node:n parent:p];
}

-(id)copyWithZone:(NSZone *)z {
    return [[ZKElement allocWithZone:z] initWithDocument:doc node:node parent:parent == nil ? self : parent];
}

-(void)dealloc {
    xmlFreeDoc(doc);
}

- (NSString *)name {
    return @((const char *)node->name);
}

- (NSString *)namespace {
    return @((const char *)node->ns->href);
}

- (NSString *)stringValue {
    xmlChar *v = xmlNodeListGetString(doc, node->xmlChildrenNode, 1);
    NSString *s = v == NULL ? nil : @((const char *)v);
    xmlFree(v);
    return s;
}

- (NSString *)attributeValue:(NSString *)name ns:(NSString *)namespace {
    const xmlChar * n = (const xmlChar *)name.UTF8String;
    const xmlChar * ns = (const xmlChar *)namespace.UTF8String;
    xmlChar *v = xmlGetNsProp(node, n, ns);
    if (v == NULL) return nil;
    NSString *sv = @((const char *)v);
    xmlFree(v);
    return sv;
}

- (id)childElements:(NSString *)name ns:(NSString *)namespace checkNs:(BOOL)checkNs all:(BOOL)returnAll {
    NSMutableArray *results = returnAll ? [NSMutableArray array] : nil;
    const xmlChar * n = (const xmlChar *)name.UTF8String;
    const xmlChar * ns = (const xmlChar *)namespace.UTF8String;
    xmlNodePtr cur = node->xmlChildrenNode;
    while (cur != NULL) {
        if ((n == NULL) || (!xmlStrcmp(cur->name, n))) {
            if((!checkNs) || (!xmlStrcmp(cur->ns->href, ns))) {
                ZKElement *e = [[ZKElement alloc] initWithNode:cur parent:self];
                if (!returnAll) return e;
                [results addObject:e];
            }
         }
        cur = cur->next;
    }
    return results;
}

- (ZKElement *)childElement:(NSString *)name ns:(NSString *)namespace {
    return [self childElements:name ns:namespace checkNs:YES all:NO];
}

- (ZKElement *)childElement:(NSString *)name {
    return [self childElements:name ns:nil checkNs:NO all:NO];
}

- (NSArray *)childElements:(NSString *)name ns:(NSString *)namespace {
    return [self childElements:name ns:namespace checkNs:YES all:YES];
}

- (NSArray *)childElements:(NSString *)name {
    return [self childElements:name ns:nil checkNs:NO all:YES];
}

- (NSArray *)childElements {
    return [self childElements:nil ns:nil checkNs:NO all:YES];
}

- (ZKNamespacedName *)xsiType {
    NSString *t = [self attributeValue:@"type" ns:NS_URI_XSI];
    if (t.length == 0) {
        return nil;
    }
    NSArray *typeParts = [t componentsSeparatedByString:@":"];
    xmlChar *prefix = NULL;
    if (typeParts.count == 2) {
        prefix = (xmlChar *)[typeParts[0] UTF8String];
    }
    const xmlNsPtr ns = xmlSearchNs(node->doc, node, prefix);
    NSString *uri = ns == NULL ? @"" : @((const char *)ns->href);
    return [ZKNamespacedName withName:typeParts.lastObject uri:uri];
}

- (BOOL)isXsiNil {
    NSString *n = [self attributeValue:@"nil" ns:NS_URI_XSI];
    return n != nil && ([n caseInsensitiveCompare:@"true"] == NSOrderedSame || [n isEqualToString:@"1"]);
}

@end

@implementation ZKParser

+(ZKElement *)parseData:(NSData *)data {
    xmlDocPtr doc = xmlReadMemory(data.bytes, (int)data.length, "noname.xml", NULL, 0);
    if (doc != nil)
        return [[ZKElement alloc] initWithDocument:doc];
    return nil;
}

@end

@implementation ZKNamespacedName

-(instancetype)initWithName:(NSString *)localName uri:(NSString *)nsuri {
    self = [super init];
    name = localName;
    uri = nsuri;
    return self;
}

-(id)copyWithZone:(NSZone *)zone {
    return [ZKNamespacedName withName:name uri:uri];
}

+(ZKNamespacedName *)withName:(NSString*)localName uri:(NSString *)uri {
    return [[ZKNamespacedName alloc] initWithName:localName uri:uri];
}

-(NSString *)namespaceURI {
    return uri;
}

-(NSString *)localname {
    return name;
}

-(NSString *)description {
    return [NSString stringWithFormat:@"%@:%@", uri, name];
}
@end
