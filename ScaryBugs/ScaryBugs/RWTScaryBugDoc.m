//
//  RWTScaryBugDoc.m
//  ScaryBugs
//
//  Created by Matthew Frederick Stradling on 5/5/15.
//  Copyright (c) 2015 Matthew Frederick Stradling. All rights reserved.
//

#import "RWTScaryBugDoc.h"
#import "RWTScaryBugData.h"

@implementation RWTScaryBugDoc
@synthesize data = _data;
@synthesize thumbImage = _thumbImage;
@synthesize fullImage = _fullImage;

- (id)initWithTitle:(NSString *)title rating:(float)rating thumbImage:(UIImage *)thumbImage fullImage:(UIImage *)fullImage
{
    if ((self = [super init]))
    {
        self.data = [[RWTScaryBugData alloc] initWithTitle:title rating:rating];
        self.thumbImage = thumbImage;
        self.fullImage = fullImage;
    }
    return self;
}

@end
