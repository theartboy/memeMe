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
        
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = newButton
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        //populate local memes var with the memes array
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes = applicationDelegate.memes
        
    }

    
    override func viewDidAppear(animated: Bool) {
        //need to make sure to update the table data after deletion of meme
        collectionView?.reloadData()

    }

    
    //MARK: CollectionView count dequeue selectItem
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionViewCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        let meme = memes[indexPath.row]
        
        // Set the name and image
        cell.imageView?.image = meme.memedImage
        cell.imageView?.contentMode = .ScaleAspectFit
        
        return cell
        
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath){
        
        let detailController = storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController")! as! MemeDetailViewController
        detailController.meme   = memes[indexPath.row]
        //sends the index of the selected meme to the detail view
        detailController.currentIndex = indexPath.row
        //hides the tab bar in the detail view
        detailController.hidesBottomBarWhenPushed = true
        
        
        navigationController!.pushViewController(detailController, animated: true)
        
    }
    
    
    // MARK: move to editor for new meme
    
    func anotherMeme(){
        //navigate to the meme editor to create a new meme
        let editController = storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController")! as! ViewController
        
        //hides the tab bar on the editor view controller
        editController.hidesBottomBarWhenPushed = true
        
        dismissViewControllerAnimated(true, completion: nil)
        navigationController?.pushViewController(editController, animated: false)
        
    }

}
