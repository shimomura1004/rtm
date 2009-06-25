//
//  TaskList.h
//  rtm
//
//  Created by 下村 翔 on 6/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class TaskSeries;

@interface TaskList :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * listId;
@property (nonatomic, retain) NSNumber * locked;
@property (nonatomic, retain) NSNumber * smart;
@property (nonatomic, retain) NSNumber * position;
@property (nonatomic, retain) NSNumber * deleted;
@property (nonatomic, retain) NSNumber * archived;
@property (nonatomic, retain) NSSet* tasks;

@end


@interface TaskList (CoreDataGeneratedAccessors)
- (void)addTasksObject:(TaskSeries *)value;
- (void)removeTasksObject:(TaskSeries *)value;
- (void)addTasks:(NSSet *)value;
- (void)removeTasks:(NSSet *)value;

@end

