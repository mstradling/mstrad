//
//  GamePickerViewController.swift
//  SwiftRatings
//
//  Created by Matthew Frederick Stradling on 6/4/15.
//  Copyright (c) 2015 Matthew Frederick Stradling. All rights reserved.
//

import UIKit

class GamePickerViewController: UITableViewController {
  var games:[String]!
  var selectedGame:String? = nil
  var selectedGameIndex:Int? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    games = ["Angry Birds",
      "Chess",
      "Texas Hold'em Poker",
      "Tic-Tac-Toe",
      "Super Smash Bros",
      "Fire Emblem",
      "Soul Calibur",
      "Pokemon",
      "SWTOR"]
    if let game = selectedGame {
      selectedGameIndex = find(games, game)!
    }
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return games.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("GameCell", forIndexPath: indexPath) as! UITableViewCell
    cell.textLabel?.text = games[indexPath.row]
    
    if indexPath.row == selectedGameIndex {
      cell.accessoryType = .Checkmark
      cell.textLabel?.backgroundColor = UIColor(red: 0.1, green: 0.6, blue: 0.7, alpha: 1.0) //ADDED BY MFS
    } else {
      cell.accessoryType = .None
    }
    return cell
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    
    //Other row is selected - need to deselect it
    if let index = selectedGameIndex {
      let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0))
      cell?.accessoryType = .None
      cell!.textLabel?.backgroundColor = UIColor(red: 0.1, green: 0.6, blue: 0.7, alpha: 1.0)
    }
    
    selectedGameIndex = indexPath.row
    selectedGame = games[indexPath.row]
    
    //update checkmark for current row
    let cell = tableView.cellForRowAtIndexPath(indexPath)
    cell?.accessoryType = .Checkmark
    cell!.textLabel?.backgroundColor = UIColor(red: 0.1, green: 0.6, blue: 0.7, alpha: 1.0)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "SaveSelectedGame" {
      if let cell = sender as? UITableViewCell {
        let indexPath = tableView.indexPathForCell(cell)
        selectedGameIndex = indexPath?.row
        if let index = selectedGameIndex {
          selectedGame = games[index]
        }
      }
    }
  }
}
