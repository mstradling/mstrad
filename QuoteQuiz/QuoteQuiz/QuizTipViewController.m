//
//  QuizTipViewController.m
//  QuoteQuiz
//
//  Created by Matthew Frederick Stradling on 5/11/15.
//  Copyright (c) 2015 Matthew Frederick Stradling. All rights reserved.
//

#import "QuizTipViewController.h"

@interface QuizTipViewController ()
@property (weak, nonatomic) IBOutlet UIButton *Done;
@end

@implementation QuizTipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    int num = 15;
    self.Done.layer.cornerRadius = num - 5;
    // Do any additional setup after loading the view.
    self.tipView.text = self.tipText;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)doneAction:(id)sender {
    [self.delegate quizTipDidFinish:self];
}

@end
