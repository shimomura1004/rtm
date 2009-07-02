//
//  RtmController.m
//  rtm
//
//  Created by 下村 翔 on 6/20/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "RtmController.h"

@implementation RtmController

@synthesize tabBarController;
@synthesize frob, token;
@synthesize managedObjectContext;

static NSString *apiKey = @"5a98a85fa1591ea18410784a2fd97669";
static RtmController *rtmController;

+ (RtmController *)defaultRtmController
{
	if (!rtmController) {
		rtmController = [[RtmController alloc] init];
	}
	return rtmController;
}

- (NSString *) createMD5String:(NSString *)orig {
	const char *test_cstr = [orig UTF8String];
	unsigned char md5_result[CC_MD5_DIGEST_LENGTH];
	CC_MD5(test_cstr, strlen(test_cstr), md5_result);
	char md5cstring[CC_MD5_DIGEST_LENGTH*2];
	for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
		sprintf(md5cstring+i*2, "%02x", md5_result[i]);
	}
	return [NSString stringWithCString:md5cstring length:CC_MD5_DIGEST_LENGTH*2];
}

- (NSString *) createRtmQuery:(NSDictionary *)params
{
	NSString *secret = @"b16393df7a139ec4";
	NSArray *keys = [[params allKeys] sortedArrayUsingSelector:@selector(compare:)];
	NSMutableString *signature = [NSMutableString stringWithString:secret];
	
	// prepare api_sig
	for (NSString *key in keys)
	{
		NSString *val = [params objectForKey:key];
		[signature appendString:key];
		[signature appendString:val];
	}
	NSString *apiSig = [self createMD5String:signature];
	
	// prepare query
	NSMutableArray *pairs = [NSMutableArray arrayWithCapacity:5];
	[pairs addObject:[@"api_sig=" stringByAppendingString:apiSig]];
	for (NSString *key in keys)
	{
		NSString *val = [params objectForKey:key];
		[pairs addObject:[NSString stringWithFormat:@"%@=%@", key, val]];
	}
	return [pairs componentsJoinedByString:@"&"];
}

- (void)prepareFrob
{
	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
	[params setObject:apiKey forKey:@"api_key"];
	[params setObject:@"rtm.auth.getFrob" forKey:@"method"];
	NSString *requestURL = [@"http://api.rememberthemilk.com/services/rest/?"
							stringByAppendingString:[self createRtmQuery:params]];
	NSXMLParser *parser = [[NSXMLParser alloc]
						   initWithContentsOfURL:[NSURL URLWithString:requestURL]];
	AuthParser *frobParser = [[AuthParser alloc] init];
	[frobParser setTargetTagName:@"frob"];
	[parser setDelegate:frobParser];
	[parser parse];
	[self setFrob:[frobParser result]];
	NSLog(@"frob is %@", frob);
}

- (void)authorizeFrob
{
	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
	[params setObject:apiKey forKey:@"api_key"];
	[params setObject:@"read" forKey:@"perms"];
	[params setObject:frob forKey:@"frob"];
	NSString *requestURL = [@"http://www.rememberthemilk.com/services/auth/?"
							stringByAppendingString:[self createRtmQuery:params]];
	NSLog(@"REQUEST: %@", requestURL);
	
	AuthorizeViewController *authController =
	[[AuthorizeViewController alloc] initWithNibName:@"AuthorizeView" bundle:nil];
	[authController setUrl:requestURL];
	[[NSNotificationCenter defaultCenter]
	 addObserver:self selector:@selector(prepareToken:)
	 name:@"DidFrobAuthorizationFinished" object:nil];
	[self.tabBarController presentModalViewController:authController animated:YES];
}

- (void)prepareToken:(NSNotification *)notification
{
	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
	[params setObject:apiKey forKey:@"api_key"];
	[params setObject:@"rtm.auth.getToken" forKey:@"method"];
	[params setObject:frob forKey:@"frob"];
	NSString *requestURL = [@"http://api.rememberthemilk.com/services/rest/?"
							stringByAppendingString:[self createRtmQuery:params]];
	NSXMLParser *parser = [[NSXMLParser alloc]
						   initWithContentsOfURL:[NSURL URLWithString:requestURL]];
	AuthParser *tokenParser = [[AuthParser alloc] init];
	[tokenParser setTargetTagName:@"token"];
	[parser setDelegate:tokenParser];
	[parser parse];
	token = [tokenParser result];
	
	if ([token isEqualToString:@""])
	{
		NSLog(@"Authorization failed");
	} else {
		NSLog(@"Saving your token: %@", token);
		[[NSUserDefaults standardUserDefaults] setObject:token forKey:@"myToken"];
		[[NSUserDefaults standardUserDefaults] synchronize];
		NSLog(@"Preparation is all done");		
		[self.tabBarController dismissModalViewControllerAnimated:YES];
	}
}

