//
//  MasterViewController.m
//  ScaryBugs
//
//  Created by Matthew Frederick Stradling on 5/5/15.
//  Copyright (c) 2015 Matthew Frederick Stradling. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
//Add
#import "RWTScaryBugDoc.h"
#import "RWTScaryBugData.h"

@interface MasterViewController ()


@property NSMutableArray *objects;
@end

@implementation MasterViewController

//add
@synthesize bugs = _bugs;

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTapped:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    
    self.title = @"Scary Bugs";
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

//added
-(void)didMoveToParentViewController:(UIViewController *)parent
{
    [self.tableView reloadData];
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //if ([[segue identifier] isEqualToString:@"showDetail"]) {
    //    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    //    NSDate *object = self.objects[indexPath.row];
    //    [[segue destinationViewController] setDetailItem:object];
    //}
    DetailViewController *detailController = segue.destinationViewController;
    RWTScaryBugDoc *bug = [self.bugs objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    detailController.detailItem = bug;
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return self.objects.count;
    return _bugs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    //NSDate *object = self.objects[indexPath.row];
    //cell.textLabel.text = [object description];
    //return cell;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyBasicCell"];
    RWTScaryBugDoc *bug = [self.bugs objectAtIndex:indexPath.row];
    cell.textLabel.text = bug.data.title;
    cell.imageView.image = bug.thumbImage;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [_bugs removeObjectAtIndex:indexPath.row];
        //[self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (void)addTapped:(id)sender
{
    RWTScaryBugDoc *newDoc = [[RWTScaryBugDoc alloc] initWithTitle:@"New Bug" rating:0 thumbImage:nil fullImage:nil];
    [_bugs addObject:newDoc];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_bugs.count-1 inSection:0];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:YES];
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    [self performSegueWithIdentifier:@"MySegue" sender:self];
}

@end
