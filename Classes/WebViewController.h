//
//  WebViewController.h
//  rtm
//
//  Created by 下村 翔 on 6/13/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "rtmAppDelegate.h"

@interface WebViewController : UIViewController {
	IBOutlet UIWebView *webView;
	NSString *url;
	rtmAppDelegate *appDelegate;
	NSString *frob;
}

@property (nonatomic, retain) UIWebView *webView;
@property (retain) NSString *url;
@property (retain) rtmAppDelegate *appDelegate;
@property (retain) NSString *frob;

-(IBAction)hideWebView:sender;

@end
