//
//  Utility.m
//  CDTutorial
//
//  Created by App Jam on 11/17/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import "Utility.h"

@implementation Utility

+ (NSString *) getDate:(NSDate *) date inFormat:(NSString *) format {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:date];
}
//+ (NSString *) dataToString:(NSData *) data {
//    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//}
//+ (NSData *) stringToData:(NSString *) string {
//    return [string dataUsingEncoding:NSUTF8StringEncoding];
//}
//+ (NSNumber *) dataToNumber:(NSData *) data {
//    return [[NSNumber alloc] initWith]
//}
//+ (NSData *) numberToData:(NSNumber *) number;


@end
