//
//  rtmAppDelegate.h
//  rtm
//
//  Created by 下村 翔 on 6/19/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "OverViewController.h"
#import "ListViewController.h"
#import "TagViewController.h"
#import "SearchViewController.h"

@interface rtmAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
	OverViewController *overViewController;
	ListViewController *listViewController;
	TagViewController *tagViewController;
	SearchViewController *searchViewController;
	
	NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;	    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) IBOutlet OverViewController *overViewController;
@property (nonatomic, retain) IBOutlet ListViewController *listViewController;
@property (nonatomic, retain) IBOutlet TagViewController *tagViewController;
@property (nonatomic, retain) IBOutlet SearchViewController *searchViewController;

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, readonly) NSString *applicationDocumentsDirectory;

@end
