//
//  rtmAppDelegate.m
//  rtm
//
//  Created by 下村 翔 on 6/7/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "rtmAppDelegate.h"
#import <CommonCrypto/CommonDigest.h>
#import "WebViewController.h"
#import "AuthParser.h"

@implementation rtmAppDelegate

@synthesize window;
@synthesize tabBarController;

static NSString *apiKey = @"5a98a85fa1591ea18410784a2fd97669";
static NSString *token = @"";

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

- (NSString *)prepareFrob
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
	NSString *frob = [frobParser result];
	NSLog(@"frob is %@", frob);
	
	return frob;
}

- (void)authorizeFrob:(NSString *)frob
{
	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
	[params setObject:apiKey forKey:@"api_key"];
	[params setObject:@"read" forKey:@"perms"];
	[params setObject:frob forKey:@"frob"];
	NSString *requestURL = [@"http://www.rememberthemilk.com/services/auth/?"
				  stringByAppendingString:[self createRtmQuery:params]];
	NSLog(@"REQUEST: %@", requestURL);
	
	WebViewController *webcontroller =
		[[WebViewController alloc] initWithNibName:@"WebView" bundle:nil];
	[webcontroller setUrl:requestURL];
	[webcontroller setFrob:frob];
	[webcontroller setAppDelegate:self];
	[self.tabBarController presentModalViewController:webcontroller animated:YES];
}

- (BOOL)prepareToken:(NSString *)frob
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
		return NO;
	} else {
		NSLog(@"token is %@", token);
		
		//Save token
		NSLog(@"Saving your token: %@", token);
		[[NSUserDefaults standardUserDefaults] setObject:token forKey:@"myToken"];
		[[NSUserDefaults standardUserDefaults] synchronize];
		
		NSLog(@"Preparation is all done");
		//[self updateAllListsAndTasks:self];
		
		// stamp the time of last sync
		NSLog(@"now: %@", [NSDate date]);
		
//		[[NSUserDefaults standardUserDefaults]
//		 setObject:[[NSDate date] description] forKey:@"lastupdate"];
		
		return YES;
	}
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    // Add the tab bar controller's current view as a subview of the window
    [window addSubview:tabBarController.view];

	// remove token (for test)
	//[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"myToken"];
	
	// prepare token of Remember the Milk
	token = [[NSUserDefaults standardUserDefaults] objectForKey:@"myToken"];
	if (token) {
		NSLog(@"Token is found in defaults: %@", token);
	} else {
		[self authorizeFrob:[self prepareFrob]];
	}
}


/*
// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
}
*/

/*
// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
}
*/


- (void)dealloc {
    [tabBarController release];
    [window release];
    [super dealloc];
}

@end

