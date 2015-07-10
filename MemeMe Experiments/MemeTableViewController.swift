//
//  MemeTableViewController.swift
//  MemeMe Experiments
//
//  Created by John McCaffrey on 6/9/15.
//  Copyright (c) 2015 theARTboy LLC. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    var memes: [Meme]!
    var newButton = UIBarButtonItem()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "anotherMeme")
        
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = newButton

    }

    
    override func viewWillAppear(animated:Bool) {
        super.viewWillAppear(true)
        
        //populate local memes var with the memes array
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes = applicationDelegate.memes
    }
    override func viewDidAppear(animated: Bool) {
        //need to make sure to update the table data after deletion of meme
        tableView?.reloadData()
    }
    
    
    // MARK: TableView count dequeue selectRow
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeCell") as! UITableViewCell
        let meme = memes[indexPath.row]
        
        // Set the name and image
        cell.textLabel?.text = meme.topText+" - "+meme.bottomText
        cell.imageView?.image = meme.memedImage
                
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailController = storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController")! as! MemeDetailViewController
        detailController.meme   = self.memes[indexPath.row]
        //sends the index of the selected meme to the detail view
        detailController.currentIndex = indexPath.row
        //hides the tab bar in the detail view
        detailController.hidesBottomBarWhenPushed = true
        
        //navigate to detail view of meme
        navigationController!.pushViewController(detailController, animated: true)
        
    }
    
    
    // MARK: move to editor for new meme
    
    func anotherMeme(){
        //navigate to the meme editor to create a new meme
        dismissViewControllerAnimated(true, completion: nil)
        performSegueWithIdentifier("newMeme", sender: self)
        
    }

}
