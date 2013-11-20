//
//  pointsSystem.h
//  dayThreeTabed
//
//  Created by App Jam on 11/10/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface pointsSystem : NSObject
@property (nonatomic) NSInteger score;
extern NSString* const SCOREKEY;
-(void)addPoints:(NSInteger)pointsToAdd;
-(void)removePoints:(NSInteger)pointsToRemove;
-(void)saveScore;
-(BOOL)enoughPoints:(NSInteger)toSpend;

@end
