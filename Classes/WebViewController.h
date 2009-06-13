//
//  WebViewController.h
//  rtm
//
//  Created by 下村 翔 on 6/13/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WebViewController : UIViewController {
	IBOutlet UIWebView *webView;
}

@property (nonatomic, retain) UIWebView *webView;

-(void)setURL:(NSString *)url;
-(void)setTabBarController:(UITabBarController *)controller;
-(IBAction)hideWebView:sender;

@end
