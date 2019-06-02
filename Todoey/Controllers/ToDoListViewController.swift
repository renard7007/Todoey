//
//  ViewController.swift
//  Todoey
//
//  Created by Anton Krumkov on 18.05.19.
//  Copyright © 2019 Anton Krumkov. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let newItem = Item()
        newItem.title = "to"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "do"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "list"
        itemArray.append(newItem3)
        
        
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
        itemArray = items

        }

        
    }

    // TABLEVIEW DATASOURCE METHOD
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        
        
        
        cell.textLabel?.text = item.title
        
        // TERNARY OPERATOR
        cell.accessoryType = item.done ? .checkmark : .none
        
        
        return cell
    }
    
    // TABLEVIEW DELEGATE METHODS
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        // SETS THE DONE PROPERTY TO THE OPPOSITE [IF ITS TRUE IS FALSE ... ]
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    //ADD NEW ITEMS BUTTON
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //WHAT WILL HAPPEN WHEN USER CLICK THE ADD ITEM BUTTON ON OUR UIAlert
           
            let newItem = Item()
            newItem.title = textField.text!
            
            
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        
         alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
    
    
}







