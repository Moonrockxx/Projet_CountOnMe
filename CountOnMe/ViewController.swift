//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let operations = Operations()
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet var operatorButtons: [UIButton]!
    
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        operations.addNumber("2")
        operations.addOperator("+")
        operations.addNumber("2")
        operations.addOperator("x")
        operations.addNumber("2")
        operations.equalTapped()
    }
    
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        operations.addNumber(numberText)
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        operations.addOperator("+")
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        operations.addOperator("-")
    }
    
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        operations.addOperator("x")
    }
    
    @IBAction func tappedDivisonButton(_ sender: UIButton) {
        operations.addOperator("/")
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        operations.equalTapped()
    }
    
    @IBAction func allClearButton(_ sender: UIButton) {
        operations.allClear()
    }    

}

