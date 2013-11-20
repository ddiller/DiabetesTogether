//
//  LogManager.m
//  CDTutorial
//
//  Created by App Jam on 11/17/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import "LogManager.h"
#import "AppDelegate.h"
#import "Record.h"
#import "GlucoseValue.h"
#import "BloodPressureValue.h"
#import "RecordViewModel.h"
#import "Utility.h"


@interface LogManager()

@property (nonatomic, weak) NSManagedObjectContext* managedObjectContext;

@end

@implementation LogManager

@synthesize managedObjectContext;

- (id) init {
    self = [super init];
    if (self) {
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        managedObjectContext = delegate.managedObjectContext;
    }
    return self;
}

- (BOOL) isWeekComplete {
    return NO;
}

- (RecordViewModel *) recordViewModel {
    NSLog(@"recordViewModel()");
    RecordViewModel *recordViewModel = [[RecordViewModel alloc] init];
    recordViewModel.record = [self currentRecord];
    return recordViewModel;
}

- (Record *) currentRecord {
    NSLog(@"currentRecord()");
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Record" inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
    [request setFetchLimit:1];
    
//    NSNumber *salaryLimit = <#A number representing the limit#>;
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"salary > %@", salaryLimit];
//    [request setPredicate:predicate];
//    NSError *error;
//    NSArray *array = [managedObjectContext executeFetchRequest:request error:&error];
    
    // Results should be in descending order of timeStamp.
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    NSArray *results = [managedObjectContext executeFetchRequest:request error:NULL];
    
    Record *latestRecord;
    if ([results count] > 0) {
        NSLog(@"Found existing record");
        latestRecord = (Record *)[results objectAtIndex:0];
        if ([latestRecord.date compare:[LogManager dateForTimeMarker:AM]] >= 0) {
            NSLog(@"Record is for today");
            return latestRecord;
        }
    }
    
    // The latest record is up to date and can be returned
   
    
    return [self newRecordToStore];
}


/* Add a new record to the store; define the record values here*/
- (Record *) newRecordToStore {
    NSLog(@"Adding new record to store.");
    Record *newRecord = [NSEntityDescription insertNewObjectForEntityForName:@"Record" inManagedObjectContext:managedObjectContext];
    newRecord.date = [NSDate date];
    
    GlucoseValue  *newGlucoseValueBreakfast = [NSEntityDescription insertNewObjectForEntityForName:@"GlucoseValue" inManagedObjectContext:managedObjectContext];
    newGlucoseValueBreakfast.is_recorded = NO;
    newGlucoseValueBreakfast.label = @"Breakfast";
    newRecord.gcbreak = newGlucoseValueBreakfast;
    
    GlucoseValue  *newGlucoseValueLunch = [NSEntityDescription insertNewObjectForEntityForName:@"GlucoseValue" inManagedObjectContext:managedObjectContext];
    newGlucoseValueLunch.is_recorded = NO;
    newGlucoseValueLunch.label = @"Lunch";
    newRecord.gclunch = newGlucoseValueLunch;
    
    GlucoseValue  *newGlucoseValueDinner = [NSEntityDescription insertNewObjectForEntityForName:@"GlucoseValue" inManagedObjectContext:managedObjectContext];
    newGlucoseValueDinner.is_recorded = NO;
    newGlucoseValueDinner.label =@"Dinner";
    newRecord.gcdinner = newGlucoseValueDinner;
    
    BloodPressureValue *newBloodSugarValueAM = [NSEntityDescription insertNewObjectForEntityForName:@"BloodPressureValue" inManagedObjectContext:managedObjectContext];
    newBloodSugarValueAM.is_recorded = NO;
    newBloodSugarValueAM.label = @"AM";
    newRecord.bsam = newBloodSugarValueAM;

    BloodPressureValue *newBloodSugarValuePM = [NSEntityDescription insertNewObjectForEntityForName:@"BloodPressureValue" inManagedObjectContext:managedObjectContext];
    newBloodSugarValuePM.is_recorded = NO;
    newBloodSugarValuePM.label = @"PM";
    newRecord.bspm = newBloodSugarValuePM;
    
    NSError *error;
    [managedObjectContext save:&error];
    if (error) {
        NSLog(@"newRecordToStore: Error");
    }
    return newRecord;
}

/* Utility functions */
+ (NSDate *) dateForTimeMarker:(TimeMarker)marker {
    NSDate *date = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    components = [gregorian components:unitFlags fromDate:date];

    switch (marker) {
        case AM:
            components.hour = 0;
            components.minute = 0;
            break;
        case PM:
            components.hour = 12;
            components.minute = 0;
            break;
        case BREAKFAST:
            components.hour = 6;
            components.minute = 0;
            break;
        case LUNCH:
            components.hour = 11;
            components.minute = 0;
            break;
        case DINNER:
            components.hour = 16;
            components.minute = 0;
            break;
        case BEDTIME:
            components.hour = 21;
            components.minute = 0;
            break;
        default:
            components.hour = 0;
            components.minute = 0;
            break;
    }

    return [gregorian dateFromComponents:components];
}

+ (LogManager *) logManager {
    @synchronized(self)
    {
        if (!shared)
            shared = [[LogManager alloc] init];
    }
    return shared;
}

- (NSString *) logDataFromDate:(NSDate *)date {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Record" inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date >= %@", date];
    [request setPredicate:predicate];
//    NSError *error;
//    NSArray *array = [managedObjectContext executeFetchRequest:request error:&error];
    
    // Results should be in descending order of timeStamp.
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    NSArray *results = [managedObjectContext executeFetchRequest:request error:NULL];
    
    NSString *toReturn = @"<table border='1'>";
    toReturn = [toReturn stringByAppendingFormat:@"<tr><td>%@</td><td>%@</td><td>%@</td><td>%@</td><td>%@</td><td>%@</td><td>%@</td><td>%@</td><td>%@</td><td>%@</td><td>%@</td><td>%@</td><td>%@</td><td>%@</td></tr>", @"date", @"diastolic_am", @"systolic_am", @"diastolic_pm", @"systolic_pm", @"pre_glucose_breakfast", @"post_glucose_breakfast", @"carb_count_breakfast", @"pre_glucose_lunch", @"post_glucose_lunch", @"carb_count_lunch", @"pre_glucose_dinner", @"post_glucose_dinner", @"carb_count_dinner"];
    for (Record *record in results) {
        BloodPressureValue *bsam = record.bsam;
        BloodPressureValue *bspm = record.bspm;
        GlucoseValue *gcbreak = record.gcbreak;
        GlucoseValue *gclunch = record.gclunch;
        GlucoseValue *gcdinner = record.gcdinner;
        toReturn = [toReturn stringByAppendingFormat:@"<tr><td>%@</td><td>%@</td><td>%@</td><td>%@</td><td>%@</td><td>%@</td><td>%@</td><td>%@</td><td>%@</td><td>%@</td><td>%@</td><td>%@</td><td>%@</td><td>%@</td></tr>", [Utility getDate:record.date inFormat:@"YY-MM-dd"], bsam.diastolic, bsam.systolic, bspm.diastolic, bspm.systolic, gcbreak.pre_glucose, gcbreak.post_glucose, gcbreak.carb_count, gclunch.pre_glucose, gclunch.post_glucose, gclunch.carb_count, gcdinner.pre_glucose, gcdinner.post_glucose, gcdinner.carb_count];
    }
    toReturn = [toReturn stringByAppendingString:@"</table>"];
    
    return toReturn;
}

- (void) saveContext {
    NSError *error;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


@end
