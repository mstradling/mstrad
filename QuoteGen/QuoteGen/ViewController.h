//
//  ViewController.h
//  QuoteGen
//
//  Created by Matthew Frederick Stradling on 5/8/15.
//  Copyright (c) 2015 Matthew Frederick Stradling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (nonatomic, strong) NSArray *myQuotes;
@property (nonatomic, strong) NSMutableArray *movieQuotes;
@property (nonatomic, strong) IBOutlet UITextView *quoteText;
@property (nonatomic, strong) IBOutlet UISegmentedControl *quoteOpt;

- (IBAction)quoteButtonTapped:(id)sender;

@end

