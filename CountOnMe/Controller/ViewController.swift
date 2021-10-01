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
        operations.operationHandlerDelegate = self
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

// - Make the ViewController conform to OperationHandler. Then it's provide to display result or errors with UIAlertController
extension ViewController: OperationHandler {
    func resultHandler(operationText: String) {
        textView.text = operationText
    }
    
    func errorHandler(message: String) {
        let alertViewController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alertViewController, animated: true, completion: nil)
    }
}
