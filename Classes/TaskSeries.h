//
//  TaskSeries.h
//  rtm
//
//  Created by 下村 翔 on 7/3/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class TaskList;
@class Task;
@class Location;
@class Note;
@class Participant;
@class Tag;

@interface TaskSeries :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * modified;
@property (nonatomic, retain) NSString * source;
@property (nonatomic, retain) NSDate * created;
@property (nonatomic, retain) NSString * taskseriesId;
@property (nonatomic, retain) TaskList * taskList;
@property (nonatomic, retain) NSSet* tasks;
@property (nonatomic, retain) NSSet* location;
@property (nonatomic, retain) NSSet* notes;
@property (nonatomic, retain) NSSet* participants;
@property (nonatomic, retain) NSSet* tags;

@end


@interface TaskSeries (CoreDataGeneratedAccessors)
- (void)addTasksObject:(Task *)value;
- (void)removeTasksObject:(Task *)value;
- (void)addTasks:(NSSet *)value;
- (void)removeTasks:(NSSet *)value;

- (void)addLocationObject:(Location *)value;
- (void)removeLocationObject:(Location *)value;
- (void)addLocation:(NSSet *)value;
- (void)removeLocation:(NSSet *)value;

- (void)addNotesObject:(Note *)value;
- (void)removeNotesObject:(Note *)value;
- (void)addNotes:(NSSet *)value;
- (void)removeNotes:(NSSet *)value;

- (void)addParticipantsObject:(Participant *)value;
- (void)removeParticipantsObject:(Participant *)value;
- (void)addParticipants:(NSSet *)value;
- (void)removeParticipants:(NSSet *)value;

- (void)addTagsObject:(Tag *)value;
- (void)removeTagsObject:(Tag *)value;
- (void)addTags:(NSSet *)value;
- (void)removeTags:(NSSet *)value;

@end

