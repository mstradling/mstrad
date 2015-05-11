//
//  QuizTipViewController.h
//  QuoteQuiz
//
//  Created by Matthew Frederick Stradling on 5/11/15.
//  Copyright (c) 2015 Matthew Frederick Stradling. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QuizTipViewControllerDelegate;

@interface QuizTipViewController : UIViewController

@property (nonatomic, assign) id <QuizTipViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextView * tipView;
@property (nonatomic, copy) NSString * tipText;

- (IBAction)doneAction:(id)sender;

@end

@protocol QuizTipViewControllerDelegate

- (void)quizTipDidFinish:(QuizTipViewController *) controller;

@end