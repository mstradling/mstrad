//
//  DetailViewController.m
//  ScaryBugs
//
//  Created by Matthew Frederick Stradling on 5/5/15.
//  Copyright (c) 2015 Matthew Frederick Stradling. All rights reserved.
//

#import "DetailViewController.h"
//add
#import "RWTScaryBugDoc.h"
#import "RWTScaryBugData.h"
#import "RWTUIImageExtras.h"
#import "SVProgressHUD.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize picker = _picker;
#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    //if (self.detailItem) {
    //    self.detailDescriptionLabel.text = [self.detailItem description];
    //}
    //Update user interface for the detail item
    self.rateView.notSelectedImage = [UIImage imageNamed:@"shockedface2_empty.png"];
    self.rateView.halfSelectedImage = [UIImage imageNamed:@"shockedface2_half.png"];
    self.rateView.fullSelectedImage = [UIImage imageNamed:@"shockedface2_full.png"];
    self.rateView.editable = YES;
    self.rateView.maxRating = 5;
    self.rateView.delegate = self;
    
    if (self.detailItem)
    {
        self.titleField.text = self.detailItem.data.title;
        self.rateView.rating = self.detailItem.data.rating;
        self.imageView.image = self.detailItem.fullImage;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

-(BOOL)shouldAutorotateToInterfaceOrientation
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addPictureTapped:(id)sender {
    NSLog(@"I've been tapped");
    if (self.picker == nil)
    {
        NSLog(@"We've made it to the beginning");
        //1) show status
        [SVProgressHUD showWithStatus:@"Loading picker..."];
        
        //2) Get concurrent queue from the system
        dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        //3) Load picker in background
        dispatch_async(concurrentQueue, ^{
            self.picker = [[UIImagePickerController alloc] init];
            self.picker.delegate = self;
            self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            self.picker.allowsEditing = NO;
            
            //4) Present Picker in main thread
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:_picker animated:YES completion:nil];
                [SVProgressHUD dismiss];
                NSLog(@"End of first block");
            });
        });
        
        self.picker = [[UIImagePickerController alloc] init];
        self.picker.delegate = self;
        self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        self.picker.allowsEditing = NO;
    }
    else
    {
       [self presentViewController:_picker animated:YES completion:nil];
    }
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *fullImage = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
    //1) show status
    [SVProgressHUD showWithStatus:@"Resizing image..."];
    
    //2) Get concurrent queue from system
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //3) Resize image in background
    dispatch_async(concurrentQueue, ^{
        UIImage *thumbImage = [fullImage imageByScalingAndCroppingForSize:CGSizeMake(44, 44)];
        
        //4) Present image in main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            self.detailItem.fullImage = fullImage;
            self.detailItem.thumbImage = thumbImage;
            self.imageView.image = fullImage;
            [SVProgressHUD dismiss];
        });
    });
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)titleFieldTextChanged:(id)sender {
    self.detailItem.data.title = self.titleField.text;
}
#pragma mark UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark RWTRateViewDelegate

-(void)rateView:(RWTRateView *)rateView ratingDidChange:(float)rating
{
    self.detailItem.data.rating = rating;
}

@end
