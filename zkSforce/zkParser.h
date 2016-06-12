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

#include <libxml/parser.h>

FOUNDATION_EXPORT NSString *const NS_URI_XSI;
FOUNDATION_EXPORT NSString *const NS_URI_XSD;

@class ZKNamespacedName;

@interface zkElement : NSObject <NSCopying> {
	xmlDocPtr	doc;
	xmlNodePtr	node;
	zkElement	*parent;
}
/** @return the name of this element */
- (NSString *)name;
/** @return the namespace URI of this element */
- (NSString *)namespace;

/** @return the stringValue of this element [i.e. its child text] */
- (NSString *)stringValue;

/** @return the first child element with this local name */
- (zkElement *)childElement:(NSString *)name;

/** @return the first child element with this name */
- (zkElement *)childElement:(NSString *)name ns:(NSString *)namespace;

/** @return all the child elements with this local name */
- (NSArray *)childElements:(NSString *)name;

/** @return all the child elements with this name */
- (NSArray *)childElements:(NSString *)name ns:(NSString *)namespace;

/** @return all teh child elements */
- (NSArray *)childElements;

/** @return the value of the named attributed */
- (NSString *)attributeValue:(NSString *)name ns:(NSString *)namespace;

/** @return the namespace URI & localname of the xsi:type attribute if it exists, or nil otherwise */
- (ZKNamespacedName *)xsiType;

/** @return TRUE if the element has an xsi:nil="true" attribute */
- (BOOL)isXsiNil;
@end;

@interface zkParser : NSObject {
}
/** @return the root element of the parsed XML Data */
+(zkElement *)parseData:(NSData *)data;
@end

/** ZKNamespacedName is represented a namesapce name, 
    i.e. it has a URI representing a namespace, 
    and a localname within that namespace */
@interface ZKNamespacedName : NSObject<NSCopying> {
    NSString *uri;
    NSString *name;
}

+(ZKNamespacedName *)withName:(NSString*)localName uri:(NSString *)uri;

/** @return the namespace URI of this value */
@property (readonly) NSString *namespaceURI;

/** @return the localname of this value */
@property (readonly) NSString *localname;

@end