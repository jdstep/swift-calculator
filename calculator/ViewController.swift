//
//  ViewController.swift
//  calculator
//
//  Created by Jonathan Davis on 7/10/15.
//  Copyright (c) 2015 Jonathan Davis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


  @IBOutlet weak var numDisplay: UILabel!
  
  
  var userIsTyping: Bool = false


  @IBAction func operatorButton(sender: UIButton) {
    let operation = sender.currentTitle!
    
    switch operation {
      
    case "×": println("in switch with ×")
      
    default : println("nothing happened in switch")
      
    }
  
  }
  
  func resetDisplayNum() {
    numDisplay.text! = "0"
  }
  
  
    
 
  var numStack = Array<Double>()
  
  // converts the display between double and string
  var currentDisplayNum: Double {
    get {
      return NSNumberFormatter().numberFromString(numDisplay.text!)!.doubleValue
    }
    set {
      numDisplay.text! = "\(newValue)"
    }
  }

  
  @IBAction func enter() {
    numStack.append(currentDisplayNum)
    userIsTyping = false
    println(numStack)
  }
  
  
  
  
    
    
    
  @IBAction func appendDigit(sender: UIButton) {
    let digit = sender.currentTitle!
    if (userIsTyping) {
      numDisplay.text = numDisplay.text! + digit
    } else {
      numDisplay.text = digit
      userIsTyping = true
    }
      
      
  }
}

