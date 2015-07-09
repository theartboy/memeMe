//
//  MemeDetailViewController.swift
//  MemeMe Experiments
//
//  Created by John McCaffrey on 6/29/15.
//  Copyright (c) 2015 theARTboy LLC. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    @IBOutlet weak var memeImage: UIImageView!
    
    var meme: Meme!
    var editButton = UIBarButtonItem()
    var deleteButton = UIBarButtonItem()
    var currentIndex:Int!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        deleteButton = UIBarButtonItem(title: "Delete", style: .Done, target: self, action: "delete")
        navigationItem.rightBarButtonItem = deleteButton
        
        memeImage.image = meme.memedImage
        memeImage.contentMode = .ScaleAspectFit
    }


    func delete(){
        //delete the current meme
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.removeAtIndex(currentIndex)
        
        //go back to the sent memes scene
        //remove from scenes stack
        navigationController?.popViewControllerAnimated(true)
        
    }

}
