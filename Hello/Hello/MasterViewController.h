//
//  MasterViewController.h
//  Hello
//
//  Created by Matthew Frederick Stradling on 5/5/15.
//  Copyright (c) 2015 Matthew Frederick Stradling. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface MasterViewController : UITableViewController
@property (strong) NSMutableArray *spaces;
@property (strong) AVAudioPlayer *backgroundMusic;

@end

