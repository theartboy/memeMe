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
    var editButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        plusButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "anotherMeme")
        newButton = UIBarButtonItem(title: "New", style: .Done, target: self, action: "anotherMeme")
        editButton = UIBarButtonItem(title: "Edit", style: .Done, target: self, action: "edit")
        
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = newButton
        self.navigationItem.leftBarButtonItem = editButton
    
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

    
    override func viewWillAppear(animated:Bool) {
        super.viewWillAppear(true)
        
//        let object = UIApplication.sharedApplication().delegate
//        let appDelegate = object as! AppDelegate
//        memes = appDelegate.memes
        
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes = applicationDelegate.memes
    }
    
    // Get ahold of some villains, for the table
    // This is an array of Villain instances
//    let allVillains = Villain.allVillains
    
    // MARK: Table View Data Source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.memes.count
        return memes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeCell") as! UITableViewCell
        let meme = self.memes[indexPath.row]
        
        // Set the name and image
        cell.textLabel?.text = meme.topText
        cell.imageView?.image = meme.memedImage //UIImage(named: meme.image)
        
        // If the cell has a detail label, we will put the evil scheme in.
//        if let detailTextLabel = cell.detailTextLabel {
//            detailTextLabel.text = "Scheme: \(villain.evilScheme)"
//        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController")! as! MemeDetailViewController
        detailController.meme   = self.memes[indexPath.row]
        
        self.navigationController!.pushViewController(detailController, animated: true)
    }


}
