//
//  RtmController.h
//  rtm
//
//  Created by 下村 翔 on 6/20/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RtmController : NSObject {
	UITabBarController *tabBarController;
	
	NSString *frob;
	NSString *token;
}

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (retain) NSString *frob;
@property (retain) NSString *token;

+ (RtmController *)defaultRtmController;
- (void)checkToken;
- (void)updateAllListsAndTasks;

@end
