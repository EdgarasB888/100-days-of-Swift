//
//  ViewController.swift
//  Milestone10-12
//
//  Created by Edgaras Blauzdys on 2022-12-27.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Photos"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPhoto))
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell", for: indexPath) as? PhotoTableViewCell else {return UITableViewCell()}
        
        let photo = photos[indexPath.row]
        
        cell.titleLabel.text = photo.title
        
        let path = getDocumentsDirectory().appendingPathComponent(photo.image)
        cell.photoImageView.image = UIImage(contentsOfFile: path.path)
                
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)

        let photo = photos[indexPath.row]
        
        showRenameAlert(photo: photo)
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        print(#function)
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            vc.selectedImage = photos[indexPath.row]
            vc.path = getDocumentsDirectory().appendingPathComponent(photos[indexPath.row].image)
            navigationController?.pushViewController(vc, animated: true)
            vc.title = "Photo"
        }
    }
    
    
    @objc func addNewPhoto() {
        let isCameraAvailable = UIImagePickerController.isSourceTypeAvailable(.camera)
        if isCameraAvailable {
            let ac = UIAlertController(title: "Please select source of input", message: nil, preferredStyle: .actionSheet)
            let cameraButton = UIAlertAction(title: "Camera", style: .default) { _ in
                let picker = UIImagePickerController()
                self.pickerChoice(picker: picker, isCameraAvailable: isCameraAvailable)
            }
            let photoButton = UIAlertAction(title: "Libary", style: .default) { _ in
                let picker = UIImagePickerController()
                self.pickerChoice(picker: picker, isCameraAvailable: !isCameraAvailable)
            }
            
            ac.addAction(cameraButton)
            ac.addAction(photoButton)
            present(ac, animated: true)
        } else {
            let picker = UIImagePickerController()
            pickerChoice(picker: picker, isCameraAvailable: isCameraAvailable)
        }
    }
    
    func pickerChoice(picker: UIImagePickerController, isCameraAvailable: Bool) {
        if isCameraAvailable {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let photo = Photo(title: "Unknown", image: imageName)
        
        photos.append(photo)
        tableView.reloadData()

        dismiss(animated: true)
    }
    
    func showRenameAlert(photo: Photo) {
        let ac = UIAlertController(title: "Rename", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.textFields?[0].text = photo.title
        let ok = UIAlertAction(title: "Rename", style: .default) {[weak self, weak ac] _ in
            guard let newName = ac?.textFields?[0].text else { return }
            photo.title = newName
            self?.tableView.reloadData()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ac.addAction(ok)
        ac.addAction(cancel)
        present(ac, animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

