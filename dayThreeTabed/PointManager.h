//
//  PointManager.h
//  dayThreeTabed
//
//  Created by App Jam on 11/11/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "pointsSystem.h"

@interface PointManager : NSObject
extern const int CLASSPOINTS;
extern const int QUIZPOINTS;
extern const int VIDEOPOINTS;
extern const int SPENTLEVELONE;
extern const int SPENTLEVELTWO;
extern const int SPENTLEVELTHREE;
-(void)addPointsVideo;
-(void)addPointsQuiz;
-(void)addPointsClass;
-(void)removePointsOne;
-(void)removePointsTwo;
-(void)removePointsThree;
-(int)getPoints;
@end
