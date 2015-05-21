//
//  PlayersViewController.h
//  GMRatings
//
//  Created by Matthew Frederick Stradling on 5/21/15.
//  Copyright (c) 2015 Matthew Frederick Stradling. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerDetailsViewController.h"

@interface PlayersViewController : UITableViewController <PlayerDetailsViewControllerDelegate>
@property (nonatomic, strong) NSMutableArray *players;
@end
