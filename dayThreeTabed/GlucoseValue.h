//
//  GlucoseValue.h
//  DiabetesTogether
//
//  Created by App Jam on 11/19/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Record;

@interface GlucoseValue : NSManagedObject

@property (nonatomic, retain) NSNumber * carb_count;
@property (nonatomic, retain) NSNumber * is_recorded;
@property (nonatomic, retain) NSString * label;
@property (nonatomic, retain) NSNumber * post_glucose;
@property (nonatomic, retain) NSNumber * pre_glucose;
@property (nonatomic, retain) Record *record;

@end
