//
//  settingsViewController.h
//  dayThreeTabed
//
//  Created by App Jam on 11/12/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//
#import "StepsViewController.h"
#import "PointManager.h"

#define kUpdateFrequency    60.0
@interface StepsViewController()
@property (strong, nonatomic) PointManager *myPoints;
@end
@implementation StepsViewController
@synthesize stepCountLabel;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Enable listening to the accelerometer
    [[UIAccelerometer sharedAccelerometer] setUpdateInterval:1.0 / kUpdateFrequency];
    [[UIAccelerometer sharedAccelerometer] setDelegate:self];
    
    px = py = pz = 0;
    numSteps = 0;
    
    self.stepCountLabel.text = [NSString stringWithFormat:@"%d", numSteps];
    self.myPoints = [[PointManager alloc] init];
    
}

- (void)viewDidUnload
{
    [self setStepCountLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

// UIAccelerometerDelegate method, called when the device accelerates.
-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {

    float xx = acceleration.x;
    float yy = acceleration.y;
    float zz = acceleration.z;
    
    float dot = (px * xx) + (py * yy) + (pz * zz);
    float a = ABS(sqrt(px * px + py * py + pz * pz));
    float b = ABS(sqrt(xx * xx + yy * yy + zz * zz));
    
    dot /= (a * b);
    
    if (dot <= 0.82) {
        if (!isSleeping) {
            isSleeping = YES;
            [self performSelector:@selector(wakeUp) withObject:nil afterDelay:0.3];
            numSteps += 1;
            self.stepCountLabel.text = [NSString stringWithFormat:@"%d", numSteps];
        }
    }
    
    px = xx; py = yy; pz = zz;
    
}

- (void)wakeUp {
    isSleeping = NO;
}

//- (void)dealloc {
//    [stepCountLabel release];
 //   [super dealloc];
//}

- (IBAction)backButton:(id)sender {
    if(numSteps > 100){
        [self.myPoints addPointsAmount:(int)(numSteps / 100)];
        [self showAlert:@"Well Done" withMessage:[NSString stringWithFormat: @"You just earned %d %@", numSteps/100, @" points!"] ];
    }
    [[UIAccelerometer sharedAccelerometer] setDelegate:nil];
    [super dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)clickLight:(id)sender {
    [self showAlert:@"Exercise" withMessage:@"Time to exercise!  Earn points by walking or jogging and using this pedometer function.  To get points, simply click on the “start” button and just start walking or jogging.  Once you are done with your exercise, click on the “stop” button to collect the points you just earned.  You will earn 10 points for every 2000 steps (that’s 1 mile!) you record on this pedometer."];
}

- (IBAction)reset:(id)sender {
    if(numSteps > 100){
        [self.myPoints addPointsAmount:(int)(numSteps / 100)];
        [self showAlert:@"Well Done" withMessage:[NSString stringWithFormat: @"You just earned %d %@", numSteps/100, @" points!"] ];
    }
    numSteps = 0;
    self.stepCountLabel.text = [NSString stringWithFormat:@"%d", numSteps];
    
}
-(void)showAlert:(NSString*)title withMessage:(NSString*)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

@end
