//
//  RecordViewModel.m
//  CDTutorial
//
//  Created by App Jam on 11/18/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import "RecordViewModel.h"
#import "LogManager.h"

@implementation RecordViewModel

@synthesize record;

- (GlucoseValue *) currentGlucoseValue {
    NSDate *curTime = [NSDate date];
    if ([curTime compare:[LogManager dateForTimeMarker:BREAKFAST]] >= 0) {
        if ([curTime compare:[LogManager dateForTimeMarker:LUNCH]] >= 0) {
            if ([curTime compare:[LogManager dateForTimeMarker:DINNER]] >= 0) {
                if ([curTime compare:[LogManager dateForTimeMarker:BEDTIME]] >= 0) {
                    return nil;
                }
                return record.gcdinner;
            }
            return record.gclunch;
        }
        return record.gcbreak;
    }
    return nil;
}

- (BloodPressureValue *) currentBloodSugarValue {
    NSDate *curTime = [NSDate date];
    if ([curTime compare:[LogManager dateForTimeMarker:AM]] >= 0) {
        if ([curTime compare:[LogManager dateForTimeMarker:PM]] >= 0) {
            return record.bspm;
        }
        return record.bsam;
    }
    return nil;
}

- (BOOL) checkComplete {
    BOOL is_complete = record.gcbreak.is_recorded && record.gclunch.is_recorded &&
            record.gcdinner && record.bsam && record.bspm;
    record.is_complete = [NSNumber numberWithBool:is_complete];
    return is_complete;
}

@end
