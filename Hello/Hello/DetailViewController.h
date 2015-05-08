//
//  DetailViewController.h
//  Hello
//
//  Created by Matthew Frederick Stradling on 5/5/15.
//  Copyright (c) 2015 Matthew Frederick Stradling. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWTRateView.h"

@class MFSHelloDoc;

@interface DetailViewController : UIViewController <UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> //RWTRateViewDelegate, 

@property (strong, nonatomic) NSArray *detailItems;
@property (nonatomic, assign) NSInteger index;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)buttonTapped:(id)sender;

@end

