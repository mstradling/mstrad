//
//  DetailViewController.h
//  ScaryBugs
//
//  Created by Matthew Frederick Stradling on 5/5/15.
//  Copyright (c) 2015 Matthew Frederick Stradling. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWTRateView.h"

@class RWTScaryBugDoc;

@interface DetailViewController : UIViewController <UITextFieldDelegate, RWTRateViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

//@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) RWTScaryBugDoc *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet RWTRateView *rateView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIImagePickerController *picker;

- (IBAction)addPictureTapped:(id)sender;

- (IBAction)titleFieldTextChanged:(id)sender;

@end

