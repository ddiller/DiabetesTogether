//
//  LogManager.h
//  CDTutorial
//
//  Created by App Jam on 11/17/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Record.h"
#import "RecordViewModel.h"

typedef enum {
    AM,
    PM,
    BREAKFAST,
    LUNCH,
    DINNER,
    BEDTIME
} TimeMarker;



@interface LogManager : NSObject

- (RecordViewModel *) recordViewModel;
- (BOOL) isWeekComplete;
- (Record *) currentRecord;
+ (NSDate *) dateForTimeMarker:(TimeMarker)marker;
+ (LogManager *) logManager;
- (NSString *) logDataFromDate:(NSDate *)date;
- (void) saveContext;

@end

static LogManager *shared;

