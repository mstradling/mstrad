//
//  DetailViewController.m
//  Hello
//
//  Created by Matthew Frederick Stradling on 5/5/15.
//  Copyright (c) 2015 Matthew Frederick Stradling. All rights reserved.
//

#import "DetailViewController.h"
#import "MFSHelloDoc.h"
#import "MFSHelloData.h"
#import "RWTUIImageExtras.h"

@interface DetailViewController ()

@end

@implementation DetailViewController 

#pragma mark - Managing the detail item

/*- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}*/

- (void)configureView {
    // Update the user interface for the detail item.
    //if (self.detailItem) {
    //    self.detailDescriptionLabel.text = [self.detailItem description];
    //}
    MFSHelloDoc *space = _detailItems[_index];
    //if(self.detailItem)
    //{
        self.titleField.text = space.data.greeting;
        self.imageView.image = space.fullImage;
    //}
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation
{
    return YES;
}
- (IBAction)buttonTapped:(id)sender {
    NSLog(@"Pressed!");
    
    _index = (_index + 1) % 3;
    [self configureView];
}
@end
