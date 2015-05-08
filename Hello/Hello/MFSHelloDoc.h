//
//  MFSHelloDoc.h
//  Hello
//
//  Created by Matthew Frederick Stradling on 5/5/15.
//  Copyright (c) 2015 Matthew Frederick Stradling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MFSHelloData;

@interface MFSHelloDoc : NSObject

@property (strong) MFSHelloData *data;
@property (strong) UIImage *thumbImage;
@property (strong) UIImage *fullImage;

-(id)initWithTitle:(NSString*)greeting rating:(float)rating thumbImage:(UIImage *)thumbImage fullImage:(UIImage *)fullImage;

@end
