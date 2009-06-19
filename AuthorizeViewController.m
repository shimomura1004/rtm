//
//  AuthorizeViewController.m
//  rtm
//
//  Created by 下村 翔 on 6/19/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "AuthorizeViewController.h"


@implementation AuthorizeViewController

@synthesize authorizeView;
@synthesize url;

-(IBAction)hideAuthorizeView:sender
{
	[[NSNotificationCenter defaultCenter]
	 postNotification:[NSNotification
					   notificationWithName:@"DidFrobAuthorizationFinished" object:nil]];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	[authorizeView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
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
