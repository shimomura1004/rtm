//
//  Tag.h
//  rtm
//
//  Created by 下村 翔 on 7/3/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class TaskSeries;

@interface Tag :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) TaskSeries * taskSeries;

@end



