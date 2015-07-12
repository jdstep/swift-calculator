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
      
    case "×": performOperation() { $1 * $0 }
    case "÷": performOperation() { $1 / $0 }
    case "−": performOperation() { $1 - $0 }
    case "+": performOperation() { $1 + $0 }
    case "√": performOperationOneArg() { sqrt($0) }
    case "sin": performOperationOneArg() { sin($0) }
    case "cos": performOperationOneArg() { cos($0) }

  
    default : println("ERROR: no cases matched operation switch")
      
    }
  
  }
  
  // handle generic math functions with two arguments
  func performOperation(operationFunc: (Double, Double) -> Double) {
    if (numStack.count >= 2) {
      currentDisplayNum = operationFunc(numStack.removeLast(), numStack.removeLast())
      enter()
    }
  }
  
  // handle generic math functions with one argument
  func performOperationOneArg(operationFunc: (Double) -> Double) {
    if (numStack.count >= 1) {
      currentDisplayNum = operationFunc(numStack.removeLast())
      enter()
    }
  }
  
 
  var numStack = Array<Double>()
  
  // converts the display between double and string
  var currentDisplayNum: Double {
    get {
      return NSNumberFormatter().numberFromString(numDisplay.text!)!.doubleValue
    }
    set {
      println("trying to set new value to \(newValue)")
      numDisplay.text! = "\(newValue)"
    }
  }

  
  @IBAction func enter() {
    numStack.append(currentDisplayNum)
    userIsTyping = false
    enteredDot = false
  }
  
  
  // keeps track if the current number is a decimal
  var enteredDot = false;
    
    
    
  @IBAction func appendDigit(sender: UIButton) {
    let digit = sender.currentTitle!
    
    // if the user tapped the decimal button
    if (digit == ".") {
      // if a decimal was already entered in the number
      if (enteredDot) {
        // eject from the function
        return
      } else {
        // remember that we entered a decimal, and proceed with the rest of the function
        enteredDot = true
      }
    }
    if (userIsTyping) {
      numDisplay.text = numDisplay.text! + digit
    } else {
      numDisplay.text = digit
      userIsTyping = true
    }
      
      
  }
}

