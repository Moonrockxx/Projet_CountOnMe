//
//  Operations.swift
//  CountOnMe
//
//  Created by TomF on 11/08/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

enum OperationsError {
    case expressionIsIncorrect
    case expressionHaventEnoughElement
    case cantAddOperator
}

class Operations {
    
    var stringOperations: String = ""
    
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
    
    // Vérifie qu'il y a bien l'element égal dans l'expression
    var expressionHaveResult: Bool {
        return stringOperations.firstIndex(of: "=") != nil
    }
    
    // Vérifie que le dernier élément de l'expression n'est pas un opérateur.
    // var expressionIsCorrect et var canAddOperator appellent cette fonction
    func lastElementCorrect() -> Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"
    }
    
    // Méthode qui permet d'ajouter le nombre choisit à la String. Si la string affiche déjà un résultat, celle ci se remet à 0 pour pouvoir contenir le nouvel élément tappé.
    func addNumber(_ number: String) {
        if expressionHaveResult {
            stringOperations = ""
        }
        
        stringOperations.append(number)
    }
    
    // Méthode qui permet d'ajouter un opérateur à l'expression si cela est possible.
    // TODO: Gérer les erreurs
    func addOperator(_ operatorToAdd: String) {
        if canAddOperator {
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
                break
                // Renvoyer une erreur : Pas le bon opérateur
            }
        } else {
            // Renvoyer une erreur : Opérateur déjà présent
        }
    }
    
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
                e.remove(at: index)
                e.remove(at: index)
//                e.removeSubrange(<#T##bounds: Range<Int>##Range<Int>#>)
            }
        }
        return e
    }
    
    func equalTapped() {
        guard expressionIsCorrect else {
            return
        }
        
        guard expressionHaveEnoughElement else {
//            let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
//            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//            return self.present(alertVC, animated: true, completion: nil)
            return
        }
        
        // Create local copy of operations
        var operationsToReduce = resolvePriorities(expression: elements)
        print(operationsToReduce)
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Int(operationsToReduce[0]) ?? 0
            let operand = operationsToReduce[1]
            let right = Int(operationsToReduce[2]) ?? 0
            
            let result: Int
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
    
    func allClear() {
        stringOperations = ""
    }
    
}


//@IBAction func tappedAdditionButton(_ sender: UIButton) {
//    if canAddOperator {
//        textView.text.append(" + ")
//    } else {
//        let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
//        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//        self.present(alertVC, animated: true, completion: nil)
//    }
//}
//
//@IBAction func tappedSubstractionButton(_ sender: UIButton) {
//    if canAddOperator {
//        textView.text.append(" - ")
//    } else {
//        let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
//        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//        self.present(alertVC, animated: true, completion: nil)
//    }
//}
