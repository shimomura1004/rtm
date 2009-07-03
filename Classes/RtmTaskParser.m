//
//  RtmTaskParser.m
//  rtm
//
//  Created by 下村 翔 on 7/2/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "RtmTaskParser.h"


@implementation RtmTaskParser

@synthesize managedObjectContext, taskList, task;

TaskSeries *newTaskSeries;
Task *newTask;
enum Status {
	none,
	inTag,
	inNote
} status;
NSMutableArray *tags;

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
	status = none;
	
	tags = [[NSMutableArray alloc] init];
	NSFetchRequest *req = [[NSFetchRequest alloc] init];
	[req setEntity:[NSEntityDescription entityForName:@"Tag" inManagedObjectContext:managedObjectContext]];
	for (Tag *tag in [managedObjectContext executeFetchRequest:req error:nil])
	{
		[tags addObject:tag.name];
	}
	[tags sortUsingSelector:@selector(compare:)];
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
	if ([elementName isEqualToString:@"taskseries"]) {
		newTaskSeries = [NSEntityDescription
									 insertNewObjectForEntityForName:@"TaskSeries"
									 inManagedObjectContext:[self managedObjectContext]];
		NSDateFormatter *df = [[[NSDateFormatter alloc] init] autorelease];
		[df setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];

		newTaskSeries.created = [df dateFromString:[attributeDict objectForKey:@"created"]];
		newTaskSeries.modified = [df dateFromString:[attributeDict objectForKey:@"modified"]];
		newTaskSeries.name = [attributeDict objectForKey:@"name"];
		newTaskSeries.taskseriesId = [attributeDict objectForKey:@"id"];
		newTaskSeries.source = [attributeDict objectForKey:@"source"];
		newTaskSeries.url = [attributeDict objectForKey:@"url"];
		
		newTaskSeries.location = nil;//[attributeDict objectForKey:@""];
		newTaskSeries.notes = nil;
		newTaskSeries.participants = nil;
		newTaskSeries.tags = nil;
		newTaskSeries.taskList = taskList;
		newTaskSeries.tasks = nil;
//		NSLog(@"%@, (%@)", newTaskSeries.name, newTaskSeries.created);
	} else if ([elementName isEqualToString:@"tag"]) {
		status = inTag;
//	} else if ([elementName isEqualToString:@"participants"]) {
//		// should i support?
	} else if ([elementName isEqualToString:@"note"]) {
		status = inNote;
	} else if ([elementName isEqualToString:@"task"]) {
		newTask = [NSEntityDescription
						 insertNewObjectForEntityForName:@"Task"
						 inManagedObjectContext:[self managedObjectContext]];
		NSDateFormatter *df = [[[NSDateFormatter alloc] init] autorelease];
		[df setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
		
		newTask.added = [df dateFromString:[attributeDict objectForKey:@"added"]];
		newTask.completed = [df dateFromString:[attributeDict objectForKey:@"completed"]];
		newTask.deleted = [df dateFromString:[attributeDict objectForKey:@"deleted"]];
		newTask.due = [attributeDict objectForKey:@"due"];
		newTask.estimate = [attributeDict objectForKey:@"estimate"];
		newTask.hasDueTime = [attributeDict objectForKey:@"hasDueTime"];
		newTask.postponed = [NSNumber numberWithInt:[[attributeDict objectForKey:@"postponed"] intValue]];
		newTask.priority = [NSNumber numberWithInt:[[attributeDict objectForKey:@"priority"] intValue]];
		newTask.taskId = [attributeDict objectForKey:@"id"];
		newTask.taskseries = newTaskSeries;
	} else {
//		NSLog(@"NAME: %@", elementName);
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceUR
 qualifiedName:(NSString *)qName
{
	if ([elementName isEqualToString:@"tag"]) {
		status = none;
	} else if ([elementName isEqualToString:@"note"]) {
		status = none;
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	switch(status) {
		case inTag:
			if (![tags containsObject:string]) {
				Tag *newTag = [NSEntityDescription
							  insertNewObjectForEntityForName:@"Tag"
							  inManagedObjectContext:managedObjectContext];
				newTag.name = string;
				[tags addObject:string];
			}
			// add tag to taskseries
			break;
		case inNote:
			Note *newNote = [NSEntityDescription
							 insertNewObjectForEntityForName:@"Note"
							 inManagedObjectContext:managedObjectContext];
			newNote.body = string;
			// add note to taskseries
			break;
		default:
			break;
	}
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
	// update db
}

@end
