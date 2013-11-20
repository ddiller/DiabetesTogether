//
//  Record.h
//  DiabetesTogether
//
//  Created by App Jam on 11/19/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BloodPressureValue, GlucoseValue;

@interface Record : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * is_complete;
@property (nonatomic, retain) BloodPressureValue *bsam;
@property (nonatomic, retain) BloodPressureValue *bspm;
@property (nonatomic, retain) GlucoseValue *gcbreak;
@property (nonatomic, retain) GlucoseValue *gcdinner;
@property (nonatomic, retain) GlucoseValue *gclunch;

@end
