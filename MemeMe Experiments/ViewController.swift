//
//  ViewController.swift
//  MemeMe Experiments
//
//  Created by John McCaffrey on 5/27/15.
//  Copyright (c) 2015 theARTboy LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var pickerController: UIImagePickerController?
    
    @IBOutlet weak var imagePickerView: UIImageView!
    var imagePicker:UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = UIImagePickerController()

        imagePicker.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    
    }
    
    @IBAction func pickAnImage(sender: AnyObject) {
//        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        self.presentViewController(imagePicker, animated: true, completion: nil)

    }
    
}

