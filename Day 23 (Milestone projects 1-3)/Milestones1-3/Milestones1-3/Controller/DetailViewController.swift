//
//  DetailViewController.swift
//  Milestones1-3
//
//  Created by Edgaras Blauzdys on 2022-11-25.
//

import UIKit

class DetailViewController: UIViewController
{
    var selectedFlag: String = ""
    
    @IBOutlet var flagImageView: UIImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        flagImageView.image = UIImage(named: selectedFlag)
    }
    
    @objc func shareTapped()
    {
        guard let image = flagImageView.image?.jpegData(compressionQuality: 0.8) else
        {
            print("No image found")
                    
            return
        }
        
        let nameOfFlag = selectedFlag.uppercased().replacingOccurrences(of: "@3X.PNG", with: "")
        
        let vc = UIActivityViewController(activityItems: [image, nameOfFlag], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
                
        present(vc, animated: true)
    }
}
