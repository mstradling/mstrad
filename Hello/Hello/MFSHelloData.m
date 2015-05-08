//
//  MFSHelloData.m
//  Hello
//
//  Created by Matthew Frederick Stradling on 5/5/15.
//  Copyright (c) 2015 Matthew Frederick Stradling. All rights reserved.
//

#import "MFSHelloData.h"

@implementation MFSHelloData
@synthesize greeting = _greeting;
@synthesize rating = _rating;

-(id)initWithTitle:(id)greeting rating:(float)rating
{
    if ((self = [super init]))
    {
        self.greeting = greeting;
        self.rating = rating;
    }
    return self;
}

@end
