//
//  MFSHelloDoc.m
//  Hello
//
//  Created by Matthew Frederick Stradling on 5/5/15.
//  Copyright (c) 2015 Matthew Frederick Stradling. All rights reserved.
//

#import "MFSHelloDoc.h"
#import "MFSHelloData.h"

@implementation MFSHelloDoc

@synthesize data = _data;
@synthesize thumbImage = _thumbImage;
@synthesize fullImage = _fullImage;

-(id)initWithTitle:(NSString *)greeting rating:(float)rating thumbImage:(UIImage *)thumbImage fullImage:(UIImage *)fullImage
{
    if ((self = [super init]))
    {
        self.data = [[MFSHelloData alloc] initWithTitle:greeting rating:rating];
        self.thumbImage = thumbImage;
        self.fullImage = fullImage;
    }
    return self;
}

@end
