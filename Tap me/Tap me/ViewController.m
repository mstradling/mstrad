//
//  ViewController.m
//  Tap me
//
//  Created by Matthew Frederick Stradling on 5/4/15.
//  Copyright (c) 2015 Matthew Frederick Stradling. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *Tap;

@end

@implementation ViewController

- (AVAudioPlayer *)setupAudioPlayerWithFile:(NSString *)file type:(NSString *)type
{
    //1
    NSString *path = [[NSBundle mainBundle] pathForResource:file ofType:type];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    //2
    NSError *error;
    
    //3
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    //4
    if (!audioPlayer)
    {
        NSLog(@"%@",[error description]);
    }
    //5
    return audioPlayer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //Round the button
    self.Tap.layer.cornerRadius = 50;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_title.png"]];
    scoreLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"field_score.png"]];
    timerLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"field_time.png"]];
    
    //AudioPlayer
    buttonBeep = [self setupAudioPlayerWithFile:@"ButtonTap" type:@"wav"];
    secondBeep = [self setupAudioPlayerWithFile:@"SecondBeep" type:@"wav"];
    backgroundMusic = [self setupAudioPlayerWithFile:@"HallOfTheMountainKing" type:@"mp3"];
    
    [self setupGame];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed
{
    count++;
    scoreLabel.text = [NSString stringWithFormat:@"Score\n%i", count];
    [buttonBeep play];
}

- (void)setupGame
{
    //1
    seconds = 30;
    count = 0;
    
    //2
    timerLabel.text = [NSString stringWithFormat:@"Time: %i", seconds];
    scoreLabel.text = [NSString stringWithFormat:@"Score\n%i", count];
    timer = [NSTimer scheduledTimerWithTimeInterval: 1.0f
                                             target:self selector:@selector(subtractTime) userInfo:nil repeats:YES];
    [backgroundMusic setVolume:0.3];
    [backgroundMusic play];
}

- (void)subtractTime
{
    //1
    seconds--;
    timerLabel.text = [NSString stringWithFormat:@"Time: %i", seconds];
    [secondBeep play];
    //2
    if(seconds == 0)
    {
        [timer invalidate];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Time is up!" message:[NSString stringWithFormat:@"You scored %i points", count] delegate:self cancelButtonTitle:@"Play again?" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self setupGame];
}

- (BOOL)shouldAutorotateToInterfaceOrientation
{
    return YES;
}
@end
