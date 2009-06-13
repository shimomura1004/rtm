//
//  WebViewController.m
//  rtm
//
//  Created by 下村 翔 on 6/13/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WebViewController.h"


@implementation WebViewController

@synthesize webView;


NSString *rtmURL = @"";
-(void)setURL:(NSString *)url
{
	rtmURL = url;
}

UITabBarController *tcon;
-(void)setTabBarController:(UITabBarController *)controller
{
	tcon = controller;
}
-(IBAction)hideWebView:sender
{
	[tcon dismissModalViewControllerAnimated:NO];
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:rtmURL]]];
}


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
