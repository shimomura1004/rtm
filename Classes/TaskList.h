//
//  TaskList.h
//  rtm
//
//  Created by 下村 翔 on 6/25/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Task;

@interface TaskList :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * listName;
@property (nonatomic, retain) NSString * listId;
@property (nonatomic, retain) NSSet* tasks;

@end


@interface TaskList (CoreDataGeneratedAccessors)
- (void)addTasksObject:(Task *)value;
- (void)removeTasksObject:(Task *)value;
- (void)addTasks:(NSSet *)value;
- (void)removeTasks:(NSSet *)value;

@end

