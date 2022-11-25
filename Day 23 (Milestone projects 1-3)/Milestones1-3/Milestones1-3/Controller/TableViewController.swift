//
//  ViewController.swift
//  Milestones1-3
//
//  Created by Edgaras Blauzdys on 2022-11-25.
//

import UIKit

class TableViewController: UITableViewController
{
    var flags = [String]()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items
        {
            if item.contains("3x.png")
            {
                flags.append(item)
            }
        }
        
        print(flags)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FlagTableViewCell", for: indexPath)
        
        cell.textLabel?.text = flags[indexPath.row].uppercased().replacingOccurrences(of: "@3X.PNG", with: "")
        
        cell.imageView?.image = UIImage(named: flags[indexPath.row])
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {return}
        
        vc.selectedFlag = flags[indexPath.row]
        
        show(vc, sender: self)
        /*
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController
        {
            navigationController?.pushViewController(vc, animated: true)
            vc.selectedFlag = flags[indexPath.row]
            print("Here")
        }
         */
         
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return flags.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 120
    }
}

