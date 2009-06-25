//
//  RtmListParser.m
//  rtm
//
//  Created by 下村 翔 on 6/25/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "RtmListParser.h"

@implementation RtmListParser

@synthesize managedObjectContext;

TaskList *newlistEntity;

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
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
	if ([elementName isEqualToString:@"list"]) {
		newlistEntity = [NSEntityDescription
						 insertNewObjectForEntityForName:@"TaskList"
						 inManagedObjectContext:[self managedObjectContext]];
		newlistEntity.listId = [attributeDict objectForKey:@"id"];
		newlistEntity.name = [attributeDict objectForKey:@"name"];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceUR
 qualifiedName:(NSString *)qName
{
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
}

@end
