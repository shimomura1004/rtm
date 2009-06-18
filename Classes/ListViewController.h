//
//  ListViewController.h
//  rtm
//
//  Created by 下村 翔 on 6/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface ListViewController : UIViewController {
	NSEntityDescription *listEntity;
	IBOutlet UITableView *myTableView;

    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator;
- (NSManagedObjectModel *)managedObjectModel;
- (NSManagedObjectContext *)managedObjectContext;

@property (nonatomic, retain) UITableView *myTableView;
@property (retain) NSEntityDescription *listEntity;

@end
