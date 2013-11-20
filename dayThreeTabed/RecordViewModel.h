//
//  RecordViewModel.h
//  CDTutorial
//
//  Created by App Jam on 11/18/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Record.h"
#import "GlucoseValue.h"
#import "BloodPressureValue.h"

@interface RecordViewModel : NSObject

@property (nonatomic, strong) Record *record;

- (GlucoseValue *) currentGlucoseValue;

- (BloodPressureValue *) currentBloodSugarValue;

- (BOOL) checkComplete;

@end
