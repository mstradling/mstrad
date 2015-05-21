//
//  RWBasicCellTableViewCell.h
//  DeviantArtBrowser
//
//  Created by Matthew Frederick Stradling on 5/21/15.
//  Copyright (c) 2015 Razeware, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWLabel.h"

@interface RWBasicCellTableViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet RWLabel *titleLabel;
@property (nonatomic, weak) IBOutlet RWLabel *subtitleLabel;
@end
