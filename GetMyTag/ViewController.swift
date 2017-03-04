//
//  ViewController.swift
//  GetMyTag
//
//  Created by Felipe Mota on 04/03/17.
//  Copyright © 2017 Felipe Mota. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var takePictureButton: UIButton!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var progressView: UIProgressView!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    // MARK: - Properties
    fileprivate var tags: [String]?
    fileprivate var colors: [PhotoColor]?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard !UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
        
        takePictureButton.setTitle("Select Photo", for: .normal)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        imageView.image = nil
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowResults" {
            let controller = segue.destination as! TagsColorsViewController
            controller.tags = tags
            controller.colors = colors
        }
    }
    
    // MARK: - IBActions
    @IBAction func takePicture(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
            picker.modalPresentationStyle = .fullScreen
        }
        
        present(picker, animated: true)
    }
}

// MARK: - UIImagePickerControllerDelegate
extension ViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            print("Info did not have the required UIImage for the Original Image")
            dismiss(animated: true)
            return
        }
        
        imageView.image = image
        
        dismiss(animated: true)
    }
}

// MARK: - UINavigationControllerDelegate
extension ViewController: UINavigationControllerDelegate {
}
