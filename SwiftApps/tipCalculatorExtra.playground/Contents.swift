//: Playground - noun: a place where people can play

import UIKit
import Foundation

//A protocol is a list of methods that specify a “contract” or “interface”.

@objc protocol Speaker {
  func Speak()
  optional func TellSecretIdentiy()
}


class Shock: Speaker {
  let base = "Lightning"
  let first = "Sun-Light"
  let secnd = "Moon-Light"
  @objc func Speak() {
    println("I am Shock, the Herodian!")
  }
  @objc func TellSecretIdentiy() {
    println("I am Kairen Greil. The Son of Thunder!")
  }
  func listElements() {
    println("Elements: \(base), \(first), and \(secnd)")
  }
}

class Ripper: Speaker {
  @objc func Speak() {
    println("I am the dreadful Ripper!")
  }
  @objc func TellSecretIdentiy() {
    println("I am Zayn Ripper. One of the last Shadow-Elementalists")
  }
}


class Formshifter {
  
}
class Phoenix: Formshifter, Speaker {
  @objc func Speak() {
    println("Kakaaa! Oh wait. Did you see me?")
  }
  @objc func TellSecretIdentiy() {
    println("I am Reed Stradling")
  }
}
//In this example, Phoenix inherits from Formshifter, so when declaring Phoenix you put a :, then the class it inherits from, then list any protocols. You can only inherit from 1 class in Swift, but you can conform to any number of protocols.

var speaker:Speaker
speaker = Shock()
speaker.Speak()
(speaker as! Shock).listElements()
speaker = Ripper()
speaker.Speak()

speaker.TellSecretIdentiy?()
speaker = Phoenix()
speaker.TellSecretIdentiy?()

//var shock:Shock
//shock = Shock()
//shock.Speak()
//shock.TellSecretIdentiy()
//shock.listElements()
//var phoenix = Phoenix()
//phoenix.TellSecretIdentiy()







