//
//  TableViewController.swift
//  contadorApp
//
//  Created by Marco Del Angel on 5/17/17.
//  Copyright © 2017 Marco Del Angel. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, NumberViewDelegate {
    
    var numberArray = [Int]()
    var stringArray = [String]()
    var selectedIndex = -1


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        if let newStringArray = UserDefaults.standard.array(forKey: "strings") as? [String] {
            stringArray = newStringArray
        }
        if let newNumberArray = UserDefaults.standard.array(forKey: "numbers") as? [Int] {
            numberArray = newNumberArray
        }
    }

    func didUpDateNumberArray(number:Int){

        numberArray[selectedIndex] = number
        stringArray[selectedIndex] = String(number)
        print("Update NA \(numberArray)")
        print("Update SA \(stringArray)")

        
        self.tableView.reloadData()
        saveNumber()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return stringArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
    
        cell.textLabel?.text = stringArray[indexPath.row]
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "showNumber", sender: self)
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            stringArray.remove(at: indexPath.row)
            numberArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveNumber()
        }
    }
    @IBAction func newNumber(_ sender: Any) {
        
        switch numberArray.isEmpty {
        case true:
            let newNumber = 0
            numberArray.append(newNumber)
            stringArray.append(String(newNumber))
            selectedIndex = 0
        case false:
            numberArray.append(0)
            stringArray.append("0")
            selectedIndex = numberArray.count-1
        }

        saveNumber()
        self.tableView.reloadData()
        performSegue(withIdentifier: "showNumber", sender: nil)
    }
    
    func saveNumber(){
        UserDefaults.standard.set(stringArray, forKey: "strings")
        UserDefaults.standard.set(numberArray, forKey: "numbers")
        UserDefaults.standard.synchronize()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ViewController
        vc.numberDelegate = self
        vc.number = numberArray[selectedIndex]
        print ("Index \(selectedIndex)")
        print("NA \(numberArray)")
        print("SA \(stringArray)")
    }
}
