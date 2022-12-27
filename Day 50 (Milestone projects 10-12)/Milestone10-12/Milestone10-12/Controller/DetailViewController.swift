//
//  DetailViewController.swift
//  Milestone10-12
//
//  Created by Edgaras Blauzdys on 2022-12-27.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var photoImageView: UIImageView!
    
    var selectedImage: Photo?
    var path: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = selectedImage?.title
        photoImageView.image = UIImage(contentsOfFile: path.path)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = false
    }

}
