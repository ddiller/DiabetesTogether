//
//  RecordInputViewController.m
//  CDTutorial
//
//  Created by App Jam on 11/17/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import "GlucoseInputViewController.h"
#import "LogManager.h"
#import "GlucoseValue.h"

@interface GlucoseInputViewController ()
@property (weak, nonatomic) IBOutlet UITextField *gcbreak_pre;
@property (weak, nonatomic) IBOutlet UITextField *gcbreak_post;
@property (weak, nonatomic) IBOutlet UITextField *gcbreak_carb;
@property (weak, nonatomic) IBOutlet UITextField *gclunch_pre;
@property (weak, nonatomic) IBOutlet UITextField *gclunch_post;
@property (weak, nonatomic) IBOutlet UITextField *gclunch_carb;
@property (weak, nonatomic) IBOutlet UITextField *gcdinner_pre;
@property (weak, nonatomic) IBOutlet UITextField *gcdinner_post;
@property (weak, nonatomic) IBOutlet UITextField *gcdinner_carb;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) Record *record;
@property (nonatomic, weak) UITextField *activeField;

@end

@implementation GlucoseInputViewController

@synthesize record, scrollView, activeField;
- (IBAction)backButton:(id)sender {
    [self updateGlucoseValues];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    record = [[LogManager logManager] currentRecord];
}
-(void)showAlert:(NSString*)title withMessage:(NSString*)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}
- (IBAction)clickLight:(id)sender {
    [self showAlert:@"Blood Glucose Log" withMessage:@"Record your daily “blood glucose” (blood sugar) levels here.  Be sure to log in your blood glucose levels both before and after each meal.  You can also record the total number of carbohydrates for each meal, in the box labeled “carbs” next to the corresponding meal.    If you keep your blood sugars within the recommended range your physician can award you points during your next visit.  A weekly summary of your log will be emailed to your physician."];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self resetScrollView];
    [self registerForKeyboardNotifications];
    
    GlucoseValue *gcbreak = record.gcbreak;
    _gcbreak_pre.text = [gcbreak.pre_glucose stringValue];
    _gcbreak_post.text = [gcbreak.post_glucose stringValue];
    _gcbreak_carb.text= [gcbreak.carb_count stringValue];
    
    GlucoseValue *gclunch = record.gclunch;
    _gclunch_pre.text = [gclunch.pre_glucose stringValue];
    _gclunch_post.text = [gclunch.post_glucose stringValue];
    _gclunch_carb.text = [gclunch.carb_count stringValue];
    
    GlucoseValue *gcdinner = record.gcdinner;
    _gcdinner_pre.text = [gcdinner.pre_glucose stringValue];
    _gcdinner_post.text = [gcdinner.post_glucose stringValue];
    _gcdinner_carb.text = [gcdinner.carb_count stringValue];
}

- (void)resetScrollView {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    scrollView.contentSize = CGSizeMake(screenWidth, 500);
    scrollView.frame = screenRect;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) updateGlucoseValues
{
    GlucoseValue *gcbreak = record.gcbreak;
    gcbreak.pre_glucose = ([_gcbreak_pre.text length] > 0) ? [NSNumber numberWithFloat:[_gcbreak_pre.text floatValue]] : nil;
    gcbreak.post_glucose = ([_gcbreak_post.text length] > 0) ? [NSNumber numberWithFloat:[_gcbreak_post.text floatValue]] : nil;
    gcbreak.carb_count =  ([_gcbreak_carb.text length] > 0) ? [NSNumber numberWithFloat:[_gcbreak_carb.text floatValue]] : nil;
    
    GlucoseValue *gclunch = record.gclunch;
    gclunch.pre_glucose = ([_gclunch_pre.text length] > 0) ? [NSNumber numberWithFloat:[_gclunch_pre.text floatValue]] : nil;
    gclunch.post_glucose = ([_gclunch_post.text length] > 0) ? [NSNumber numberWithFloat:[_gclunch_post.text floatValue]] : nil;
    gclunch.carb_count =  ([_gclunch_carb.text length] > 0) ? [NSNumber numberWithFloat:[_gclunch_carb.text floatValue]] : nil;
    
    GlucoseValue *gcdinner = record.gcdinner;
    gcdinner.pre_glucose = ([_gcdinner_pre.text length] > 0) ? [NSNumber numberWithFloat:[_gcdinner_pre.text floatValue]] : nil;
    gcdinner.post_glucose = ([_gcdinner_post.text length] > 0) ? [NSNumber numberWithFloat:[_gcdinner_post.text floatValue]] : nil;
    gcdinner.carb_count =  ([_gcdinner_carb.text length] > 0) ? [NSNumber numberWithFloat:[_gcdinner_carb.text floatValue]] : nil;
    
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
    NSLog(@"Keyboard was shown");
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(60, 0.0, kbSize.height, 0.0);
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

//- (void)keyboardWasShown:(NSNotification*)aNotification {
//    NSDictionary* info = [aNotification userInfo];
//    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
//    CGRect bkgndRect = activeField.superview.frame;
//    bkgndRect.size.height += kbSize.height;
//    [activeField.superview setFrame:bkgndRect];
//    [scrollView setContentOffset:CGPointMake(0.0, activeField.frame.origin.y-kbSize.height) animated:YES];
//}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    [self resetScrollView];
}

@end
