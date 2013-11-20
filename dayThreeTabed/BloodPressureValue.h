//
//  BloodPressureValue.h
//  DiabetesTogether
//
//  Created by App Jam on 11/19/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Record;

@interface BloodPressureValue : NSManagedObject

@property (nonatomic, retain) NSNumber * diastolic;
@property (nonatomic, retain) NSNumber * is_recorded;
@property (nonatomic, retain) NSString * label;
@property (nonatomic, retain) NSNumber * systolic;
@property (nonatomic, retain) Record *record;

@end
