//
//  ViewController.swift
//  contadorApp
//
//  Created by Marco Del Angel on 5/17/17.
//  Copyright © 2017 Marco Del Angel. All rights reserved.
//

import UIKit

protocol NumberViewDelegate {
    func save(number: Int)
    func update(number: Int, atIndexPath: IndexPath)
}

class ViewController: UIViewController {
    
    var number: (value: Int, indexPath: IndexPath?) = (value: 0, indexPath: nil)
    
    var numberDelegate : NumberViewDelegate!

    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.delegate = self
            textField.text = "\(number.value)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
    fileprivate func add(otherNumber: Int) {
        number.value = number.value + otherNumber
        textField.text = "\(number.value)"
    }
}

extension ViewController {
    @IBAction func add() {
        add(otherNumber: 1)
    }
    
    @IBAction func decrease() {
        add(otherNumber: -1)
    }
    
    @IBAction func reset() {
        add(otherNumber: -1 * number.value)
    }
    
    @IBAction func saveNumber() {
        textField.resignFirstResponder()
        
        if let indexPath = number.indexPath {
            numberDelegate.update(number: number.value, atIndexPath: indexPath)
        } else {
            numberDelegate.save(number: number.value)
        }
    }
}

extension ViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let text = textField.text,
            CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: text)) else {
                textField.text = "Anota un número"
                return
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        
        guard let text = textField.text, let integerOnlyText = Int(text) else {
            return
        }
        
        number.value = integerOnlyText
    }
}


