//
//  ViewController.swift
//  MemeMe Experiments
//
//  Created by John McCaffrey on 5/27/15.
//  Copyright (c) 2015 theARTboy LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var imagePickerView: UIImageView!
    
    var cameraButton: UIBarButtonItem!
    var saveButton: UIBarButtonItem!
    var albumButton: UIBarButtonItem!
    var cancelButton: UIBarButtonItem!
    var flexiblespace = UIBarButtonItem()
    
    var meme: Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        albumButton = UIBarButtonItem(title: "Album", style: .Done, target: self, action: "pickAnImageFromAlbum")
        cameraButton = UIBarButtonItem(barButtonSystemItem: .Camera, target: self, action: "pickAnImageFromCamera")
        saveButton = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: "shareMeme")
        cancelButton = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "cancelMeme")
        flexiblespace = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil)
        
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
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        self.navigationController?.setToolbarHidden(false, animated: false)
        
        self.navigationItem.hidesBackButton = true
        
        self.navigationItem.leftBarButtonItem = saveButton
        self.navigationItem.rightBarButtonItem = cancelButton
        self.toolbarItems = [flexiblespace,cameraButton,flexiblespace,albumButton,flexiblespace]
        
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        cancelButton.enabled = false
        saveButton.enabled = false
        topText.text = "TOP"
        bottomText.text = "BOTTOM"
        self.tabBarController?.tabBar.hidden = true
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
        self.navigationController?.setNavigationBarHidden(false, animated: false)
//
        self.navigationController?.setToolbarHidden(false, animated: false)
//        self.tabBarController?.hidesBottomBarWhenPushed
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        if (appDelegate.memes.count == 0) {
            cancelButton.enabled = false
        }else{
            cancelButton.enabled = true
        }
//
//        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
//        topText.text = "TOP"
//        bottomText.text = "BOTTOM"
        
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
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
    
    //@IBAction func pickAnImageFromCamera(sender: AnyObject) {
    func pickAnImageFromCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
//    @IBAction func pickAnImageFromAlbum(sender: AnyObject) {
    func pickAnImageFromAlbum() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }

    func cancelMeme(){
        var storyboard = UIStoryboard (name: "Main", bundle: nil)
        var sentMemeController = storyboard.instantiateViewControllerWithIdentifier("TabBarController")as! UITabBarController
        
        //sanitize the image and save button so when returning for a new meme they are ready for business
        self.imagePickerView.image = UIImage()
        self.saveButton.enabled = false
        self.topText.text = "TOP"
        self.bottomText.text = "BOTTOM"
        
        self.dismissViewControllerAnimated(true, completion: nil)
        self.navigationController?.presentViewController(sentMemeController, animated: true, completion:nil)
        
    }
    
    
    func shareMeme (){
        var meme = Meme(
            topText: topText.text!,
            bottomText: bottomText.text!,
            image: imagePickerView.image!,
            memedImage: generateMemedImage())
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        print("current count of memes: \(appDelegate.memes.count)\n")
        
        let activityController = UIActivityViewController(activityItems: [meme.memedImage], applicationActivities: nil)
        self.presentViewController(activityController, animated: true, completion: nil)
        
        activityController.completionWithItemsHandler = {(activityType, completed, items, error) in
//            if !completed {
//                print("\ncancelled share")
//                return
//            }
//            if activityType == UIActivityTypeSaveToCameraRoll {
//                print("\nSave to roll")
//            }            
//            if activityType == UIActivityTypeMail {
//                print("\nmail")
//            }

            var storyboard = UIStoryboard (name: "Main", bundle: nil)
            var sentMemeController = storyboard.instantiateViewControllerWithIdentifier("TabBarController")as! UITabBarController
            
            //sanitize the image and save button so when returning for a new meme they are ready for business
            self.imagePickerView.image = UIImage()
            self.topText.text = "TOP"
            self.bottomText.text = "BOTTOM"
            self.saveButton.enabled = false
            self.dismissViewControllerAnimated(true, completion: nil)
          
            self.navigationController?.presentViewController(sentMemeController, animated: true, completion:nil)

        }
        
        
    }
    func generateMemedImage() -> UIImage {
        //Hide toolbar and navbar
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.setToolbarHidden(true, animated: false)
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //Show toolbar and navbar
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.setToolbarHidden(false, animated: false)
        
        return memedImage
    }
    
    //MARK:- KEYBOARD ITEMS
    //After enter is pressed at we dismiss the keyboard
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

}

