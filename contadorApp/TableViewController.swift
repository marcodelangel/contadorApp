//
//  TableViewController.swift
//  contadorApp
//
//  Created by Marco Del Angel on 5/17/17.
//  Copyright © 2017 Marco Del Angel. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var numbers = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        numbers = UserDefaults.standard.loadNumbers()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return numbers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        cell.textLabel?.text = "\(numbers[indexPath.row])"
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showNumber", sender: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        guard editingStyle == .delete else { return }
        
        numbers.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        saveChanges()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ViewController
        vc.numberDelegate = self
        
        if let indexPath = sender, let indexPathForValue = indexPath as? IndexPath {
            vc.number = (value: numbers[indexPathForValue.row], indexPath: indexPathForValue)
        } else {
            vc.number = (value: 0, indexPath: nil)
        }
    }
    
    fileprivate func saveChanges(){
        UserDefaults.standard.saveNumbers(numbers)
        self.tableView.reloadData()
    }
}

extension TableViewController {
    @IBAction func newNumber(_ sender: Any) {
        performSegue(withIdentifier: "showNumber", sender: nil)
    }
}

extension TableViewController : NumberViewDelegate {
    
    func update(number: Int, atIndexPath: IndexPath) {
        numbers[atIndexPath.row] = number
        saveChanges()
    }
    
    func save(number: Int) {
        numbers.append(number)
        saveChanges()
    }
}
