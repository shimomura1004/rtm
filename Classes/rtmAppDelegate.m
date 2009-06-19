//
//  rtmAppDelegate.m
//  rtm
//
//  Created by 下村 翔 on 6/19/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "rtmAppDelegate.h"
#import "RtmController.h"

@implementation rtmAppDelegate

@synthesize window;
@synthesize tabBarController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    // Add the tab bar controller's current view as a subview of the window
    [window addSubview:tabBarController.view];

	// remove token (for test)
	//[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"myToken"];
	
	// prepare token of Remember the Milk
	RtmController *rtmController = [RtmController defaultRtmController];
	[rtmController setTabBarController:tabBarController];
	[rtmController checkToken];
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

