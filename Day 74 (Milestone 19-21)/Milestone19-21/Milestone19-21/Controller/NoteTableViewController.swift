//
//  ViewController.swift
//  Milestone19-21
//
//  Created by Edgaras Blauzdys on 2023-01-31.
//

import UIKit

class NoteTableViewController: UITableViewController {

    @IBOutlet var notesCountItem: UIBarButtonItem!
    
    var notes: [Note]?
    var titleVC: String = ""
    
    var notesCount = 0 {
        didSet {
            notesCountItem.title = "\(notes?.count ?? 0) Notes"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = titleVC
    
        notes?.append(Note(name: "Something", text: "Right Said Fred"))
        notes?.append(Note(name: "Anything", text: "BICYCLE, BICYCLE!"))
        notes?.append(Note(name: "Nothing", text: "We are the Freds, we are, we are, we are..."))
        
        notesCount = notes?.count ?? 0
        if notesCount == 1 {
            notesCountItem.title = "\(notesCount) Note"
        } else {
            notesCountItem.title = "\(notesCount) Notes"
        }
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        editButtonItem.tintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        notesCount -= 1
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            notes?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            //FolderManagement.saveFolders(<#T##folders: [Folder]##[Folder]#>)
            notesCount -= 1
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteTableViewCell", for: indexPath)
        
        let note = notes?[indexPath.row]
        cell.textLabel?.text = note?.name
        
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {            
            guard let detailVC = segue.destination as? DetailViewController else { return }
            
            detailVC.note = (notes?[indexPath.row])!
        }
    }
    
    @IBAction func unwind(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveSeque" else { return }
        guard let noteVC = segue.source as? DetailViewController else { return }
        let note = noteVC.note
        print(note.name ?? "")
        
        if let path = tableView.indexPathForSelectedRow {
            notes?[path.row] = note
            tableView.deselectRow(at: path, animated: false)
        } else {
            notes?.append(note)
           
        }
        tableView.reloadData()
    }
}

