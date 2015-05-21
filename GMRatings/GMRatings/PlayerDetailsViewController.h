//
//  PlayerDetailsViewControllerTableViewController.h
//  GMRatings
//
//  Created by Matthew Frederick Stradling on 5/21/15.
//  Copyright (c) 2015 Matthew Frederick Stradling. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlayerDetailsViewController;

@protocol PlayerDetailsViewControllerDelegate <NSObject>
- (void)playerDetailsViewControllerDidCancel:(PlayerDetailsViewController *)controller;
- (void)playerDetailsViewControllerDidSave:(PlayerDetailsViewController *)controller;
@end

@interface PlayerDetailsViewController : UITableViewController

@property (nonatomic, weak) id <PlayerDetailsViewControllerDelegate> delegate;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
