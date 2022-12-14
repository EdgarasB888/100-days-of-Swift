//
//  ViewController.swift
//  Project7
//
//  Created by Edgaras Blauzdys on 2022-12-02.
//

import UIKit

class TableViewController: UITableViewController
{
    var petitions = [Petition]()
    var filteredPetitions = [Petition]()
    var petitionsToRestore = [Petition]()
    
    var urlString: String = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        navigationItem.leftBarButtonItem?.tintColor = UIColor.black
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .plain, target: self, action: #selector(viewCredits))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease.circle"), style: .plain, target: self, action: #selector(filterPetitions))
        
        if navigationController?.tabBarItem.tag ==  0
        {
            urlString = "https://hackingwithswift.com/samples/petitions-1.json"
            title = "Most Recent"
        }
        else
        {
            //urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
            urlString = "https://hackingwithswift.com/samples/petitions-2.json"
            title = "Top Rated"
        }
        
        //all JSON now runs in a background thread
        performSelector(inBackground: #selector(fetchJSON), with: nil)
    }
    
    @objc func fetchJSON()
    {
        if let url = URL(string: urlString)
        {
            if let data = try? Data(contentsOf: url)
            {
                parse(json: data)
                    
                return
            }
        }
        //this runs show error on the main thread. Instead, we can use DispatchQueue.main.async in our showError() function
        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        //showError()
    }
    
    @objc func showError()
    {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func parse(json: Data)
    {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json)
        {
            petitions = jsonPetitions.results
            
            //gives an error for some reason
            //tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
            DispatchQueue.main.async
            {
                [weak self] in
                self?.tableView.reloadData()
            }
        }
        else
        {
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let petition = petitions[indexPath.row]
        
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //We have no DetailViewController in storyboard, it's just a free floating class
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func viewCredits(_ sender: Any)
    {
        let ac = UIAlertController(title: "Credits", message: "We The People API of the Whitehouse", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Dismiss", style: .default))
        present(ac, animated: true)
    }
    
    
    @objc func filterPetitions(_ sender: Any)
    {
        let ac = UIAlertController(title: "Filter petitions", message: nil, preferredStyle: .alert)
        ac.addTextField
        {
            textField in
            textField.placeholder = "Enter the name of required petition"
            textField.autocorrectionType = .no
            textField.autocapitalizationType = .sentences
        }
        
        let addActionButton = UIAlertAction(title: "Filter", style: .default)
        {
            action in
            guard let textFieldText = ac.textFields?.first?.text else { return }
            
            DispatchQueue.global(qos: .background).async
            {
                self.filteredPetitions.removeAll()
                
                for petition in self.petitions
                {
                    if petition.title.lowercased().contains(textFieldText.lowercased()) || petition.body.lowercased().contains(textFieldText.lowercased())
                    {
                        self.filteredPetitions.append(petition)
                    }
                }
                
                self.petitionsToRestore = self.petitions
                self.petitions = self.filteredPetitions
            }
                
            DispatchQueue.main.async
            {
                self.tableView.reloadData()
            }
        }
        let cancelButton = UIAlertAction(title: "Restore", style: .cancel)
        {
            action in
            self.restorePetitions()
        }
        
        ac.addAction(addActionButton)
        ac.addAction(cancelButton)
        
        present(ac, animated: true)
    }
    
    func restorePetitions()
    {
        petitions = petitionsToRestore
        tableView.reloadData()
    }
}

