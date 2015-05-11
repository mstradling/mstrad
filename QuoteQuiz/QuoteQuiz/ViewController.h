//
//  ViewController.h
//  QuoteQuiz
//
//  Created by Matthew Frederick Stradling on 5/11/15.
//  Copyright (c) 2015 Matthew Frederick Stradling. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuizTipViewController.h";
@class Quiz;

@interface ViewController : UIViewController <QuizTipViewControllerDelegate>

@property (nonatomic, strong) Quiz *quiz;
@property (nonatomic, assign) NSInteger quizIndex;
- (IBAction)ans1Action:(id)sender;
- (IBAction)ans2Action:(id)sender;
- (IBAction)ans3Action:(id)sender;
- (IBAction)startAgain:(id)sender;

@end

