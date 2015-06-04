//
//  Player.swift
//  SwiftRatings
//
//  Created by Matthew Frederick Stradling on 6/1/15.
//  Copyright (c) 2015 Matthew Frederick Stradling. All rights reserved.
//

import Foundation
import UIKit

class Player: NSObject {
  var name: String
  var game: String
  var rating: Int
  init(name: String, game: String, rating: Int) {
    self.game = game
    self.name = name
    self.rating = rating
    super.init()
  }
}