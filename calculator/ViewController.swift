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

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if (userIsTyping) {
            println(digit)
            numDisplay.text = numDisplay.text! + digit
            
        } else {
            numDisplay.text = digit
            userIsTyping = true
        }
        
            
    }
}

