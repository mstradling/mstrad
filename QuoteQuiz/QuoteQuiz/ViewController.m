//
//  ViewController.m
//  QuoteQuiz
//
//  Created by Matthew Frederick Stradling on 5/11/15.
//  Copyright (c) 2015 Matthew Frederick Stradling. All rights reserved.
//

#import "ViewController.h"
#import "Quiz.h"
#import <AvailabilityMacros.h>
#import "SVProgressHUD.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *Tap;
@property (weak, nonatomic) IBOutlet UIButton *Tap2;
@property (weak, nonatomic) IBOutlet UIButton *Tap3;
@property (weak, nonatomic) IBOutlet UIButton *Next;
@property (weak, nonatomic) IBOutlet UIButton *Tip;
@property (weak, nonatomic) IBOutlet UILabel * questionLabel;
@property (weak, nonatomic) IBOutlet UILabel * answer1Label;
@property (weak, nonatomic) IBOutlet UILabel * answer2Label;
@property (weak, nonatomic) IBOutlet UILabel * answer3Label;
@property (weak, nonatomic) IBOutlet UIButton * answer1Button;
@property (weak, nonatomic) IBOutlet UIButton * answer2Button;
@property (weak, nonatomic) IBOutlet UIButton * answer3Button;
@property (weak, nonatomic) IBOutlet UIImageView * movie1;
@property (weak, nonatomic) IBOutlet UIImageView * movie2;
@property (weak, nonatomic) IBOutlet UIImageView * movie3;
@property (weak, nonatomic) IBOutlet UILabel * statusLabel;
@property (weak, nonatomic) IBOutlet UIButton * startButton;
@property (weak, nonatomic) IBOutlet UIButton * infoButton;
@property (weak, nonatomic) IBOutlet UILabel * tipLabel;
@property (assign, nonatomic) NSInteger answer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Round the buttons
    int num = 15;
    self.Tap.layer.cornerRadius = num;
    self.Tap2.layer.cornerRadius = num;
    self.Tap3.layer.cornerRadius = num;
    self.Next.layer.cornerRadius = num - 5;
    self.Tip.layer.cornerRadius = num - 5;
    // Do any additional setup after loading the view, typically from a nib.
    
    self.quizIndex = 999;
    self.quiz = [[Quiz alloc] initWithQuiz:@"quotes"];
    [self nextQuizItem];
    self.questionLabel.backgroundColor = [UIColor colorWithRed:51/255.0 green:133/255.0 blue:238/255.0 alpha:1.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) quizDone
{
    NSLog(@"Quiz Done");
    //More Later
    if (self.quiz.correctCount > 0) {
        self.statusLabel.text = [NSString stringWithFormat:@"Quiz Done - Score %ld%%", (self.quiz.correctCount / self.quiz.quizCount) * 100];
        NSLog(@"After if");
    }
    else {
        self.statusLabel.text = @"Quiz Done - Score: 0%";
    }
    NSLog(@"Before Message");
    //[SVProgressHUD showSuccessWithStatus:@"Game Over!"];
    [self.startButton setTitle:@"Try Again" forState:UIControlStateNormal];
    NSLog(@"Before the svprogresshud");
    
    self.quizIndex = 999;
    NSLog(@"Leaving function");
}

- (void)nextQuizItem
{
    //Determine which question we are on
    if (self.quizIndex == 999){
        self.quizIndex = 0;
        self.statusLabel.text = @"";
    } else if ((self.quiz.quizCount-1) > self.quizIndex){
        self.quizIndex++;
    } else {
        self.quizIndex = 0;
        self.statusLabel.text = @"";
        //[SVProgressHUD showSuccessWithStatus:@"Game Over!"];
        [self quizDone];
    }
    
    if (self.quiz.quizCount >= self.quizIndex + 1){
        [self.quiz nextQuestion:self.quizIndex];
        self.questionLabel.text = self.quiz.quote;
        self.answer1Label.text = self.quiz.ans1;
        self.answer2Label.text = self.quiz.ans2;
        self.answer3Label.text = self.quiz.ans3;
    } else {
        self.quizIndex = 0;
        //NSLog(@"Before QuizDone");
        [self quizDone];
    }
    
    //Reset fields for next question
    self.answer1Label.backgroundColor = [UIColor colorWithRed:51/255.0 green:133/255.0 blue:238/255.0 alpha:1.0];
    self.answer2Label.backgroundColor = [UIColor colorWithRed:51/255.0 green:133/255.0 blue:238/255.0 alpha:1.0];
    self.answer3Label.backgroundColor = [UIColor colorWithRed:51/255.0 green:133/255.0 blue:238/255.0 alpha:1.0];
    
    self.answer1Button.hidden = NO;
    self.answer2Button.hidden = NO;
    self.answer3Button.hidden = NO;
    
    if (self.quiz.tipCount < 3) {
        self.infoButton.hidden = NO;
        self.tipLabel.text = [NSString stringWithFormat:@"Tips remaining: %ld", 3 - self.quiz.tipCount];
    } else {
        self.infoButton.hidden = YES;
        self.tipLabel.text = [NSString stringWithFormat:@"Tips remaining: %d", 0];
    }
}

- (void)checkAnswer
{
    if ([self.quiz checkQuestion:self.quizIndex forAnswer:_answer]) {
        if (self.answer == 1) {
            self.answer1Label.backgroundColor = [UIColor greenColor];
        } else if (self.answer == 2) {
            self.answer2Label.backgroundColor = [UIColor greenColor];
        } else if (self.answer == 3) {
            self.answer3Label.backgroundColor = [UIColor greenColor];
        }
    } else {
        if (self.answer == 1) {
            self.answer1Label.backgroundColor = [UIColor redColor];
        } else if (self.answer == 2) {
            self.answer2Label.backgroundColor = [UIColor redColor];
        } else if (self.answer == 3) {
            self.answer3Label.backgroundColor = [UIColor redColor];
        }
    }
    self.statusLabel.text = [NSString stringWithFormat:@"Correct: %ld Incorrect: %ld",(long)self.quiz.correctCount, (long)self.quiz.incorrectCount];
    
    self.answer1Button.hidden = YES;
    self.answer2Button.hidden = YES;
    self.answer3Button.hidden = YES;
    
    self.startButton.hidden = NO;
    
    [self.startButton setTitle:@"Next" forState:UIControlStateNormal];
}

- (IBAction)ans1Action:(id)sender
{
    self.answer = 1;
    [self checkAnswer];
}

- (IBAction)ans2Action:(id)sender
{
    self.answer = 2;
    [self checkAnswer];
}

- (IBAction)ans3Action:(id)sender
{
    self.answer = 3;
    [self checkAnswer];
}

- (IBAction)startAgain:(id)sender
{
    [self nextQuizItem];
}

- (void)quizTipDidFinish:(QuizTipViewController *) controller {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"TipModal"]) {
        QuizTipViewController * detailViewController = (QuizTipViewController *) segue.destinationViewController;
        detailViewController.delegate = self;
        detailViewController.tipText = self.quiz.tip;
        self.quiz.tipCount++;
    }
}

@end
