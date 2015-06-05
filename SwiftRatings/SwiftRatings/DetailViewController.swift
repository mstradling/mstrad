//
//  DetailViewController.swift
//  SwiftRatings
//
//  Created by Matthew Frederick Stradling on 6/4/15.
//  Copyright (c) 2015 Matthew Frederick Stradling. All rights reserved.
//
 //ADDED BY MFS //ADDED BY MFS //ADDED BY MFS
import UIKit

class DetailViewController: UIViewController {
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var rateView: UIImageView!
  var player:Player!
  
  override func viewDidLoad() { //ADDED BY MFS
    super.viewDidLoad()
    nameLabel.text = player.name
    rateView.image = imageForRating(player.rating)
    imageView.image = imageForGame(player.game)
  }
  
  func imageForRating(rating:Int) -> UIImage? { //ADDED BY MFS
    switch rating {
    case 1:
      return UIImage(named: "1StarSmall")
    case 2:
      return UIImage(named: "2StarsSmall")
    case 3:
      return UIImage(named: "3StarsSmall")
    case 4:
      return UIImage(named: "4StarsSmall")
    case 5:
      return UIImage(named: "5StarsSmall")
    default:
      return nil
    }
  }
  
  func imageForGame(game:String) -> UIImage? { //ADDED BY MFS
    switch game {
      case "Angry Birds":
      return UIImage(named: "AngryBirds.jpg")
      case "Chess":
      return UIImage(named: "CHESS.png")
      case "Texas Hold'em Poker":
      return UIImage(named: "poker.jpg")
      case "Tic-Tac-Toe":
      return UIImage(named: "TicTacToe.png")
      case "Super Smash Bros":
      return UIImage(named: "SSBsmall.jpg")
      case "Fire Emblem":
      return UIImage(named: "FireEmblem.jpg")
      case "Soul Calibur":
      return UIImage(named: "SoulCalibur.jpg")
      case "Pokemon":
      return UIImage(named: "Pokemon.jpg")
      case "SWTOR":
      return UIImage(named: "SWTOR.png")
    default:
      return nil
    }
  }
  

//  @IBAction func cancelToDetailsViewController(segue:UIStoryboardSegue) {
//    
//  }
//  @IBAction func saveEditedDetail(segue:UIStoryboardSegue) {
//    if let playerDetailsVC = segue.sourceViewController as? EditDetailViewController {
//      //add new player
//      //players.append(playerDetailsVC.player)
//      player = playerDetailsVC.player
//      //update view
//      //let indexPath = NSIndexPath(forRow: players.count-1, inSection: 0)
//      //tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
//    }
//  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) { //ADDED BY MFS
    if segue.identifier == "EditPlayer" {
      let detailVC = segue.destinationViewController as? EditDetailViewController
      let selectedPlayer = player
      detailVC?.player = selectedPlayer
    }
  }
}
