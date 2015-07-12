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
  
  var brain = CalculatorBrain()


  @IBAction func operatorButton(sender: UIButton) {
    let operation = sender.currentTitle!
    
    if (userIsTyping) {
      enter()
    }
    
    if let operation = sender.currentTitle {
      println("calling operation in view")
      if let result = brain.performOperation(operation) {
        currentDisplayNum = result
      } else {
        // need error handling here
        currentDisplayNum = 0
      }
    }
    
  
  }
  
  @IBAction func clearAll() {
    brain.clearAll()
    currentDisplayNum = 0
  }
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
    if let result = brain.pushOperand(currentDisplayNum) {
      currentDisplayNum = result
    } else {
      // should handle an error here
      currentDisplayNum = 0
    }
    userIsTyping = false
    enteredDot = false
  }
  
  
  // keeps track if the current number is a decimal
  var enteredDot = false;
    
    
    
 
  
  @IBAction func addConstant(sender: UIButton) {
    let mathConstant = sender.currentTitle!
    
    
    numDisplay.text = mathConstant
    
    switch mathConstant {
    case "π": numDisplay.text! = "3.14159"
    default: "ERROR: math constant is not present"
    }
    
    
  }
  
 
}

