//
//  ListDetailViewController.h
//  rtm
//
//  Created by 下村 翔 on 6/25/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "TaskSeries.h"

@interface ListDetailViewController : UIViewController {
	IBOutlet UINavigationBar *navigationBar;
	IBOutlet UITableView *myTableView;
	
	NSMutableArray *taskSeriesArray;
	NSManagedObjectContext *managedObjectContext;
	NSMutableString *listName;
}

@property (retain, nonatomic, readonly) UINavigationBar *navigationBar;
@property (retain, nonatomic) UITableView *myTableView;
@property (retain, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (retain, nonatomic, readonly) NSArray *taskSeriesArray;
@property (retain, nonatomic) NSMutableString *listName;

-(void)updateTaskSeriesArray;

@end
