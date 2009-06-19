//
//  Note.h
//  rtm
//
//  Created by 下村 翔 on 6/19/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Task;

@interface Note :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * contents;
@property (nonatomic, retain) Task * task;

@end



