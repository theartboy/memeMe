//
//  MemeCollectionViewController.swift
//  MemeMe Experiments
//
//  Created by John McCaffrey on 6/9/15.
//  Copyright (c) 2015 theARTboy LLC. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UIViewController,UICollectionViewDataSource {

    var memes: [Meme]!
    
    var newButton = UIBarButtonItem()
//    var editButton = UIBarButtonItem()
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "anotherMeme")
//        editButton = UIBarButtonItem(title: "Edit", style: .Done, target: self, action: "edit")
        
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = newButton
//        self.navigationItem.leftBarButtonItem = editButton
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        if (appDelegate.memes.count == 0) {
//            self.dismissViewControllerAnimated(false, completion: nil)
//            self.performSegueWithIdentifier("newMeme", sender: self)
            let editController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController")! as! ViewController
            self.dismissViewControllerAnimated(false, completion: nil)
//            self.navigationController!.presentViewController(editController, animated: false, completion: nil)
            self.navigationController?.pushViewController(editController, animated: false)
        }
    }
    override func viewDidAppear(animated: Bool) {
        self.collectionView?.reloadData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func anotherMeme(){
//        let editorVC = self.storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController")! as! ViewController
        //        editorVC.imagePickerView.image? = UIImage()
        self.dismissViewControllerAnimated(true, completion: nil)
        self.performSegueWithIdentifier("newMeme", sender: self)
//        self.navigationController!.pushViewController(editorVC, animated: true)
//        var storyboard = UIStoryboard (name: "Main", bundle: nil)
//        var editorVC = storyboard.instantiateViewControllerWithIdentifier("MemeEditorViewController")as! UIViewController
        
        //sanitize the image and save button so when returning for a new meme they are ready for business
//        self.imagePickerView.image = UIImage()
//        self.saveButton.enabled = false
        
//        self.navigationController?.presentViewController(editorVC, animated: true, completion:nil)
        
    }
//    func edit(){
//        self.editing = !self.editing
//        self.collectionView?.reloadData()
//    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes = applicationDelegate.memes
    }
    //////////////bond villians collection view
    
      func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
      func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionViewCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        let meme = self.memes[indexPath.row]
        
        // Set the name and image
        cell.imageView?.image = meme.memedImage
        cell.imageView?.contentMode = .ScaleAspectFit
        
        
        return cell
    }
    
      func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath){
        
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController")! as! MemeDetailViewController
        detailController.meme   = self.memes[indexPath.row]
        detailController.currentIndex = indexPath.row
        
        
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
    
}
