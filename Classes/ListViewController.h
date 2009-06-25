//
//  ListViewController.h
//  rtm
//
//  Created by 下村 翔 on 6/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "TaskList.h"

@interface ListViewController : UIViewController {
	IBOutlet UITableView *myTableView;
	NSMutableArray *listArray;

	NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) UITableView *myTableView;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSArray *listArray;

-(void)applicationDidFinishLaunching:(UIApplication *)application;
-(IBAction)refreshAllListsAndTasks:sender;
-(void)updateListArray;

@end
