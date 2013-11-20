//
//  QuizViewController.m
//  dayThreeTabed
//
//  Created by App Jam on 11/12/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import "QuizViewController.h"
#import "quizManager.h"


@interface QuizViewController ()

@property (weak, nonatomic) IBOutlet UILabel *questionTitle;
@property (weak, nonatomic) IBOutlet UILabel *questionBody;
@property (weak, nonatomic) IBOutlet UILabel *answerOne;
@property (weak, nonatomic) IBOutlet UILabel *answerTwo;
@property (weak, nonatomic) IBOutlet UILabel *answerThree;
@property (weak, nonatomic) IBOutlet UILabel *answerFour;
@property (weak, nonatomic) IBOutlet UISwitch *checkOne;
@property (weak, nonatomic) IBOutlet UISwitch *checkTwo;
@property (weak, nonatomic) IBOutlet UISwitch *checkThree;
@property (weak, nonatomic) IBOutlet UISwitch *checkFour;
@property (strong, nonatomic) quizManager *quizManager;

@end

@implementation QuizViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
    }
    return self;
}
-(void)setQuestions:(quizManager*)qManager{
    self.questionTitle.text = [NSString stringWithFormat:@"Question Number: %d", (int)qManager.questionNumber +1];
    self.questionBody.text = [qManager.questions objectAtIndex:((int)qManager.questionNumber)];
    self.answerOne.text = [qManager.answersA objectAtIndex:((int)qManager.questionNumber)];
    self.answerTwo.text = [qManager.answersB objectAtIndex:((int)qManager.questionNumber)];
    self.answerThree.text = [qManager.answersC objectAtIndex:((int)qManager.questionNumber)];
    self.answerFour.text = [qManager.answersD objectAtIndex:((int)qManager.questionNumber)];
    
    
}

-(void)resetButtons{
    [_checkOne setOn:NO animated:YES];
    [_checkTwo setOn:NO animated:YES];
    [_checkThree setOn:NO animated:YES];
    [_checkFour setOn:NO animated:YES];
}
- (IBAction)checkOneClick:(id)sender {
    if([_checkTwo isOn])
        [_checkTwo setOn:NO animated:YES];
    if([_checkThree isOn])
        [_checkThree setOn:NO animated:YES];
    if([_checkFour isOn])
        [_checkFour setOn:NO animated:YES];
}
- (IBAction)checkTwoClick:(id)sender {
    if([_checkOne isOn])
        [_checkOne setOn:NO animated:YES];
    if([_checkThree isOn])
        [_checkThree setOn:NO animated:YES];
    if([_checkFour isOn])
        [_checkFour setOn:NO animated:YES];
}
- (IBAction)checkThreeClick:(id)sender {
    if([_checkTwo isOn])
        [_checkTwo setOn:NO animated:YES];
    if([_checkOne isOn])
        [_checkOne setOn:NO animated:YES];
    if([_checkFour isOn])
        [_checkFour setOn:NO animated:YES];
}
- (IBAction)checkFourClicked:(id)sender {
    if([_checkOne isOn])
        [_checkOne setOn:NO animated:YES];
    if([_checkTwo isOn])
        [_checkTwo setOn:NO animated:YES];
    if([_checkThree isOn])
        [_checkThree setOn:NO animated:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	self.quizManager = [[quizManager alloc] init];
    NSLog(@"opened quiz manager");
    [self setQuestions:self.quizManager];
    
}
- (IBAction)quitClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)nextQuestion:(id)sender {
    NSString* userAnswer = @"0";
    if(_checkOne.isOn){
        userAnswer = @"A";
    }else if (_checkTwo.isOn){
        userAnswer = @"B";
    }else if (_checkThree.isOn){
        userAnswer = @"C";
    }else if (_checkFour.isOn){
        userAnswer = @"D";
    }else{}
    if(![userAnswer  isEqual: @"0"]){
        int questionNum = (int)self.quizManager.questionNumber;
        if((int)self.quizManager.questionNumber == NUMQUESTIONS){
            if([[self.quizManager.answers objectAtIndex:questionNum] isEqualToString: userAnswer]){
                [self.quizManager addPoints];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Well Done!" message:[NSString stringWithFormat:@"good job u earned %d points", QUIZPOINTS] delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [self dismissViewControllerAnimated:YES completion:nil];
            
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wrong" message:[NSString stringWithFormat:@"%@%@", @"The correct answer is: ",[self.quizManager.answers objectAtIndex:questionNum]] delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [self.quizManager startOver];
                [self resetButtons];
                [self setQuestions:self.quizManager];
            }
        
        }else{
            if([[self.quizManager.answers objectAtIndex:questionNum] isEqualToString: userAnswer]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Good Job" message:@"you got that one right!" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [self.quizManager nextQuestion];
                [self resetButtons];
                [self setQuestions:self.quizManager];
            }else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wrong" message:[NSString stringWithFormat:@"%@%@", @"The correct answer is: ",[self.quizManager.answers objectAtIndex:questionNum]] delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];

                [self.quizManager startOver];
                [self resetButtons];
                [self setQuestions:self.quizManager];
            }
        }
    }else{
        //if user didnt answer
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"You didnt select an answer..." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
