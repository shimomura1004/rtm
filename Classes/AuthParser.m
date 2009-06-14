//
//  AuthParser.m
//  rtm
//
//  Created by 下村 翔 on 6/14/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "AuthParser.h"

@implementation AuthParser

@synthesize result;
@synthesize targetTagName;

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
	result = @"";
	inTargetTag = NO;
}

- (void)parseXMLFileAtURL:(NSURL *)URL parseError:(NSError **)error
{
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:URL];
    [parser setDelegate:self];
    [parser setShouldProcessNamespaces:NO];
    [parser setShouldReportNamespacePrefixes:NO];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
    NSError *parseError = [parser parserError];
    if (parseError && error) {
        *error = parseError;
    }
    [parser release];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
	attributes:(NSDictionary *)attributeDict
{
	if ([elementName isEqualToString:targetTagName])
	{
		inTargetTag = YES;
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceUR
 qualifiedName:(NSString *)qName
{
	if ([elementName isEqualToString:targetTagName])
	{
		inTargetTag = NO;
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	if (inTargetTag) {
		result = string;
	}
}

@end