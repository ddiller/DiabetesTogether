//
//  quizManager.h
//  dayThreeTabed
//
//  Created by App Jam on 11/12/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PointManager.h"

@interface quizManager : NSObject
@property (nonatomic)NSInteger questionNumber;
extern int const NUMQUESTIONS;
@property (strong, nonatomic)PointManager* manager;
@property (strong, nonatomic)NSMutableArray* answers;
@property (strong, nonatomic)NSMutableArray* questions;
@property (strong, nonatomic)NSMutableArray* answersA;
@property (strong, nonatomic)NSMutableArray* answersB;
@property (strong, nonatomic)NSMutableArray* answersC;
@property (strong, nonatomic)NSMutableArray* answersD;
@property (strong, nonatomic)NSMutableArray* descriptions;
-(void)nextQuestion;
-(void)addPoints;
-(void)startOver;
@end
