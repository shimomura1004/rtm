//
//  ListViewController.m
//  rtm
//
//  Created by 下村 翔 on 6/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ListViewController.h"

@implementation ListViewController

@synthesize myTableView, listArray, managedObjectContext;

-(void)applicationDidFinishLaunching:(UIApplication *)application
{
	// when TaskList is updated, TaskList-array must be updated
	[[NSNotificationCenter defaultCenter]
	 addObserver:self
	 selector:@selector(updateListArray) name:@"DidTaskListUpdated" object:nil];
	
	listArray = [[NSMutableArray alloc] init];
	[self updateListArray];
}

/** This method is called when TaskList in CoreData is updated */
-(void)updateListArray
{
	[listArray removeAllObjects];
	
	NSManagedObjectContext *context = [self managedObjectContext];
	NSFetchRequest *req = [[NSFetchRequest alloc] init];
	[req setEntity:[NSEntityDescription entityForName:@"TaskList" inManagedObjectContext:context]];
	for (TaskList *list in [context executeFetchRequest:req error:nil])
	{
		[listArray addObject:[NSString stringWithString:[list name]]];
	}
	[listArray sortUsingSelector:@selector(compare:)];
	[myTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cellDefault = [tableView dequeueReusableCellWithIdentifier:@"cellDefault"];
	if (cellDefault == nil) {
//		cellDefault = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
		cellDefault = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
											  reuseIdentifier:@"cellDefault"] autorelease];
	}
	
	cellDefault.textLabel.text = [listArray objectAtIndex:indexPath.row];
//	cellDefault.detailTextLabel.text = @"tags here!";
	cellDefault.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	return cellDefault;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	ListDetailViewController *listDetailViewController =
		[[ListDetailViewController alloc] initWithNibName:@"ListDetailView" bundle:nil];
	listDetailViewController.managedObjectContext = managedObjectContext;
	
	[listDetailViewController setListName:[listArray objectAtIndex:indexPath.row]];
	[listDetailViewController updateTaskSeriesArray];
	[self.navigationController pushViewController:listDetailViewController animated:YES];
	[listDetailViewController release];
}


/*
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad
 {
 [super viewDidLoad];
 }
 */

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}


@end
