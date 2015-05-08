//
//  RWTScaryBugDoc.h
//  ScaryBugs
//
//  Created by Matthew Frederick Stradling on 5/5/15.
//  Copyright (c) 2015 Matthew Frederick Stradling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class RWTScaryBugData;

@interface RWTScaryBugDoc : NSObject

@property (strong) RWTScaryBugData *data;
@property (strong) UIImage *thumbImage;
@property (strong) UIImage *fullImage;

- (id)initWithTitle:(NSString *)title rating:(float)rating thumbImage:(UIImage *)thumbImage fullImage:(UIImage *)fullImage;

@end
