//
//  ViewController.swift
//  MemeMe Experiments
//
//  Created by John McCaffrey on 5/27/15.
//  Copyright (c) 2015 theARTboy LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
//    var pickerController: UIImagePickerController?
    
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var imagePickerView: UIImageView!

//    let memeTextDelegate = MemeTextDelegate()
    var topHasBeenEdited = false
    var bottomHasBeenEdited = false
    var keyboardHidden = true
    var meme: Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topText.delegate = self
        bottomText.delegate = self
        let memeTextAttributes = [
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSStrokeWidthAttributeName : -3.0
        ]
        topText.defaultTextAttributes = memeTextAttributes
        bottomText.defaultTextAttributes = memeTextAttributes
        topText.textAlignment = NSTextAlignment.Center
        bottomText.textAlignment = NSTextAlignment.Center
        saveButton.enabled = false

    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        topText.text = "TOP"
        bottomText.text = "BOTTOM"
        
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    //After the enter is pressed at we dismiss the keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField.isEqual(bottomText){
            self.unsubscribeFromKeyboardNotifications()
        }
        return true
    }
    
    //At the begining of Editing if the default text is written We reset it
    func textFieldDidBeginEditing(textField: UITextField) {
        
        if textField.text == "TOP" || textField.text == "BOTTOM"{
            textField.text = ""
        }
        if textField.isEqual(bottomText){
            self.subscribeToKeyboardNotifications()
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
            imagePickerView.contentMode = .ScaleAspectFill
            self.saveButton.enabled = true
        }

        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    
    }
    //MARK:- KEYBOARD RELATED
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:"    , name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:"    , name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name:UIKeyboardWillHideNotification, object: nil)
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    func keyboardWillShow(notification: NSNotification) {
//        if(keyboardHidden ){
//            //If the keyboard was not hidden.(e.g. we change the type of the keyboard on currently displayed keyboard view) there's no need to change the origin.
            self.view.frame.origin.y -= getKeyboardHeight(notification)
//            keyboardHidden = false
//        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
//        if(!keyboardHidden){
//            //If the keyboard was hidden.(e.g. we change the type of the keyboard on currently displayed keyboard view) there's no need to change the origin.
            self.view.frame.origin.y += getKeyboardHeight(notification)
//            keyboardHidden = true
//        }
    }
    
    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    @IBAction func pickAnImage(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }

    
    @IBAction func saveFromButton(sender: AnyObject) {
        share()
    }
    
    func share (){
        var meme = Meme(
            topText: topText.text!,
            bottomText: bottomText.text!,
            image: imagePickerView.image!,
            memedImage: generateMemedImage())
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        print(appDelegate.memes.count)
        
        let activityController = UIActivityViewController(activityItems: [meme.memedImage], applicationActivities: nil)
        self.presentViewController(activityController, animated: true, completion: nil)
        
        activityController.completionWithItemsHandler = {(activityType, completed, items, error) in
            if !completed {
                print("\ncancelled share")
                return
            }
            if activityType == UIActivityTypeSaveToCameraRoll {
                print("\nSave to roll")
            }            
            if activityType == UIActivityTypeMail {
                print("\nmail")
            }

            var storyboard = UIStoryboard (name: "Main", bundle: nil)
            var sentController = storyboard.instantiateViewControllerWithIdentifier("TabBarController")as! UITabBarController
            
            //sanitize the image and save button so when returning for a new meme they are ready for business
            self.imagePickerView.image = UIImage()
            self.saveButton.enabled = false
            
            self.navigationController?.presentViewController(sentController, animated: true, completion:nil)

        }
        
        
    }
    func generateMemedImage() -> UIImage {
        ////http://stackoverflow.com/questions/2926914/navigation-bar-show-hide
        // TODO: Hide toolbar and navbar
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.setToolbarHidden(true, animated: false)
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // TODO:  Show toolbar and navbar
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.setToolbarHidden(false, animated: false)
        
        return memedImage
    }
}

