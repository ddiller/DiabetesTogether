//
//  StepsViewController.h
//  dayThreeTabed
//
//  Created by App Jam on 11/12/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StepsViewController : UIViewController <UIAccelerometerDelegate> {
    float px;
    float py;
    float pz;

    int numSteps;
    BOOL isChange;
    BOOL isSleeping;
}

@property (retain, nonatomic) IBOutlet UILabel *stepCountLabel;

- (IBAction)reset:(id)sender;

@end
