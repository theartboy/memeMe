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
    
    @IBOutlet weak var collectionView: UICollectionView!
    var newButton = UIBarButtonItem()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "anotherMeme")
        
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = newButton
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        if (appDelegate.memes.count == 0) {
            let editController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController")! as! ViewController
            self.dismissViewControllerAnimated(false, completion: nil)
            self.navigationController?.pushViewController(editController, animated: false)
        }
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        self.collectionView?.reloadData()

    }

    
    func anotherMeme(){
        self.dismissViewControllerAnimated(true, completion: nil)
        self.performSegueWithIdentifier("newMeme", sender: self)
        
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes = applicationDelegate.memes
        
    }

    
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
