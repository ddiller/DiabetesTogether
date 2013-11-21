//
//  SecondViewController.m
//  dayThreeTabed
//
//  Created by App Jam on 11/10/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import "SecondViewController.h"
#import "PointManager.h"
#import "ViewController.h"


@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *thermometer;
@property (strong, nonatomic) PointManager *score;
@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    _score = [[PointManager alloc] init];
    self.label.text = [NSString stringWithFormat:@"You have %d%@", [self.score getPoints],@" points!!" ];
	// Do any additional setup after loading the view, typically from a nib.
    [self setThermom];
    
    
    
}
-(void)setThermom{
    if([self.score getPoints] >= 1200){
        [_thermometer setImage:[UIImage imageNamed:@"thermometer1200.png" ]];
    }else if([self.score getPoints] >= 1150){
        [_thermometer setImage:[UIImage imageNamed:@"thermometer-1150.png" ]];
    }else if([self.score getPoints] >= 1100){
        [_thermometer setImage:[UIImage imageNamed:@"thermometer-1100.png" ]];
    }else if([self.score getPoints] >= 1050){
        [_thermometer setImage:[UIImage imageNamed:@"thermometer-1050.png" ]];
    }else if([self.score getPoints] >= 1000){
        [_thermometer setImage:[UIImage imageNamed:@"thermometer-1000.png" ]];
    }else if([self.score getPoints] >= 950){
        [_thermometer setImage:[UIImage imageNamed:@"thermometer-950.png" ]];
    }else if([self.score getPoints] >= 900){
        [_thermometer setImage:[UIImage imageNamed:@"thermometer-900.png" ]];
    }else if([self.score getPoints] >= 850){
        [_thermometer setImage:[UIImage imageNamed:@"thermometer-850.png" ]];
    }else if([self.score getPoints] >= 800){
        [_thermometer setImage:[UIImage imageNamed:@"thermometer-800.png" ]];
    }else if([self.score getPoints] >= 750){
        [_thermometer setImage:[UIImage imageNamed:@"thermometer-750.png" ]];
    }else if([self.score getPoints] >= 700){
        [_thermometer setImage:[UIImage imageNamed:@"thermometer-700.png" ]];
    }else if([self.score getPoints] >= 650){
        [_thermometer setImage:[UIImage imageNamed:@"thermometer-650.png" ]];
    }else if([self.score getPoints] >= 600){
        [_thermometer setImage:[UIImage imageNamed:@"thermometer-600.png" ]];
    }else if([self.score getPoints] >= 550){
        [_thermometer setImage:[UIImage imageNamed:@"thermometer-550.png" ]];
    }else if([self.score getPoints] >= 500){
        [_thermometer setImage:[UIImage imageNamed:@"thermometer-500.png" ]];
    }else if([self.score getPoints] >= 450){
        [_thermometer setImage:[UIImage imageNamed:@"thermometer-450.png" ]];
    }else if([self.score getPoints] >= 400){
        [_thermometer setImage:[UIImage imageNamed:@"thermometer-400.png" ]];
    }else if([self.score getPoints] >= 350){
        [_thermometer setImage:[UIImage imageNamed:@"thermometer-350.png" ]];
    }else if([self.score getPoints] >= 300){
        [_thermometer setImage:[UIImage imageNamed:@"thermometer-300.png" ]];
    }else if([self.score getPoints] >= 250){
        [_thermometer setImage:[UIImage imageNamed:@"thermometer-250.png" ]];
    }else if([self.score getPoints] >= 200){
        [_thermometer setImage:[UIImage imageNamed:@"thermometer-200.png" ]];
    }else if([self.score getPoints] >= 150){
        [_thermometer setImage:[UIImage imageNamed:@"thermometer-150.png" ]];
    }else if([self.score getPoints] >= 100){
        [_thermometer setImage:[UIImage imageNamed:@"thermometer-100.png" ]];
    }else{
        [_thermometer setImage:[UIImage imageNamed:@"PointMeter.png" ]];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    _score = [[PointManager alloc] init];
    self.label.text = [NSString stringWithFormat:@"You have %d%@", [self.score getPoints],@" points!!" ];
    [self setThermom];
    
	
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
