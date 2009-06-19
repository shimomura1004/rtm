//
//  List.h
//  rtm
//
//  Created by 下村 翔 on 6/19/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Task;

@interface List :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * listName;
@property (nonatomic, retain) NSSet* tasks;

@end


@interface List (CoreDataGeneratedAccessors)
- (void)addTasksObject:(Task *)value;
- (void)removeTasksObject:(Task *)value;
- (void)addTasks:(NSSet *)value;
- (void)removeTasks:(NSSet *)value;

@end

