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

        //MARK: button setup
        albumButton = UIBarButtonItem(title: "Album", style: .Done, target: self, action: "pickAnImageFromAlbum")
        cameraButton = UIBarButtonItem(barButtonSystemItem: .Camera, target: self, action: "pickAnImageFromCamera")
        saveButton = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: "shareMeme")
        cancelButton = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "cancelMeme")
        flexiblespace = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil)
        
        navigationItem.leftBarButtonItem = saveButton
        navigationItem.rightBarButtonItem = cancelButton
        toolbarItems = [flexiblespace,cameraButton,flexiblespace,albumButton,flexiblespace]
        
        //enable the camera button if a camera is detected or allowed
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        //keep cancel active to return to sent meme scene
        cancelButton.enabled = true
        //start with save disabled because there is nothing to save yet
        saveButton.enabled = false
        
        setBarVisible(true)
        
        //MARK: set textField properties
        topText.delegate = self
        bottomText.delegate = self
        
        //establish the formatting of the meme text
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
        
        //set initial placeholder text
        topText.text = "TOP"
        bottomText.text = "BOTTOM"
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        setBarVisible(true)
        
    }
    
    //control showing and hiding the bars
    
    func setBarVisible(showHide: Bool){
        if showHide {
            //hide the back button on the nav bar
            navigationItem.hidesBackButton = false
            //set the nav and tool bars to show up - hidden = false
            navigationController?.setNavigationBarHidden(false, animated: false)
            navigationController?.setToolbarHidden(false, animated: false)
            
        } else {
            //hide the back button on the nav bar
            navigationItem.hidesBackButton = false
            //set the nav and tool bars to show up - hidden = true
            navigationController?.setNavigationBarHidden(true, animated: false)
            navigationController?.setToolbarHidden(true, animated: false)
            
        }
        
    }

    //MARK: imagePicker methods
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
            imagePickerView.contentMode = .ScaleAspectFill
            
            saveButton.enabled = true
        }

        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    
    }
    
    
    func pickAnImageFromCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera

        imagePicker.modalPresentationStyle =  UIModalPresentationStyle.CurrentContext
        
        presentViewController(imagePicker, animated: false, completion: nil)
        
    }
    
    
    func pickAnImageFromAlbum() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }

    
    //MARK: cancellation and sanitize
    
    //cancel creation and go back to the sent meme scene
    func cancelMeme(){
        let sentMemeController = storyboard!.instantiateViewControllerWithIdentifier("TabBarController")! as! UITabBarController
        
        //sanitize the image and save button so when returning for a new meme they are ready for business
        sanitizeMeme()
        
        dismissViewControllerAnimated(true, completion: nil)
        navigationController?.presentViewController(sentMemeController, animated: true, completion:nil)
        
    }
    
    
    func sanitizeMeme(){
        //sanitize the image and save button so when returning for a new meme they are ready for business
        imagePickerView.image = UIImage()
        saveButton.enabled = false
        topText.text = "TOP"
        bottomText.text = "BOTTOM"
        
    }
    
    
    //MARK: share with activity controller
    func shareMeme (){
        var meme = Meme(
            topText: topText.text!,
            bottomText: bottomText.text!,
            image: imagePickerView.image!,
            memedImage: generateMemedImage())
        
        let activityController = UIActivityViewController(activityItems: [meme.memedImage], applicationActivities: nil)
        presentViewController(activityController, animated: true, completion: nil)
        
        activityController.completionWithItemsHandler = {(activityType, completed, items, error) in
            //need to exit activityController if the user cancels the share
            if !completed {
                return
            }
            
            //add the new meme to the array
            let object = UIApplication.sharedApplication().delegate
            let appDelegate = object as! AppDelegate
            appDelegate.memes.append(meme)
            
            let sentMemeController = self.storyboard!.instantiateViewControllerWithIdentifier("TabBarController")! as! UITabBarController
            
            self.sanitizeMeme()
            
            self.dismissViewControllerAnimated(true, completion: nil)
            self.navigationController?.presentViewController(sentMemeController, animated: true, completion:nil)

        }
        
    }
    
    //MARK: create the image from the view
    func generateMemedImage() -> UIImage {
        //hide toolbar and navbar
        setBarVisible(false)
        
        // render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //show toolbar and navbar
        setBarVisible(true)
        
        return memedImage
    }
    
    //MARK: keyboard related stuff
    
    //dismiss the keyboard with ENTER
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField.isEqual(bottomText){
            unsubscribeFromKeyboardNotifications()
        }
        return true
    }
    
    //wipe placeholder text when editing begins
    func textFieldDidBeginEditing(textField: UITextField) {
        
        if textField.text == "TOP" || textField.text == "BOTTOM"{
            textField.text = ""
        }
        //bottomText subscribes to notifications so the view can slide up as needed
        if textField.isEqual(bottomText){
            subscribeToKeyboardNotifications()
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
        view.frame.origin.y -= getKeyboardHeight(notification)

    }
    
    func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y += getKeyboardHeight(notification)

    }

}

