//
//  MFSHelloData.h
//  Hello
//
//  Created by Matthew Frederick Stradling on 5/5/15.
//  Copyright (c) 2015 Matthew Frederick Stradling. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MFSHelloData : NSObject
@property (strong) NSString *greeting;
@property (assign) float rating;

- (id)initWithTitle:(NSString*)greeting rating:(float)rating;

@end