- (void) checkToken
{
	[self setToken:[[NSUserDefaults standardUserDefaults] objectForKey:@"myToken"]];
	if (token) {
		NSLog(@"Token is found in defaults: %@", token);
	} else {
		NSLog(@"Token is not found!");
		[self prepareFrob];
		[self authorizeFrob];
	}
}

-(void)updateTaskList
{
	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
	[params setObject:apiKey forKey:@"api_key"];
	[params setObject:@"rtm.lists.getList" forKey:@"method"];
	[params setObject:token forKey:@"auth_token"];
	NSString *requestURL = [@"http://api.rememberthemilk.com/services/rest/?"
							stringByAppendingString:[self createRtmQuery:params]];
	NSXMLParser *parser = [[NSXMLParser alloc]
						   initWithContentsOfURL:[NSURL URLWithString:requestURL]];
	RtmListParser *listParser = [[RtmListParser alloc] init];
	[listParser setManagedObjectContext:[self managedObjectContext]];
	[parser setDelegate:listParser];
	[parser parse];
	
	// TODO: display animation while loading
	NSLog(@"Complete: update all lists");
	
	[[NSNotificationCenter defaultCenter]
	 postNotification:[NSNotification
					   notificationWithName:@"DidTaskListUpdated" object:nil]];
}

-(void) updateTasks:(TaskList *)taskList
{
	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
	[params setObject:apiKey forKey:@"api_key"];
	[params setObject:[taskList listId] forKey:@"list_id"];
	[params setObject:@"rtm.tasks.getList" forKey:@"method"];
	[params setObject:token forKey:@"auth_token"];
	NSString *requestURL = [@"http://api.rememberthemilk.com/services/rest/?"
							stringByAppendingString:[self createRtmQuery:params]];
	NSXMLParser *parser = [[NSXMLParser alloc]
						   initWithContentsOfURL:[NSURL URLWithString:requestURL]];
	RtmTaskParser *taskParser = [[RtmTaskParser alloc] init];
	[taskParser setManagedObjectContext:[self managedObjectContext]];
	[taskParser setTaskList:taskList];
	[parser setDelegate:taskParser];
	[parser parse];
	
	NSLog(@"Complete: update all tasks(%@)", [taskList name]);
	// update model of tasks and of tags
}

-(void) updateAllTasks
{
	NSManagedObjectContext *context = [self managedObjectContext];
	NSFetchRequest *req = [[NSFetchRequest alloc] init];
	[req setEntity:[NSEntityDescription entityForName:@"TaskList" inManagedObjectContext:context]];
	for (TaskList *taskList in [context executeFetchRequest:req error:nil])
	{
		NSLog(@"GETTING: %@", [taskList name]);
		// do not get task if list is 'All Tasks'
		if (![[taskList name] isEqualToString:@"All Tasks"])
		{
			[self updateTasks:taskList];
		}
	}
	NSLog(@"Complete: update all tasks");
}

-(void) updateAllListsAndTasks
{
	NSManagedObjectContext *context = [self managedObjectContext];
	
	NSLog(@"Delete all TaskSeries");
		NSFetchRequest *req = [[NSFetchRequest alloc] init];
		[req setEntity:[NSEntityDescription entityForName:@"TaskSeries" inManagedObjectContext:context]];
		for (TaskSeries *taskSeries in [context executeFetchRequest:req error:nil])
		{
			[context deleteObject:taskSeries];
		}
		
	NSLog(@"Delete all Tasks");
		req = [[NSFetchRequest alloc] init];
		[req setEntity:[NSEntityDescription entityForName:@"Task" inManagedObjectContext:context]];
		for (Task *task in [context executeFetchRequest:req error:nil])
		{
			[context deleteObject:task];
		}
	
	NSLog(@"Delete all TaskLists");
		req = [[NSFetchRequest alloc] init];
		[req setEntity:[NSEntityDescription entityForName:@"TaskList" inManagedObjectContext:context]];
		for (TaskList *list in [context executeFetchRequest:req error:nil])
		{
			[context deleteObject:list];
		}

	
	[self updateTaskList];
	[self updateAllTasks];
}


@end
