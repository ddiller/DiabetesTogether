//
//  pointsSystem.m
//  dayThreeTabed
//
//  Created by App Jam on 11/10/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import "pointsSystem.h"

NSString* const SCOREKEY = @"score";
@interface pointsSystem()
@property (strong, nonatomic)NSUserDefaults *prefs;

@end

@implementation pointsSystem

-(id) init{
    
    if(!_prefs){
    _prefs = [NSUserDefaults standardUserDefaults];
    }
    self.score = [_prefs integerForKey:SCOREKEY];
    /////NSLog([NSString stringWithFormat:@"Loaded : %d", self.score]);  //// test to see what value is loaded
    
    return self;
}

-(void) addPoints:(NSInteger )pointsToAdd{
    self.score+= pointsToAdd; // adds points to the score
    
    [_prefs setInteger:self.score forKey:SCOREKEY]; // set int value for object score
    [_prefs synchronize];  // stores all values
}

-(BOOL)enoughPoints:(NSInteger)toSpend{
    return self.score>=toSpend ? YES:NO;
}

-(void)removePoints:(NSInteger)pointsToRemove{
    if([self enoughPoints:pointsToRemove]){   /// no negative scores
        self.score-= pointsToRemove;
        
    }else{
        ///not enough points
    }
    
    [_prefs setInteger:self.score forKey:SCOREKEY]; // set int value for object score
    [_prefs synchronize];  // stores all values
}
///////for testing only /// should not be called by app
-(void) saveScore
{
    [_prefs setInteger:self.score forKey:SCOREKEY]; // set int value for object score
    [_prefs synchronize];
    
    
    /////////start logs/////////////
    NSLog([NSString stringWithFormat:@"tried to store %d", (int)self.score]);  //log the number to be stored
    NSLog([NSString stringWithFormat:@"stored %d", [_prefs integerForKey:SCOREKEY]]);
    //////////end logs//////////////
}

@end
