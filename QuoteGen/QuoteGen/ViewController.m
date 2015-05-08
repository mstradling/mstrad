//
//  ViewController.m
//  QuoteGen
//
//  Created by Matthew Frederick Stradling on 5/8/15.
//  Copyright (c) 2015 Matthew Frederick Stradling. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *Tap;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.Tap.layer.cornerRadius = 25;
    
    // Do any additional setup after loading the view, typically from a nib.
    self.myQuotes = @[
                      @"Live and let live",
                      @"Don't cry over spilt milk",
                      @"Always look on the bright side of life",
                      @"Nobody's perfect",
                      @"Can't see the woods for the trees",
                      @"Better to have loved and lost then not loved at all",
                      @"The early bird catched the worm",
                      @"As slow as a wet week",
                      @"Don't sweat the small stuff",
                      @"Don't worry, don't stress, just do your best",
                      @"Life is only 10 percent what you make it\n but 90 percent how you take it"
                      ];
    NSString *plistCatPath = [[NSBundle mainBundle] pathForResource:@"quotes" ofType:@"plist"];
    self.movieQuotes = [NSMutableArray arrayWithContentsOfFile:plistCatPath];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)quoteButtonTapped:(id)sender{
    // 1 - Get personal quotes when the final segment is selected
    if (self.quoteOpt.selectedSegmentIndex == 2) {
        // 1 - Get number of rows in array
        unsigned long array_tot = (unsigned long)[self.myQuotes count];
        // 1.2 - Initialize string for concatenated quotes
        NSString *all_my_quotes = @"";
        NSString *my_quote = nil;
        // 1.3 - Iterate through the array
        for (int x = 0; x < array_tot; x++) {
            my_quote = self.myQuotes[x];
            all_my_quotes = [NSString stringWithFormat:@"%@\n%@\n", all_my_quotes, my_quote];
        }
        self.quoteText.text = [NSString stringWithFormat:@"%@", all_my_quotes];
        // 2 - Get random index
        //int index = (arc4random() % array_tot);
        // 3 - Get the quote string for the index
        //NSString *my_quote = self.myQuotes[index];
        // 4 - Display the quote in the text view
        //self.quoteText.text = [NSString stringWithFormat:@"Quote:\n\n%@",  my_quote];
    }
    // 2 - Get movie quotes
    else {
        // 2.1 - determine category
        NSString *selectedCategory = @"classic";
        if (self.quoteOpt.selectedSegmentIndex == 1) {
            selectedCategory = @"modern";
        }
        // 2.2 - filter array by category using predicate
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category == %@", selectedCategory];
        NSArray *filteredArray = [self.movieQuotes filteredArrayUsingPredicate:predicate];
        // 2.3 - get total number in filtered array
        unsigned long array_tot = (unsigned long)[filteredArray count];
        // 2.4 - as a safeguard only get quote when the array has rows in it
        if (array_tot > 0) {
            // 2.5 - get random index
            int index = (arc4random() % array_tot);
            // 2.6 - get the quote string for the index
            NSString *quote = filteredArray[index][@"quote"];
            // 2.7 - Check if there is a source
            NSString *source = [[filteredArray objectAtIndex:index] valueForKey:@"source"];
            if (![source length] == 0) {
                quote = [NSString stringWithFormat:@"%@\n\n(%@)", quote, source];
            }
            // 2.8 - Set display string
            //self.quoteText.text = [NSString stringWithFormat:@"Movie Quote:\n\n%@",  quote];
            if ([selectedCategory isEqualToString:@"classic"]) {
                quote = [NSString stringWithFormat:@"From Classic Movie\n\n%@", quote];
            } else {
                quote = [NSString stringWithFormat:@"Movie Quote:\n\n%@", quote];
            }
            // Extra text
            if ([source hasPrefix:@"The Emperor's"]) {
                quote = [NSString stringWithFormat:@"%@\n\nThis movie is so funny!!!", quote];
            }
            // 2.9 - Display quote
            self.quoteText.text = quote;
        } else {
            self.quoteText.text = [NSString stringWithFormat:@"No quotes to display."];
        }
    }
}

@end
