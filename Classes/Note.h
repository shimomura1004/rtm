//
//  Note.h
//  rtm
//
//  Created by 下村 翔 on 6/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class TaskSeries;

@interface Note :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * noteId;
@property (nonatomic, retain) NSDate * created;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * modified;
@property (nonatomic, retain) NSString * body;
@property (nonatomic, retain) TaskSeries * taskseries;

@end



