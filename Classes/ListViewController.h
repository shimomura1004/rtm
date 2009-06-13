//
//  ListViewController.h
//  rtm
//
//  Created by 下村 翔 on 6/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ListViewController : UIViewController {
	IBOutlet UITableView *myTableView;
}

@property(nonatomic, retain) UITableView *myTableView;

@end
