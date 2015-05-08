//
//  ViewController.h
//  Tap me
//
//  Created by Matthew Frederick Stradling on 5/4/15.
//  Copyright (c) 2015 Matthew Frederick Stradling. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController<UIAlertViewDelegate>
{
    IBOutlet UILabel *scoreLabel;
    IBOutlet UILabel *timerLabel;
    
    NSInteger count;
    NSInteger seconds;
    NSTimer *timer;
    
    //AVAudioPlayer
    AVAudioPlayer *buttonBeep;
    AVAudioPlayer *secondBeep;
    AVAudioPlayer *backgroundMusic;
}

- (IBAction)buttonPressed;

@end

