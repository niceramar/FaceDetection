//
//  ViewController.swift
//  FaceDetection
//
//  Created by iOS on 10/01/2018.
//  Copyright © 2018 Ram. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var inputField: UITextField!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imagePicker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func detectFace(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .savedPhotosAlbum
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selImage:UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imageView.image = selImage
            imageView.contentMode = .scaleAspectFill
            
         let scaledHeight = view.frame.width / selImage.size.width * selImage.size.height
            imageView.frame = CGRect(x: 10, y: 10, width: selImage.size.width, height: scaledHeight)
            
        }
         dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}

