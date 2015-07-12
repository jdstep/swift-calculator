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
    
  enum Op: Printable {
    case Operand(Double)
    case UnaryOperation(String, Double -> Double)
    case BinaryOperation(String, (Double, Double) -> Double)
    
    // handles println logic
    // because if you print a custom type it just shows as 
    // (Enum Value)
    var description: String {
      // while performing a println call on this value
      get {
        switch self {
        // if the value is an operand
        case .Operand(let operand):
          // return the stringified version of the operand
          return "\(operand)"
        // if the value is a unary operation
        case .UnaryOperation(let symbol, _):
          // return only the symbol, which is already a string
          return symbol
        // if the value is a binary operation
        case .BinaryOperation(let symbol, _):
          // return only the symbol, which is already a string
          return symbol
        }
      }
    }
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
  
  // recursively performs the operations on the operands
  func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op]) {
    // if there are still remaining operands
    if !ops.isEmpty {
      // store the remaining operands
      var remainingOps = ops
      // get the top operand off the stack
      let op = remainingOps.removeLast()
      // handle the different types of operands
      switch op {
        // if the operand is a number
      case .Operand(let operand):
        // return the number along with the rest of the stack
        return (operand, remainingOps)
      // if the operand is a unary operation
      case .UnaryOperation(_, let operation):
        // get the number next in the stack
        let operandEvaluation = evaluate(remainingOps)
        // if the number value was present
        if let operand = operandEvaluation.result {
          // return the result of performing the operation on that number
          return (operation(operand), operandEvaluation.remainingOps)
        }
      // if the operand is a binary operation
      case .BinaryOperation(_, let operation):
        // get the next number in the stack
        let operandEvalulation1 = evaluate(remainingOps)
        // if that next number exists
        if let operand1 = operandEvalulation1.result {
          // get the following number in the stack using the remainder
          // after getting the previous number
          let operandEvaluation2 = evaluate(operandEvalulation1.remainingOps)
          // if there is a second number
          if let operand2 = operandEvaluation2.result {
            // perform the operation on the two numbers
            return (operation(operand1, operand2), operandEvaluation2.remainingOps)
          }
          
        }
      }
    }
    // if any step failed, return nil
    return (nil, ops)
  }

  func evaluateAll() -> Double? {
    let (result, remainder) = evaluate(opStack)
    println("\(result) is the result with \(remainder) left over")
    return result
  }
  
  func pushOperand(operand: Double) -> Double? {
    opStack.append(Op.Operand(operand))
    return evaluateAll()
  }
  
  func performOperation(symbol: String) -> Double? {
    if let operation = knownOps[symbol] {
      opStack.append(operation)
    }
    return evaluateAll()
  }
    
}