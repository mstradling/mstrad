//
//  RankPickerViewController.h
//  GMRatings
//
//  Created by Matthew Frederick Stradling on 5/22/15.
//  Copyright (c) 2015 Matthew Frederick Stradling. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RankPickerViewController;

@protocol RankPickerViewControllerDelegate <NSObject>

- (void)rankPickerViewController:(RankPickerViewController *)controller didSelectRank:(NSString *)rank;

@end

@interface RankPickerViewController : UITableViewController

@property (nonatomic, weak) id <RankPickerViewControllerDelegate> delegate;
@property (nonatomic, strong) NSString *rank;
@property (nonatomic, assign) NSInteger *code;

@end
