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
  
  func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op]) {
    if !ops.isEmpty {
      var remainingOps = ops
      let op = remainingOps.removeLast()
      switch op {
      case .Operand(let operand): return (operand, remainingOps)
      case .UnaryOperation(_, let operation):
        let operandEvaluation = evaluate(remainingOps)
        if let operand = operandEvaluation.result {
          return (operation(operand), operandEvaluation.remainingOps)
        }
      case .BinaryOperation(_, let operation):
        let operandEvalulation1 = evaluate(remainingOps)
        if let operand1 = operandEvalulation1.result {
          let operandEvaluation2 = evaluate(operandEvalulation1.remainingOps)
          if let operand2 = operandEvaluation2.result {
            return (operation(operand1, operand2), operandEvaluation2.remainingOps)
          }
          
        }
      }
    }
    return (nil, ops)
  }
  
    
}