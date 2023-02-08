//
//  FolderTableViewController.swift
//  Milestone19-21
//
//  Created by Edgaras Blauzdys on 2023-01-31.
//

import UIKit

class FolderTableViewController: UITableViewController {

    var folders = [Folder]()
    var folder: Folder!
    var index = 0
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Folders"
        
        if defaults.object(forKey: "savedFolders") != nil {
            folders = FolderManagement.loadFolders()
        } else {
            folders = createPlaceholderFolders()
        }
        
        navigationController?.isToolbarHidden = false
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        editButtonItem.tintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            folders.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            FolderManagement.saveFolders(folders)
        }
    }
    
    @IBAction func addFolderTapped(_ sender: Any) {
        let ac = UIAlertController(title: "Create New Folder", message: "Please enter a name of the new folder", preferredStyle: .alert)
            
        let create = UIAlertAction(title: "Create", style: .default) { _ in
            guard let folderName = ac.textFields?[0].text else { return }
            if folderName.count > 0 {
                let folder = Folder(name: folderName, notes: [Note(name: "", text: "")])
                self.folders.append(folder)
                FolderManagement.saveFolders(self.folders)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                print("Wrong name!")
                return
            }
        }
        
        ac.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Name"
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        ac.addAction(create)
        ac.addAction(cancel)
        ac.view.tintColor = #colorLiteral(red: 0.971363008, green: 0.577881217, blue: 0.006590880454, alpha: 1)
        
        present(ac, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folders.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FolderTableViewCell", for: indexPath)
        
        let folder = folders[indexPath.row]
        cell.textLabel?.text = folder.name
        

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {            
            guard let notesVC = segue.destination as? NoteTableViewController else { return }
            
            notesVC.notes = folders[indexPath.row].notes
            notesVC.titleVC = folders[indexPath.row].name
        }
    }
    
    func createPlaceholderFolders() -> [Folder] {
        var foldersArray = [Folder]()
        
        let folderOne = Folder(name: "All iCloud", notes: [Note(name: "One", text: ""), Note(name: "Two", text: ""), Note(name: "Three", text: "")])
        let folderTwo = Folder(name: "Notes", notes: [Note(name: "One", text: ""), Note(name: "Two", text: ""), Note(name: "Three", text: "")])
        let folderThree = Folder(name: "Quick Notes", notes: [Note(name: "One", text: ""), Note(name: "Two", text: ""), Note(name: "Three", text: "")])
        
        foldersArray.append(folderOne)
        foldersArray.append(folderTwo)
        foldersArray.append(folderThree)
        
        return foldersArray
    }
}
