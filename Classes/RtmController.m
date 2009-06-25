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

-(void) updateTasks:(NSString *)taskListName
{
}

-(void) updateAllTasks
{
	// for each (taskListName in TasksList) [self updateTasks:taskListName];
	NSLog(@"Complete: update all tasks");
}

-(void) updateAllListsAndTasks
{
	// first, remove all lists and tasks
	NSManagedObjectContext *context = [self managedObjectContext];
	
	//	NSLog(@"Delete all tasks");
	//	self.statusText = @"Delete all tasks";
	//	[statusField display];
	//	NSFetchRequest *req = [[NSFetchRequest alloc] init];
	//	[req setEntity:[NSEntityDescription entityForName:@"Task" inManagedObjectContext:context]];
	//	for (Task *task in [context executeFetchRequest:req error:nil])
	//	{
	//		[context deleteObject:task];
	//	}
	
	NSLog(@"Delete all Lists");
	NSFetchRequest *req = [[NSFetchRequest alloc] init];
	[req setEntity:[NSEntityDescription entityForName:@"TaskList" inManagedObjectContext:context]];
	for (TaskList *list in [context executeFetchRequest:req error:nil])
	{
		[context deleteObject:list];
	}

	
	[self updateTaskList];
	[self updateAllTasks];
}


@end
