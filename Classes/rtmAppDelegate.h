//
//  rtmAppDelegate.h
//  rtm
//
//  Created by 下村 翔 on 6/19/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface rtmAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
	
	NSString *frob;
	NSString *token;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (retain) NSString *frob;
@property (retain) NSString *token;

- (void)prepareToken:(NSNotification *)notification;

@end
