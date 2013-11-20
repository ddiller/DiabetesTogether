//
//  quizManager.m
//  dayThreeTabed
//
//  Created by App Jam on 11/12/13.
//  Copyright (c) 2013 App Jam. All rights reserved.
//

#import "quizManager.h"
const int NUMQUESTIONS = 4;

@implementation quizManager
-(id)init{
    _answers = [NSMutableArray arrayWithObjects:@"B",@"D",@"D",@"A",@"A", nil];
    _answersA = [NSMutableArray arrayWithObjects:@"Not worry about your blood sugar",@"Older",@"Of Asian, African, Hispanic, or Native American ancestry",@"No more than one serving per day",@"No more than two servings per day.", nil];
    _answersB = [NSMutableArray arrayWithObjects:@"Check your blood sugar more often",@"Overweight",@"Diagnosed with high blood pressure, or have high fats (triglycerides and LDL) on your blood tests",@"No more than two servings per day",@"No more than three servings per day.", nil];
    _answersC = [NSMutableArray arrayWithObjects:@"Drink fruit juice twice per day",@"Inactive",@"A woman with a history of delivering large babies (over 9 lbs birth weight) or has had gestational diabetes",@"No more than one serving per week",@"No more than two servings per week.", nil];
    _answersD = [NSMutableArray arrayWithObjects:@"None of the above",@"All of the Above",@"All of the above",@"None of the Above",@"None of the Above", nil];
    _questions = [NSMutableArray arrayWithObjects:@"When you are sick it is especially important to:",@"You are more likely to develop type 2 diabetes if you are:",@"You are more likely to develop type 2 diabetes if you are:",@"For women: If you choose to drink alcohol, drinking in moderation means:",@"For men: If you choose to drink alcohol, drinking in moderation means:", nil];
    _descriptions = [NSMutableArray arrayWithObjects:@"Answer: B. Monitor your blood glucose every 2-4 hours to be sure your blood sugar is not getting too high or too low. ",@"Answer: D. Risk factors for type 2 diabetes include: Older age, being overweight, inactivity, being Asian, African, Hispanic, or Native American, having high blood pressure, high blood fats, and family history of type 2 diabetes.",@"Answer: D. Risk factors for type 2 diabetes include: Older age, being overweight, inactivity, being of Asian, African, Hispanic, or Native American ancestry, having high blood pressure, high blood fats, family history of type 2 diabetes, and being a woman with a history of delivering large babies or has had gestational diabetes.",@"Answer: A. The American Diabetes Association recommends these guidelines for drinking alcohol in moderation: limiting alcohol intake to no more than one serving per day for women, and no more than two servings per day for men.",@"Answer: A. The American Diabetes Association recommends these guidelines for drinking alcohol in moderation: limiting alcohol intake to no more than one serving per day for women, and no more than two servings per day for men.", nil];
    
    self = [super init];
    self.questionNumber = 0;
    if(!_manager){
        self.manager = [[PointManager alloc] init];
    }
    
    return self;
}

-(void)addPoints{
    [_manager addPointsQuiz];
}
-(void)nextQuestion{
    self.questionNumber++;
}
-(void)startOver
{
    self.questionNumber = 0;
}
@end
