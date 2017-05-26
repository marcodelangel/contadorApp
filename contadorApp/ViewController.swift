//
//  ViewController.swift
//  contadorApp
//
//  Created by Marco Del Angel on 5/17/17.
//  Copyright © 2017 Marco Del Angel. All rights reserved.
//

import UIKit

protocol NumberViewDelegate {
    func didUpDateNumberArray(number:Int)
}

class ViewController: UIViewController, UITextFieldDelegate {
    
    var numberDelegate : NumberViewDelegate?

    @IBOutlet weak var textField: UITextField!
    var number : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textField.delegate = self
        textField.text = String(number)
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))

    }
    
    /*override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        if numberDelegate != nil{
            numberDelegate?.didUpDateNumberArray(number: number)
        }
    }*/
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        textField.text = ""
        
        guard CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: textField.text!)) else {
            
            textField.text = "Anota un número"
            
            return
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        if textField.text != "" {
            number = Int(textField.text!)!
        }
    }
    
    @IBAction func add(_ sender: Any) {
    number = number + 1
    textField.text = "\(number)"
    print(number)
    }
    
    @IBAction func decrease(_ sender: Any) {
    number = number - 1
    textField.text = "\(number)"
    print(number)
    }
   
    @IBAction func reset(_ sender: Any) {
    number = 0
    textField.text = ""
    print(number)
    }
    
    @IBAction func saveNumber(_ sender: Any) {
        
        textField.resignFirstResponder()
    
        if numberDelegate != nil{
            numberDelegate?.didUpDateNumberArray(number: number)
        }
    }
}

