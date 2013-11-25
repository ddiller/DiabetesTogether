//
//  settingsViewController.m
//  dayThreeTabed
//
//  Created by App Jam on 11/12/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import "settingsViewController.h"
#import "PointManager.h"
#import "LogManager.h"
#import <MailCore/mailcore.h>

@interface settingsViewController ()
@property (strong, nonatomic) PointManager *myPoints;
@property (nonatomic, weak) NSString *email;
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
    [self.myPoints addPointsClass];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.myPoints = [[PointManager alloc] init];
	// Do any additional setup after loading the view.
}
- (IBAction)backClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)removePoints:(id)sender {
    [self.myPoints removePointsTwo];
}


- (IBAction)initDummyClick:(id)sender {
    [[LogManager logManager] insertDummyValues];
}

@end
