//
//  RtmController.h
//  rtm
//
//  Created by 下村 翔 on 6/20/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <CommonCrypto/CommonDigest.h>
#import "AuthorizeViewController.h"
#import "AuthParser.h"
#import "RtmListParser.h"
#import "RtmTaskParser.h"

#import "TaskList.h"
#import "TaskSeries.h"
#import "Task.h"

@interface RtmController : NSObject {
	UITabBarController *tabBarController;
	
	NSString *frob;
	NSString *token;
	NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (retain) NSString *frob;
@property (retain) NSString *token;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

+ (RtmController *)defaultRtmController;
- (void)checkToken;
- (void)updateAllListsAndTasks;
- (void)updateAllTasks;

@end
