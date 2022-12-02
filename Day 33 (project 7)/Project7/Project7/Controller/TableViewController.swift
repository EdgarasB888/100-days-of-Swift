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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        let urlString: String
        
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
        
        if let url = URL(string: urlString)
        {
            if let data = try? Data(contentsOf: url)
            {
                parse(json: data)
                
                return
            }
        }
        showError()
    }
    
    func showError()
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
            tableView.reloadData()
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
    
    @IBAction func viewCredits(_ sender: Any)
    {
        let ac = UIAlertController(title: "Credits", message: "We The People API of the Whitehouse", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Dismiss", style: .default))
        present(ac, animated: true)
    }
    
    
    @IBAction func filterPetitions(_ sender: Any)
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
            let textField = ac.textFields?.first
            
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .default, handler: nil)
    }
    
}

