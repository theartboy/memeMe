//
//  MemeCollectionViewController.swift
//  MemeMe Experiments
//
//  Created by John McCaffrey on 6/9/15.
//  Copyright (c) 2015 theARTboy LLC. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UIViewController,UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!

    var memes: [Meme]!
    var newButton = UIBarButtonItem()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "anotherMeme")
        
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = newButton
        
        //Check if any memes currently exist. If none are present, jump to the editor
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        if (appDelegate.memes.count == 0) {
            let editController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController")! as! ViewController
            self.dismissViewControllerAnimated(false, completion: nil)
            self.navigationController?.pushViewController(editController, animated: false)
        }
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        //populate local memes var with the memes array
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes = applicationDelegate.memes
        
    }

    
    override func viewDidAppear(animated: Bool) {
        //need to make sure to update the table data after deletion of meme
        self.collectionView?.reloadData()

    }

    
    //MARK: CollectionView count dequeue selectItem
    
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
        //sends the index of the selected meme to the detail view
        detailController.currentIndex = indexPath.row
        //hides the tab bar in the detail view
        detailController.hidesBottomBarWhenPushed = true
        
        
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
    
    
    // MARK: move to editor for new meme
    
    func anotherMeme(){
        //navigate to the meme editor to create a new meme
        self.dismissViewControllerAnimated(true, completion: nil)
        self.performSegueWithIdentifier("newMeme", sender: self)
        
    }

}
