//
//  PlayerDetailsViewController.swift
//  SwiftRatings
//
//  Created by Matthew Frederick Stradling on 6/1/15.
//  Copyright (c) 2015 Matthew Frederick Stradling. All rights reserved.
//

import UIKit

class PlayerDetailsViewController: UITableViewController {
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var detailLabel: UILabel!
  @IBOutlet weak var rankLabel: UILabel!
  var player:Player!
  var game:String = "Chess"
  var rank:String = "1 Star"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    detailLabel.text = game
    rankLabel.text = rank
  }

  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if indexPath.section == 0 {
      nameTextField.becomeFirstResponder()
    }
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "SavePlayerDetail" {
      var rating:Int!
      if rank == "1 Star" {//ADDED BY MFS
        rating = 1
      } else if rank == "2 Stars" {
        rating = 2
      } else if rank == "3 Stars" {
        rating = 3
      } else if rank == "4 Stars" {
        rating = 4
      } else {
        rating = 5
      }
      player = Player(name: self.nameTextField.text, game: game, rating: rating)
    }
    if segue.identifier == "PickGame" {
      if let gamePickerViewController = segue.destinationViewController as? GamePickerViewController {
        gamePickerViewController.selectedGame = game
      }
    }
    if segue.identifier == "PickRank" {
      if let rankPickerViewController = segue.destinationViewController as? RankPickerViewController {
        rankPickerViewController.selectedRank = rank
      }
    }
  }
  
  required init!(coder aDecoder: NSCoder!) {
    println("Init PlayerDetailsViewController")
    super.init(coder: aDecoder)
  }
  
  deinit {
    println("deinit PlayerDetailsViewController")
  }
  
  @IBAction func selectGame(segue:UIStoryboardSegue) {
    if let gamePickerVC = segue.sourceViewController as? GamePickerViewController, selectedGame = gamePickerVC.selectedGame {
      detailLabel.text = selectedGame
      game = selectedGame
    }
  }
  
  @IBAction func selectRank(segue:UIStoryboardSegue) {
    if let rankPickerVC = segue.sourceViewController as? RankPickerViewController, selectedRank = rankPickerVC.selectedRank {
      rankLabel.text = selectedRank
      rank = selectedRank
    }
  }
}
