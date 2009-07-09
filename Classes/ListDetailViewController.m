//
//  ListDetailViewController.m
//  rtm
//
//  Created by 下村 翔 on 6/25/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ListDetailViewController.h"


@implementation ListDetailViewController

@synthesize navigationBar, myTableView, taskSeriesArray, managedObjectContext, listName;


/** This method is called when TaskList in CoreData is updated */
-(void)updateTaskSeriesArray
{
	if ( !taskSeriesArray )	taskSeriesArray = [[NSMutableArray alloc] init];
	
	[self setTitle:listName];
	[taskSeriesArray removeAllObjects];
	
	NSManagedObjectContext *context = [self managedObjectContext];
	NSFetchRequest *req = [[NSFetchRequest alloc] init];
	[req setEntity:[NSEntityDescription entityForName:@"TaskSeries" inManagedObjectContext:context]];
	[req setPredicate:[NSPredicate
					   predicateWithFormat:@"taskList.name == %@ and some tasks.completed == null",
					   listName]];
	
	for (TaskSeries *taskSeries in [context executeFetchRequest:req error:nil])
	{
		[taskSeriesArray addObject:[NSString stringWithString:[taskSeries name]]];
	}
	[taskSeriesArray sortUsingSelector:@selector(compare:)];
	[myTableView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return taskSeriesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cellDefault = [tableView dequeueReusableCellWithIdentifier:@"cellDefault"];
	if (cellDefault == nil) {
		//		cellDefault = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
		cellDefault = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
											  reuseIdentifier:@"cellDefault"] autorelease];
	}
	
	cellDefault.textLabel.text = [taskSeriesArray objectAtIndex:indexPath.row];
	//	cellDefault.detailTextLabel.text = @"tags here!";
	cellDefault.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	return cellDefault;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
}
*/

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
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
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
