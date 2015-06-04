//
//  RankPickerViewController.swift
//  SwiftRatings
//
//  Created by Matthew Frederick Stradling on 6/4/15.
//  Copyright (c) 2015 Matthew Frederick Stradling. All rights reserved.
//
 //ADDED BY MFS //ADDED BY MFS //ADDED BY MFS
import UIKit

class RankPickerViewController: UITableViewController {
  var ranks: [String]!
  var selectedRank:String? = nil
  var selectedRankIndex:Int? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    ranks = ["1 Star",
             "2 Stars",
             "3 Stars",
             "4 Stars",
             "5 Stars"]
    
    if let rank = selectedRank {
      selectedRankIndex = find(ranks, rank)!
    }
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return ranks.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("RankCell", forIndexPath: indexPath) as! UITableViewCell
    cell.textLabel?.text = ranks[indexPath.row]
    
    if indexPath.row == selectedRankIndex {
      cell.accessoryType = .Checkmark
      cell.textLabel?.backgroundColor = UIColor(red: 0.1, green: 0.6, blue: 0.7, alpha: 1.0)
    } else {
      cell.accessoryType = .None
    }
    return cell
  }

  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    
    //Other row is selected - need to deselect it
    if let index = selectedRankIndex {
      let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0))
      cell?.accessoryType = .None
      //cell?.textLabel?.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
      cell!.textLabel?.backgroundColor = UIColor(red: 0.1, green: 0.6, blue: 0.7, alpha: 1.0)
    }
    
    selectedRankIndex = indexPath.row
    selectedRank = ranks[indexPath.row]
    
    //update checkmark for current row
    let cell = tableView.cellForRowAtIndexPath(indexPath)
    cell!.accessoryType = .Checkmark
    cell!.textLabel?.backgroundColor = UIColor(red: 0.1, green: 0.6, blue: 0.7, alpha: 1.0)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "SaveSelectedRank" {
      if let cell = sender as? UITableViewCell {
        let indexPath = tableView.indexPathForCell(cell)
        selectedRankIndex = indexPath?.row
        if let index = selectedRankIndex {
          selectedRank = ranks[index]
        }
      }
    }
  }
}
