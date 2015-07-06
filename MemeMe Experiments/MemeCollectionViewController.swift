//
//  MemeCollectionViewController.swift
//  MemeMe Experiments
//
//  Created by John McCaffrey on 6/9/15.
//  Copyright (c) 2015 theARTboy LLC. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UIViewController {

    var memes: [Meme]!
    
    var newButton = UIBarButtonItem()
    var editButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newButton = UIBarButtonItem(title: "New", style: .Done, target: self, action: "anotherMeme")
        editButton = UIBarButtonItem(title: "Edit", style: .Done, target: self, action: "edit")
        
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = newButton
        self.navigationItem.leftBarButtonItem = editButton
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func anotherMeme(){
        let editorVC = self.storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController")! as! ViewController
        //        editorVC.imagePickerView.image? = UIImage()
        self.dismissViewControllerAnimated(true, completion: nil)
        //self.performSegueWithIdentifier("anotherMeme", sender: self)
        
    }
    func edit(){
        self.editing = !self.editing
    }

    
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
        
        
        return cell
    }
    
     func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath)
    {
        
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController")! as! MemeDetailViewController
        detailController.meme   = self.memes[indexPath.row]
        
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
    
//    /////////////table view
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        //        return self.memes.count
//        return memes.count
//    }
//    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        
//        let cell = tableView.dequeueReusableCellWithIdentifier("MemeCell") as! UITableViewCell
//        let meme = self.memes[indexPath.row]
//        
//        // Set the name and image
//        cell.textLabel?.text = meme.topText
//        cell.imageView?.image = meme.memedImage //UIImage(named: meme.image)
//        
//        // If the cell has a detail label, we will put the evil scheme in.
//        //        if let detailTextLabel = cell.detailTextLabel {
//        //            detailTextLabel.text = "Scheme: \(villain.evilScheme)"
//        //        }
//        
//        return cell
//    }
//    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        //
//        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController")! as! MemeDetailViewController
//        detailController.meme   = self.memes[indexPath.row]
//        
//        self.navigationController!.pushViewController(detailController, animated: true)
//    }


}
