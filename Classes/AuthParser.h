//
//  AuthParser.h
//  rtm
//
//  Created by 下村 翔 on 6/14/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AuthParser : NSObject {
	NSString *result;
	NSString *targetTagName;
	BOOL inTargetTag;
}

@property (retain) NSString *targetTagName;
@property (retain) NSString *result;

- (void)parserDidStartDocument:(NSXMLParser *)parser;
- (void)parseXMLFileAtURL:(NSURL *)URL parseError:(NSError **)error;
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
	attributes:(NSDictionary *)attributeDict;
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceUR
 qualifiedName:(NSString *)qName;
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string;

@end
