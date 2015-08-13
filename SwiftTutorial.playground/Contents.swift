//: Playground - noun: a place where people can play
import UIKit
import Foundation

class TipCalculatorModel {
  var total: Double
  var taxPct: Double
  var subTotal: Double {
    get {
      return total / (taxPct + 1)
    }
  }
  
  init(total: Double, taxPct: Double) {
    self.total = total
    self.taxPct = taxPct
  }
  
  func calcTipWithTipPct(tipPct: Double) -> (tipAmt:Double, total:Double) {//MODIFY
    let tipAmt = subTotal * tipPct
    let finalTotal = total + tipAmt
    return (tipAmt, finalTotal)
  }
  
  func returnPossibleTips() -> [Int: (tipAmt:Double, total:Double)] {//MODIFY
    let possibleTipsInferred = [0.15, 0.18, 0.20]
    
    var retval = Dictionary<Int, (tipAmt:Double, total:Double)>()
    for possibleTip in possibleTipsInferred {
      let intPct = Int(possibleTip*100)
      retval[intPct] = calcTipWithTipPct(possibleTip)
    }
    return retval
  }
}

