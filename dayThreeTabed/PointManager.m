//
//  PointManager.m
//  dayThreeTabed
//
//  Created by App Jam on 11/11/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import "PointManager.h"
@interface PointManager()


@property (nonatomic)pointsSystem* points;

@end
const int CLASSPOINTS = 100;
const int QUIZPOINTS = 20;
const int VIDEOPOINTS = 5;

const int SPENTLEVELONE = 50;
const int SPENTLEVELTWO = 100;
const int SPENTLEVELTHREE = 500;

@implementation PointManager
-(id)init{
    if(!_points){
        _points = [[pointsSystem alloc] init];
    }
    
    return self;
}
-(void)addPointsClass{
    [_points addPoints:CLASSPOINTS];}
-(void)addPointsVideo{
    [_points addPoints:VIDEOPOINTS];}
-(void)addPointsQuiz{
    [_points addPoints:QUIZPOINTS];}
-(void)removePointsOne{
    [_points removePoints:SPENTLEVELONE];}
-(void)removePointsTwo{
    [_points removePoints:SPENTLEVELTWO];}
-(void)removePointsThree{
    [_points removePoints:SPENTLEVELTHREE];}
-(void)addPointsAmount:(NSInteger)amount{
    [_points addPoints:amount];
    
}
-(int)getPoints{
    return [_points score];
}

@end
