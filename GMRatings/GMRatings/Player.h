//
//  Player.h
//  GMRatings
//
//  Created by Matthew Frederick Stradling on 5/21/15.
//  Copyright (c) 2015 Matthew Frederick Stradling. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *game;
@property (nonatomic, assign) int rating;
@end
