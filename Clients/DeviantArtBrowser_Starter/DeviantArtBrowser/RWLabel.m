//
//  RWLabel.m
//  DeviantArtBrowser
//
//  Created by Matthew Frederick Stradling on 5/21/15.
//  Copyright (c) 2015 Razeware, LLC. All rights reserved.
//

#import "RWLabel.h"

@implementation RWLabel

- (void)setBounds:(CGRect)bounds {
  [super setBounds:bounds];
  
  // If this is a multiline label, need to make sure
  // preferredMaxLayoutWidth always matches the frame width
  // (i.e. orientation change can mess this up)
  
  if (self.numberOfLines == 0 && bounds.size.width != self.preferredMaxLayoutWidth) {
    self.preferredMaxLayoutWidth = self.bounds.size.width;
    [self setNeedsUpdateConstraints];
  }
}

@end
