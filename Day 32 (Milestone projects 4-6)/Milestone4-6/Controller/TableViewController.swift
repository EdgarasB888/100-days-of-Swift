//
//  ViewController.swift
//  Milestone4-6
//
//  Created by Edgaras Blauzdys on 2022-12-01.
//

import UIKit

class TableViewController: UITableViewController
{
    var shoppingList = [String]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        title = "Shopping items"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingTableViewCell", for: indexPath)
        
        cell.textLabel?.text = shoppingList[indexPath.row]
        
        return cell
    }
    
    @IBAction func deleteAllShoppingItems(_ sender: Any)
    {
        let ac = UIAlertController(title: "Warning!", message: "Do you really want to remove all items from your shopping list?", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Remove", style: .destructive, handler:
        {
            _ in
            self.shoppingList = []
            self.tableView.reloadData()
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(ac, animated: true)
    }
    
    @IBAction func addShoppingItem(_ sender: Any)
    {
        let ac = UIAlertController(title: "Add new item", message: nil, preferredStyle: .alert)
        ac.addTextField
        {
            textField in
            textField.placeholder = "Enter the name of your item"
            textField.autocorrectionType = .no
            textField.autocapitalizationType = .sentences
        }
        
        let submitAction = UIAlertAction(title: "Add", style: .default)
        {
            [weak self, weak ac] _ in
            guard let shoppingItem = ac?.textFields?[0].text else { return }
            self?.shoppingList.append(shoppingItem)
            
            self?.tableView.reloadData()
        }
                
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    
}

