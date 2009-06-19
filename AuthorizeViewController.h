//
//  AuthorizeViewController.h
//  rtm
//
//  Created by 下村 翔 on 6/19/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthorizeViewController : UIViewController {
	IBOutlet UIWebView *authorizeView;
	NSString *url;
}

@property (nonatomic, retain) UIWebView *authorizeView;
@property (retain) NSString *url;

-(IBAction)hideAuthorizeView:sender;

@end
