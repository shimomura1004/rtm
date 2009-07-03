//
//  RtmTaskParser.h
//  rtm
//
//  Created by 下村 翔 on 7/2/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "TaskSeries.h"
#import "TaskList.h"
#import "Task.h"
#import "Tag.h"
#import "Note.h"

@interface RtmTaskParser : NSObject {
	NSManagedObjectContext *managedObjectContext;
	TaskList *taskList;
	Task *task;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (retain) TaskList *taskList;
@property (retain) Task *task;

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
- (void)parserDidEndDocument:(NSXMLParser *)parser;

@end
