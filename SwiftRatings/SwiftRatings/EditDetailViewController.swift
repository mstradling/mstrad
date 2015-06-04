//
//  EditDetailViewController.swift
//  SwiftRatings
//
//  Created by Matthew Frederick Stradling on 6/4/15.
//  Copyright (c) 2015 Matthew Frederick Stradling. All rights reserved.
//
//ADDED BY MFS//ADDED BY MFS//ADDED BY MFS
import UIKit

class EditDetailViewController: UITableViewController {
  @IBOutlet weak var nameField: UITextField!
  @IBOutlet weak var detailLabel: UILabel!
  @IBOutlet weak var rankLabel: UILabel!
  var player:Player!
  var game:String!
  var rank:String!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    game = player.game //ADDED BY MFS
    rank = rankStringForInt(player.rating) //ADDED BY MFS
    detailLabel.text = game
    rankLabel.text = rank
    nameField.text = player.name
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if indexPath.section == 0 {
      nameField.becomeFirstResponder()
    }
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "SaveEditedDetail" {
      var rating:Int!
      
      rating = rankIntForString(rank)
      player = Player(name: self.nameField.text, game: game, rating: rating)
    }
    if segue.identifier == "PickGame2" {
      if let gamePickerViewController = segue.destinationViewController as? GamePickerViewController {
        gamePickerViewController.selectedGame = game
      }
    }
    if segue.identifier == "PickRank2" {
      if let rankPickerViewController = segue.destinationViewController as? RankPickerViewController {
        rankPickerViewController.selectedRank = rank
      }
    }
  }
  
  required init!(coder aDecoder: NSCoder!) {
    println("Init EditDetailsViewController")
    super.init(coder: aDecoder)
  }
  
  deinit {
    println("deinit EditDetailsViewController")
  }
  
  func rankIntForString(rankText:String) ->Int { //ADDED BY MFS
    switch rankText {
    case "1 Star":
      return 1
    case "2 Stars":
      return 2
    case "3 Stars":
      return 3
    case "4 Stars":
      return 4
    default:
      return 5
    }
  }
  
  func rankStringForInt(rankInt:Int) ->String { //ADDED BY MFS
    switch rankInt {
    case 1:
      return "1 Star"
    case 2:
      return "2 Stars"
    case 3:
      return "3 Stars"
    case 4:
      return "4 Stars"
    default:
      return "5 Stars"
    }
  }
  
  @IBAction func gameSelected(segue:UIStoryboardSegue) {
    if let gamePickerVC = segue.sourceViewController as? GamePickerViewController, selectedGame = gamePickerVC.selectedGame {
      detailLabel.text = selectedGame
      game = selectedGame
    }
  }
  
  @IBAction func rankSelected(segue:UIStoryboardSegue) {
    if let rankPickerVC = segue.sourceViewController as? RankPickerViewController, selectedRank = rankPickerVC.selectedRank {
      rankLabel.text = selectedRank
      rank = selectedRank
    }
  }

}
