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
#import <MailCore/mailcore.h>


@interface LogManager()

@property (nonatomic, weak) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, strong) NSString *email;

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
    toReturn = [toReturn stringByAppendingFormat:@"<tr><td>%@</td><td>%@</td><td>%@</td><td>%@</td><td>%@</td><td>%@</td><td>%@</td><td>%@</td><td>%@</td><td>%@</td><td>%@</td><td>%@</td><td>%@</td><td>%@</td></tr>", @"Date", @"Systolic AM", @"Diastolic AM", @"Systolic PM", @"Diastolic PM", @"Pre-breakfast Glucose", @"Post-breakfast Glucose", @"Carb-count Breakfast", @"Pre-lunch Glucose", @"Post-Lunch Glucose", @"Carb-count Lunch", @"Pre-dinner Glucose", @"Post-dinner Glucose", @"Carb-count Dinner"];
    for (Record *record in results) {
        BloodPressureValue *bsam = record.bsam;
        BloodPressureValue *bspm = record.bspm;
        GlucoseValue *gcbreak = record.gcbreak;
        GlucoseValue *gclunch = record.gclunch;
        GlucoseValue *gcdinner = record.gcdinner;
        toReturn = [toReturn stringByAppendingFormat:@"<tr><td>%@</td>%@%@%@%@%@%@%@%@%@%@%@%@%@</tr>",
                    [Utility getDate:record.date inFormat:@"YY-MM-dd"],
                    [self tableCell:bsam.systolic ofType:0], [self tableCell:bsam.diastolic ofType:1],
                    [self tableCell:bspm.systolic ofType:0], [self tableCell:bspm.diastolic ofType:1],
                    [self tableCell:gcbreak.pre_glucose ofType:2], [self tableCell:gcbreak.post_glucose ofType:2], [self tableCell:gcbreak.carb_count ofType:3],
                    [self tableCell:gclunch.pre_glucose ofType:2], [self tableCell:gclunch.post_glucose ofType:2], [self tableCell:gclunch.carb_count ofType:3],
                    [self tableCell:gcdinner.pre_glucose ofType:2], [self tableCell:gcdinner.post_glucose ofType:2], [self tableCell:gcdinner.carb_count ofType:3]];
    }
    toReturn = [toReturn stringByAppendingString:@"</table>"];
    
    return toReturn;
}

- (NSString *) tableCell:(NSNumber *)value ofType:(NSInteger) type {
    if (value == nil) {
        return [NSString stringWithFormat:@"<td></td>"];

    }
    switch (type) {
            
            // 0:systolic :140
            // 1:diastolic : 90
            // 2:blood glucose
            // default:carb-count
        case 0:
            if ([value floatValue] > 140)
                return [NSString stringWithFormat:@"<td style='background-color:red'>%@</td>", value];
            break;
        case 1:
            if ([value floatValue] > 90)
                return [NSString stringWithFormat:@"<td style='background-color:red'>%@</td>", value];
            break;
        case 2:
            if ([value floatValue] < 70)
                return [NSString stringWithFormat:@"<td style='background-color:yellow'>%@</td>", value];
            else if ([value floatValue] > 180)
                return [NSString stringWithFormat:@"<td style='background-color:red'>%@</td>", value];
        default:
            break;
    }
    return [NSString stringWithFormat:@"<td>%@</td>", value];
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

- (void) sendLogToEmail {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Destination Email" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
    
    UITextField *username = [alertView textFieldAtIndex:0];
    NSLog(@"Email: %@", username.text);
    self.email = username.text;
    
    MCOSMTPSession *smtpSession = [[MCOSMTPSession alloc] init];
    smtpSession.hostname = @"smtp.gmail.com";
    smtpSession.port = 465;
    smtpSession.username = @"diabetestogetheruci@gmail.com";
    smtpSession.password = @"diabetes123";
    smtpSession.authType = MCOAuthTypeSASLPlain;
    smtpSession.connectionType = MCOConnectionTypeTLS;
    
    MCOMessageBuilder *builder = [[MCOMessageBuilder alloc] init];
    MCOAddress *from = [MCOAddress addressWithDisplayName:@"DiabetesTogether"
                                                  mailbox:@"diabetestogetheruci@gmail.com"];
    MCOAddress *to = [MCOAddress addressWithDisplayName:nil mailbox:self.email];
    
    NSString *results = [[LogManager logManager] logDataFromDate:[NSDate dateWithTimeIntervalSinceNow:-24*60*60*7]];
//    NSLog(results);
    
    [[builder header] setFrom:from];
    [[builder header] setTo:@[to]];
    [[builder header] setSubject:@"DiabetesTogether Log"];
    [builder setHTMLBody:results];
    NSData * rfc822Data = [builder data];
    
    MCOSMTPSendOperation *sendOperation =
    [smtpSession sendOperationWithData:rfc822Data];
    [sendOperation start:^(NSError *error) {
        if(error) {
            NSLog(@"Error sending email: %@", error);
        } else {
            NSLog(@"Successfully sent email!");
            [self showAlert:@"Email Log" withMessage:@"Successfully sent!"];
        }
    }];
    }
}

-(void)showAlert:(NSString*)title withMessage:(NSString*)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void) insertDummyValues {
    NSArray *values = @[
                        @[@121.39, @74.10,@121.39, @74.10, @105.43, @88.89, @98.92, @84.66, @90.20, @93.39, @50.29, @75.41, @103.04],
                        @[@146.73, @80.70,@146.73, @80.70, @81.77, @77.30, @94.01, @80.40, @107.57, @96.38, @71.41, @89.54, @93.39],
                        @[@139.98, @68.31,@121.39, @74.10, @88.37, @185.73, @102.67, @88.48, @80.15, @73.45, @89.18, @140.36, @75.01],
                        @[@96.33, @88.21,@146.73, @80.70, @90.23, @75.35, @57.29, @85.09, @85.95, @60.38, @105.20, @78.73, @127.78],
                        @[@137.26, @90.81,@121.39, @74.10, @75.13, @128.54, @108.65, @190.29, @84.42, @106.96, @98.24, @96.98, @126.54],
                        @[@92.20, @85.14,@146.73, @80.70, @85.02, @123.58, @95.26, @121.45, @63.72, @85.79, @115.03, @160.60, @108.54],
                        @[@139.98, @68.31,@121.39, @74.10, @88.37, @102.73, @102.67, @88.48, @80.15, @73.45, @89.18, @99.36, @75.01],
                        @[@121.39, @74.10,@121.39, @74.10, @105.43, @88.89, @98.92, @84.66, @180.20, @93.39, @81.29, @75.41, @103.04],
                        ];
    int time_interval = 0;
    
    for (NSArray *row in values) {
        Record *record = [self newRecordToStore];
        record.date = [NSDate dateWithTimeIntervalSinceNow:time_interval];
        
        record.bsam.systolic = row[0];
        record.bsam.diastolic = row[1];
        record.bspm.systolic = row[2];
        record.bspm.diastolic = row[3];
        record.gcbreak.pre_glucose = row[4];
        record.gcbreak.post_glucose = row[5];
        record.gcbreak.carb_count = row[6];
        record.gclunch.pre_glucose = row[7];
        record.gclunch.post_glucose = row[8];
        record.gclunch.carb_count = row[9];
        record.gcdinner.pre_glucose = row[10];
        record.gcdinner.post_glucose = row[11];
        record.gcdinner.carb_count = row[12];
        
        time_interval -= 24*60*60;
    }
}


@end
