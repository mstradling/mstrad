//
//  PlayerDetailsViewControllerTableViewController.m
//  GMRatings
//
//  Created by Matthew Frederick Stradling on 5/21/15.
//  Copyright (c) 2015 Matthew Frederick Stradling. All rights reserved.
//

#import "PlayerDetailsViewController.h"
#import "Player.h"

@interface PlayerDetailsViewController ()

@end

@implementation PlayerDetailsViewController
{
  NSString *_game;
  NSString *_rank;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  self.detailLabel.text = _game;
  self.detailRank.text = _rank;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  // Bring up the keyboard when they select the cell
  if (indexPath.section == 0) {
    [self.nameTextField becomeFirstResponder];
  }
}

- (IBAction)cancel:(id)sender
{
  [self.delegate playerDetailsViewControllerDidCancel:self];
}
- (IBAction)done:(id)sender
{
  Player *player = [[Player alloc] init];
  player.name = self.nameTextField.text;
  player.game = _game;
  if ([_rank isEqualToString:@"1 Star"]) {
    player.rating = 1;
  } else if ([_rank isEqualToString:@"2 Stars"]) {
    player.rating = 2;
  } else if ([_rank isEqualToString:@"3 Stars"]) {
    player.rating = 3;
  } else if ([_rank isEqualToString:@"4 Stars"]) {
    player.rating = 4;
  } else {
    player.rating = 5;
  }
  [self.delegate playerDetailsViewControllerDidSave:self didAddPlayer:player];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
  if ((self = [super initWithCoder:aDecoder])) {
    NSLog(@"init PlayerDetailsViewController");
    _game = @"Chess"; // default
    _rank = @"1 Star"; //default
  }
  return self;
}

- (void)dealloc
{
  NSLog(@"dealloc PlayerDetailsViewController");
}

- (void)gamePickerViewController:(GamePickerViewController *)controller didSelectGame:(NSString *)game
{
  _game = game;
  self.detailLabel.text = _game;
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)rankPickerViewController:(RankPickerViewController *)controller didSelectRank:(NSString *)rank
{
  _rank = rank;
  self.detailRank.text = _rank;
  [self.navigationController popViewControllerAnimated:YES];
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
  if ([segue.identifier isEqualToString:@"PickGame"]) {
    GamePickerViewController *gamePickerVC = segue.destinationViewController;
    gamePickerVC.delegate = self;
    gamePickerVC.game = _game;
  } else if ([segue.identifier isEqualToString:@"PickRank"]) {
    RankPickerViewController *rankPickerVC = segue.destinationViewController;
    rankPickerVC.delegate = self;
    rankPickerVC.rank = _rank;
  }
}


@end
