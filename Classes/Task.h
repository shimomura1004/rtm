//
//  Task.h
//  rtm
//
//  Created by 下村 翔 on 6/19/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Note;
@class List;

@interface Task :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * taskName;
@property (nonatomic, retain) NSNumber * priority;
@property (nonatomic, retain) NSNumber * taskId;
@property (nonatomic, retain) NSSet* notes;
@property (nonatomic, retain) List * list;

@end


@interface Task (CoreDataGeneratedAccessors)
- (void)addNotesObject:(Note *)value;
- (void)removeNotesObject:(Note *)value;
- (void)addNotes:(NSSet *)value;
- (void)removeNotes:(NSSet *)value;

@end

