//
//  Task.h
//  rtm
//
//  Created by 下村 翔 on 7/3/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class TaskSeries;

@interface Task :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * priority;
@property (nonatomic, retain) NSNumber * hasDueTime;
@property (nonatomic, retain) NSString * taskId;
@property (nonatomic, retain) NSNumber * postponed;
@property (nonatomic, retain) NSString * due;
@property (nonatomic, retain) NSDate * completed;
@property (nonatomic, retain) NSDate * added;
@property (nonatomic, retain) NSDate * deleted;
@property (nonatomic, retain) NSString * estimate;
@property (nonatomic, retain) TaskSeries * taskseries;

@end



