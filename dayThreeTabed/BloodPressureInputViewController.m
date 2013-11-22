//
//  RecordViewController.m
//  CDTutorial
//
//  Created by App Jam on 11/17/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import "BloodPressureInputViewController.h"
#import "AppDelegate.h"
#import "LogManager.h"
#import "Record.h"
#import "BloodPressureValue.h"
#import "GlucoseValue.h"

@interface BloodPressureInputViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *bsam_diastolic;
@property (weak, nonatomic) IBOutlet UITextField *bsam_systolic;

@property (weak, nonatomic) IBOutlet UITextField *bspm_diastolic;
@property (weak, nonatomic) IBOutlet UITextField *bspm_systolic;

@property (nonatomic, strong) Record *record;
@property (strong, nonatomic) UITextField *activeField;

@end

@implementation BloodPressureInputViewController

@synthesize record, scrollView, activeField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
-(void)showAlert:(NSString*)title withMessage:(NSString*)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    record = [[LogManager logManager] currentRecord];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self resetScrollView];
    [self registerForKeyboardNotifications];
    
    BloodPressureValue *bsam = record.bsam;
    _bsam_diastolic.text = [bsam.diastolic stringValue];
    _bsam_systolic.text = [bsam.systolic stringValue];
    BloodPressureValue *bspm = record.bspm;
    _bspm_diastolic.text = [bspm.diastolic stringValue];
    _bspm_systolic.text = [bspm.systolic stringValue];
}
- (IBAction)click:(id)sender {
    [[LogManager logManager] sendLogToEmail];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backButton:(id)sender {
    [self updateBloodPressureValues];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)clickLight:(id)sender {
    [self showAlert:@"Blood Pressure Log" withMessage:@"Record your daily blood pressures here.  Type in your morning blood pressure into the “AM” text boxes and your afternoon blood pressures into the “PM” text boxes.  Record your blood pressure as “systolic/diastolic.”  During your next appointment your physician can award you points if you maintain your blood pressures under the recommended level.  A weekly summary of your log will be emailed to your physician."];
}

- (void) updateBloodPressureValues
{
    BloodPressureValue *bsam = record.bsam;
    bsam.diastolic = ([_bsam_diastolic.text length] > 0) ? [NSNumber numberWithFloat:[_bsam_diastolic.text floatValue]] : nil;
    bsam.systolic = ([_bsam_systolic.text length] > 0) ? [NSNumber numberWithFloat:[_bsam_systolic.text floatValue]] : nil;
    BloodPressureValue *bspm = record.bspm;
    bspm.diastolic = ([_bspm_diastolic.text length] > 0) ? [NSNumber numberWithFloat:[_bspm_diastolic.text floatValue]] : nil;
    bspm.systolic = ([_bspm_systolic.text length] > 0) ? [NSNumber numberWithFloat:[_bspm_systolic.text floatValue]] : nil;
    [[LogManager logManager] saveContext];
}

// UITEXT DELEGATE

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    activeField = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)resetScrollView {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    scrollView.contentSize = CGSizeMake(screenWidth, 500);
    scrollView.frame = screenRect;
}

// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        [scrollView scrollRectToVisible:activeField.frame animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
}
- (IBAction)emailButtonClick:(id)sender {
    [[LogManager logManager] sendLogToEmail];
}

@end
