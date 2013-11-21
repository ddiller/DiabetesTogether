//
//  FirstViewController.m
//  dayThreeTabed
//
//  Created by App Jam on 11/10/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//Team15.${PRODUCT_NAME:rfc1034identifier}

#import "FirstViewController.h"
#import "PointManager.h"

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelOne;
@property (nonatomic)PointManager *myPoints;
@end

@implementation FirstViewController


-(void)viewWillDisappear:(BOOL)animated
{
    //NSLog(@"Background");
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES]; // reloads score when u come back from other views
    self.myPoints = [[PointManager alloc] init];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.myPoints = [[PointManager alloc]init];
    [[UITabBar appearance] setBackgroundColor:[UIColor blueColor]];
    [[UITabBar appearance] setBarTintColor:[UIColor blueColor]];
    
    
    // Do any additional setup after loading the view, typically from a nib.
    
}
- (IBAction)helpButton:(id)sender {
    [self showAlert:@"Welcome" withMessage:@"Welcome to Diabetes Together, please select one of the items on the main page to get started!"];
}
-(void)showAlert:(NSString*)title withMessage:(NSString*)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}








- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
