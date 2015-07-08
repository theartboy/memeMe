//
//  MemeDetailViewController.swift
//  MemeMe Experiments
//
//  Created by John McCaffrey on 6/29/15.
//  Copyright (c) 2015 theARTboy LLC. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
//    var memes: [Meme]!
    var meme: Meme!
    @IBOutlet weak var memeImage: UIImageView!
    var editButton = UIBarButtonItem()
    var deleteButton = UIBarButtonItem()
    var currentIndex:Int!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //memeImage.contentMode = .ScaleAspectFill

        // Do any additional setup after loading the view.
        self.memeImage.image = meme.memedImage
        deleteButton = UIBarButtonItem(title: "Delete", style: .Done, target: self, action: "delete")
        self.navigationItem.rightBarButtonItem = deleteButton
//        editButton = UIBarButtonItem(title: "Edit", style: .Done, target: self, action: "edit")
//        self.navigationItem.rightBarButtonItems = [editButton,deleteButton]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func delete(){
        //delete the current meme
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.removeAtIndex(currentIndex)
        
        //go back to the sent memes scene
        self.navigationController?.popViewControllerAnimated(true)
        
        

    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        let editorVC = self.storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController")! as! ViewController
//        
//        editorVC.meme = self.meme
//        editorVC.isEditingMeme = true
//        junkInt = 10
//        let controller = segue.destinationViewController as! ViewController
//        controller.junkInt = 10000
//        controller.isEditingMeme = true
//        controller.tt = "YES"
//        controller.bt = "really"

    }
    func edit(){
        //edit the current meme
//        let object = UIApplication.sharedApplication().delegate
//        let appDelegate = object as! AppDelegate

        //                var storyboard = UIStoryboard (name: "Main", bundle: nil)
//                var editorVC = storyboard.instantiateViewControllerWithIdentifier("MemeEditorViewController")as! ViewController
        
        //sanitize the image and save button so when returning for a new meme they are ready for business
        //        self.imagePickerView.image = UIImage()
//                editorVC.saveButton.enabled = true
//
//
//        let editorVC = self.storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController")! as! ViewController
//        editorVC.junkInt = 8
        
//        editorVC.meme = self.meme
//        editorVC.isEditingMeme = true
//        editorVC.imagePickerView.image = meme.image
//        editorVC.topText.text = "fred"//meme.topText
        
        //        editorVC.bottomText.text = meme.bottomText
//        editorVC.ttext.text = meme.bottomText
//        print(meme.topText)
        
        
        

//        detailController.meme   = self.memes[indexPath.row]
        
//        self.dismissViewControllerAnimated(true, completion: nil)
//
//        self.performSegueWithIdentifier("editMeme", sender: self)
//        let editController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController")! as! ViewController
//        
//        editController.junkInt = 10
//        editController.isEditingMeme = true
//        editController.tt = "YES"
//        editController.bt = "really"
//
//        self.dismissViewControllerAnimated(true, completion: nil)
//        self.navigationController!.pushViewController(editController, animated: true)

        //go back to the sent memes scene
//        self.navigationController?.popViewControllerAnimated(true)
        
    }

}
