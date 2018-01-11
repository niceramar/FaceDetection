//
//  ViewController.swift
//  FaceDetection
//
//  Created by iOS on 10/01/2018.
//  Copyright © 2018 Ram. All rights reserved.
//

import UIKit
import Vision

class ViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var inputField: UITextField!
    var selImage: UIImage!
    
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
            self.selImage = selImage
            
            imageView.image = selImage
            imageView.contentMode = .scaleAspectFill
        }
        
        dismiss(animated: true, completion: nil)

        
        let request = VNDetectFaceRectanglesRequest {
            (req, err) in
            if let err = err{
                print("could not detect face: ", err)
                return
            }
            req.results?.forEach({ (res) in
                guard let faces = res as? VNFaceObservation else {return}
                
                let faceFrameView = UIView()
                faceFrameView.backgroundColor = .blue
                faceFrameView.alpha = 0.3
                
                let x = self.imageView.frame.width * faces.boundingBox.origin.x
                let y = self.imageView.frame.height * faces.boundingBox.origin.y
                let width = self.imageView.frame.width * faces.boundingBox.width
                let height = self.imageView.frame.width * faces.boundingBox.height
                
                
                faceFrameView.frame = CGRect(x: x, y: y, width: width, height: height)
                
                self.imageView.addSubview(faceFrameView)
                
                print(faces.boundingBox)
            })
        }

        guard let selCGImage = selImage.cgImage else {return}
        let  handler = VNImageRequestHandler(cgImage: selCGImage, options:[:])
        do{
            try handler.perform([request])
        } catch let reqErr{
            print("could not detect face: ", reqErr)
            return
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}

