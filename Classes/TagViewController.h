//
//  TagViewController.h
//  rtm
//
//  Created by 下村 翔 on 6/25/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Tag.h"

@interface TagViewController : UIViewController {
	IBOutlet UITableView *myTableView;
	NSMutableArray *tagArray;
	
	NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) UITableView *myTableView;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSArray *tagArray;

-(void)applicationDidFinishLaunching:(UIApplication *)application;
-(void)updateTagArray;

@end
