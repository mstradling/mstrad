//
//  RWImageCell.h
//  DeviantArtBrowser
//
//  Created by Matthew Frederick Stradling on 5/21/15.
//  Copyright (c) 2015 Razeware, LLC. All rights reserved.
//

#import "RWBasicCellTableViewCell.h"

@interface RWImageCell : RWBasicCellTableViewCell
@property (nonatomic, weak) IBOutlet UIImageView *customImageView;
@end
