//
//  TagViewController.m
//  rtm
//
//  Created by 下村 翔 on 6/25/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TagViewController.h"


@implementation TagViewController

@synthesize managedObjectContext, myTableView, tagArray;

-(void)applicationDidFinishLaunching:(UIApplication *)application
{
	[[NSNotificationCenter defaultCenter]
	 addObserver:self
	 selector:@selector(updateTagArray) name:@"DidTagListUpdated" object:nil];

	tagArray = [[NSMutableArray alloc] init];
	[self updateTagArray];
}

-(void)updateTagArray
{
	[tagArray removeAllObjects];
	
	NSManagedObjectContext *context = [self managedObjectContext];
	NSFetchRequest *req = [[NSFetchRequest alloc] init];
	[req setEntity:[NSEntityDescription entityForName:@"Tag" inManagedObjectContext:context]];
	for (Tag *tag in [context executeFetchRequest:req error:nil])
	{
		[tagArray addObject:[NSString stringWithString:[tag name]]];
	}
	[tagArray sortUsingSelector:@selector(compare:)];
	[myTableView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return tagArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cellDefault = [tableView dequeueReusableCellWithIdentifier:@"cellDefault"];
	if (cellDefault == nil) {
		cellDefault = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
											  reuseIdentifier:@"cellDefault"] autorelease];
	}
	
	cellDefault.textLabel.text = [tagArray objectAtIndex:indexPath.row];
	cellDefault.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	return cellDefault;
}


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
