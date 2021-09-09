//
//  Operations.swift
//  CountOnMe
//
//  Created by TomF on 11/08/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

protocol OperationHandler: class {
    func displayResult(operationText: String)
    func displayAlert(message: String)
}

class Operations {
    
    var operationHandlerDelegate: OperationHandler?
    
    var stringOperations: String = "" {
        didSet {
            operationHandlerDelegate?.displayResult(operationText: stringOperations)
        }
    }
    
    var elements: [String] {
        return stringOperations.split(separator: " ").map { "\($0)" }
    }
    
    // MARK: Error check computed variables
    
    // Check if the expression doesn't end by an operator
    var expressionIsCorrect: Bool {
        lastElementCorrect()
    }
    
    // Check if the counting expression is greater or equal than 3
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    // Check that the expression doesn't have two consecutives operators
    var canAddOperator: Bool {
        lastElementCorrect()
    }
    
    // Check that there is the element equal in the expression
    var expressionHaveResult: Bool {
        return stringOperations.firstIndex(of: "=") != nil
    }
    
    // Check if the expression contains a divison by zero
    var hasDivisionByZero: Bool {
        return stringOperations.contains("/ 0")
    }
    
    // Checks that the last element of the expression is not an operator.
    func lastElementCorrect() -> Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"
    }
    
    // Method that adds the chosen number to the String. If the string already displays a result, it resets to 0 to contain the new element.
    func addNumber(_ number: String) {
        if expressionHaveResult {
            stringOperations = ""
        }
        stringOperations.append(number)
    }
    
    // Method to add an operator to the expression if possible.
    func addOperator(_ operatorToAdd: String) {
        guard canAddOperator else {
            operationHandlerDelegate?.displayAlert(message: "An operator has already been added")
            return
        }
        
        switch operatorToAdd {
        case "+":
            stringOperations.append(" + ")
        case "-":
            stringOperations.append(" - ")
        case "x":
            stringOperations.append(" x ")
        case "/":
            stringOperations.append(" / ")
        default:
            operationHandlerDelegate?.displayAlert(message: "This is not an operator")
        }
    }
    
    // Allows to solve multiplications and divisions in priority in the expression
    func resolvePriorities(expression: [String]) -> [String] {
        var e = expression
        
        while e.contains("x") || e.contains("/") {
            if let index = e.firstIndex(where: {$0 == "x" || $0 == "/" }) {
                guard let left = Double(e[index - 1]) else { return [] }
                let operand = e[index]
                guard let right = Double(e[index + 1]) else { return [] }
                
                let result: Double
                if operand == "x" {
                    result = left * right
                } else {
                    result = left / right
                }
                e[index - 1] = String(result)
                e.remove(at: index + 1)
                e.remove(at: index)
            }
        }
        return e
    }
    
    // Function called when the equal key is touched. It checks that the expression is correct, that it contains enough elements and that a division by 0 is not present
    func equalTapped() {
        guard expressionIsCorrect else {
            operationHandlerDelegate?.displayAlert(message: "Incorrect expression")
            return
        }
        
        guard expressionHaveEnoughElement else {
            operationHandlerDelegate?.displayAlert(message: "Expression hasn't enough elements")
            return
        }
        
        guard !hasDivisionByZero else {
            operationHandlerDelegate?.displayAlert(message: "Division by 0 impossible")
            return
        }
        
        var operationsToReduce = resolvePriorities(expression: elements)
        
        while operationsToReduce.count > 1 {
            guard let left = Double(operationsToReduce[0]) else { return }
            let operand = operationsToReduce[1]
            guard let right = Double(operationsToReduce[2]) else { return }
            
            let result: Double
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            default: fatalError("Unknown operator !")
            }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        
        stringOperations.append(" = \(operationsToReduce.first!)")
    }
    
    // Reset the text view when the AC key is touched
    func allClear() {
        stringOperations = ""
    }
}

