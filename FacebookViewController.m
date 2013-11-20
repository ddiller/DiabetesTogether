//
//  FacebookViewController.m
//  dayThreeTabed
//
//  Created by App Jam on 11/15/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import "FacebookViewController.h"

@interface FacebookViewController ()

@end

@implementation FacebookViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)postFB:(UIImage *)image
{
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        slComposeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [slComposeViewController addImage:image];
        [slComposeViewController addURL:[NSURL URLWithString:@"http://student-council.ics.uci.edu/medappjam/"]];
        [self presentViewController:slComposeViewController animated:YES completion:NULL];
        
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"OOPS" message:@"No Facebook account" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert show];
        //[alert release];
        
    }

}

- (IBAction)postClicked:(id)sender {
    [self postFB:[UIImage imageNamed:@"badge_bronze.png"]];
    
}
- (IBAction)silverPost:(id)sender {
    [self postFB:[UIImage imageNamed:@"badge_silver.png"]];
}
- (IBAction)goldPost:(id)sender {
    [self postFB:[UIImage imageNamed:@"badge_gold.png"]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
