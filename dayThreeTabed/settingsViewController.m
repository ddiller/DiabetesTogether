//
//  settingsViewController.m
//  dayThreeTabed
//
//  Created by App Jam on 11/12/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import "settingsViewController.h"
#import "PointManager.h"

@interface settingsViewController ()
@property (strong, nonatomic) PointManager *myPoints;
@end

@implementation settingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)addPoints:(id)sender {
    [self.myPoints addPointsVideo];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.myPoints = [[PointManager alloc] init];
	// Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end