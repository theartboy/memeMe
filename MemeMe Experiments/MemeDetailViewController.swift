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
//        self.navigationItem.rightBarButtonItem = deleteButton
        editButton = UIBarButtonItem(title: "Edit", style: .Done, target: self, action: "edit")
        self.navigationItem.rightBarButtonItems = [editButton,deleteButton]
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
    func edit(){
        //edit the current meme
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
//        appDelegate.memes.removeLast()
        
        //go back to the sent memes scene
        self.navigationController?.popViewControllerAnimated(true)
        
    }

}
