//
//  OverViewController.m
//  rtm
//
//  Created by 下村 翔 on 6/19/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "OverViewController.h"

@implementation OverViewController

-(IBAction)refreshAllListsAndTasks:sender
{
	[[NSNotificationCenter defaultCenter]
	 postNotification:[NSNotification
					   notificationWithName:@"UpdateAllListsAndTasks" object:nil]];
}

-(IBAction)addNewTask:sender
{
	TaskAddViewController *taskAddController =
	[[TaskAddViewController alloc] initWithNibName:@"TaskAddView" bundle:nil];
	[self.tabBarController presentModalViewController:taskAddController animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch( section ) {
        default: return 0;
    }
}

- (NSString *) tableView:(UITableView *) tableView titleForHeaderInSection:(NSInteger) section
{
    switch( section ) {
		case 0: return @"Today";
        case 1: return @"Tomorrow";
		case 2: return @"This week";
		case 3: return @"OverDue";
    }
    return nil;
}


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
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
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
