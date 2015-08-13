//
//  ViewController.swift
//  TipCalculator
//
//  Created by Matthew Frederick Stradling on 7/16/15.
//  Copyright (c) 2015 Matthew Frederick Stradling. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var totalTextField: UITextField!
  @IBOutlet weak var taxPctSlider: UISlider!
  @IBOutlet weak var results: UITextView!
  @IBOutlet weak var calculateButton: UIButton!
  @IBOutlet weak var tacPctLabel: UILabel!
  
  let linkBlueColor = UIColor(red: 0/255.0, green: 81/255.0, blue: 196/255.0, alpha: 1)
  let tipCalc = TipCalculatorModel(total: 33.25, taxPct: 0.06)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    calculateButton.layer.borderWidth = 1.0
    calculateButton.layer.cornerRadius = 4.0
    calculateButton.layer.borderColor = linkBlueColor.CGColor
    calculateButton.setTitleColor(linkBlueColor, forState: UIControlState.Normal)
    calculateButton.titleLabel!.font = UIFont(name: "ProximaNova-Regular", size: 16.0)
    calculateButton.backgroundColor = UIColor.whiteColor()
    refreshUI()
  }
  
  func refreshUI() {
    //1
    totalTextField.text = String(format: "%0.2f", tipCalc.total)
    //2
    taxPctSlider.value = Float(tipCalc.taxPct) * 100.0
    //3
    tacPctLabel.text = "Tax Percentage (\(Int(taxPctSlider.value))%)"
    //4
    results.text = ""
  }

  @IBAction func calculateTapped(sender: AnyObject) {
    //1
    tipCalc.total = Double((totalTextField.text as NSString).doubleValue)
    //2
    let possibleTips = tipCalc.returnPossibleTips()
    var result = ""
    //3
    for (tipPct, tipValue) in possibleTips {
      result += "\(tipPct)%: \(tipValue)\n"
    }
    //4
    results.text = result
  }
  
  @IBAction func taxPercentageChanged(sender: AnyObject) {
    tipCalc.taxPct = Double(taxPctSlider.value) / 100.0
    refreshUI()
  }

  @IBAction func viewTrapped(sender: AnyObject) {
    totalTextField.resignFirstResponder()
  }
}

