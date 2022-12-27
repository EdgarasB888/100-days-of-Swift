//
//  DetailViewController.swift
//  Project1
//
//  Created by Edgaras Blauzdys on 2022-11-24.
//

import UIKit

class DetailViewController: UIViewController
{
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var selectedPictureIndex = 0
    var allPicturesCount = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        title = "Picture \(selectedPictureIndex+1) of \(allPicturesCount)"
        navigationItem.largeTitleDisplayMode = .never

        if let imageToLoad = selectedImage
        {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
