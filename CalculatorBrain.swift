//
//  CalculatorBrain.swift
//  calculator
//
//  Created by Jonathan Davis on 7/12/15.
//  Copyright (c) 2015 Jonathan Davis. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
  var opStack = [Op]()
    
  enum Op {
    case Operand(Double)
    case UnaryOperation(String, Double -> Double)
    case BinaryOperation(String, (Double, Double) -> Double)
  }
  
  var knownOps = [String:Op]()
  
  init() {
    knownOps["×"] = Op.BinaryOperation("×", *)
    knownOps["÷"] = Op.BinaryOperation("÷") { $1 / $0 }
    knownOps["−"] = Op.BinaryOperation("−") { $1 - $0 }
    knownOps["+"] = Op.BinaryOperation("+", +)
    knownOps["√"] = Op.UnaryOperation("√", sqrt)
    knownOps["sin"] = Op.UnaryOperation("sin", sin)
    knownOps["cos"] = Op.UnaryOperation("cos", cos)
  }
  
  func evalate() {
    
  }
  
    
}