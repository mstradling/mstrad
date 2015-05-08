//
//  MasterViewController.m
//  Hello
//
//  Created by Matthew Frederick Stradling on 5/5/15.
//  Copyright (c) 2015 Matthew Frederick Stradling. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "MFSHelloData.h"
#import "MFSHelloDoc.h"
#import <UIKit/UIKit.h>
#import <AvailabilityMacros.h>
#import "SVProgressHUD.h"
//#import <Reachability/Reachability.h>


@interface MasterViewController ()

@property NSMutableArray *objects;
@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (AVAudioPlayer *)setupAudioPlayerWithFile:(NSString *)file type:(NSString *)type
{
    //1
    NSString *path = [[NSBundle mainBundle] pathForResource:file ofType:type];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    //2
    NSError *error;
    
    //3
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    //4
    if (!audioPlayer)
    {
        NSLog(@"%@",[error description]);
    }
    //5
    return audioPlayer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    self.view.backgroundColor = [UIColor blueColor];
    _backgroundMusic = [self setupAudioPlayerWithFile:@"HallOfTheMountainKing" type:@"mp3"];

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTapped:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    self.title = @"Hello World Deluxe!";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    [self.objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //if ([[segue identifier] isEqualToString:@"showDetail"]) {
    //    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    //    NSDate *object = self.objects[indexPath.row];
    //    [[segue destinationViewController] setDetailItem:object];
    //}
    DetailViewController *detailController = segue.destinationViewController;
    //MFSHelloDoc *space = [self.spaces objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    detailController.detailItems = self.spaces;
    detailController.index = self.tableView.indexPathForSelectedRow.row;
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _spaces.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    //NSDate *object = self.objects[indexPath.row];
    //cell.textLabel.text = [object description];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyBasicCell"];
    MFSHelloDoc *space = [self.spaces objectAtIndex:indexPath.row];
    cell.textLabel.text = space.data.greeting;
    cell.imageView.image = space.thumbImage;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

-(void)didMoveToParentViewController:(UIViewController *)parent
{
    [self.tableView reloadData];
}

-(void)addTapped:(id)sender
{
    [SVProgressHUD showErrorWithStatus:@"ERROR: Button does nothing"];
    [_backgroundMusic setVolume:0.3];
    [_backgroundMusic play];
}

@end
