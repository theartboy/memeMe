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
    
    var currentIndex:Int!//stores the index number of the meme detail to be used when deleting the meme
    

    override func viewDidLoad() {
        super.viewDidLoad()

        deleteButton = UIBarButtonItem(title: "Delete", style: .Done, target: self, action: "delete")
        navigationItem.rightBarButtonItem = deleteButton
        
        //populate the image and size it to fit
        memeImage.image = meme.memedImage
        memeImage.contentMode = .ScaleAspectFit
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
//        self.navigationController?.hidesBottomBarWhenPushed = true
    }


    func delete(){
        //delete the current meme
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate

        appDelegate.memes.removeAtIndex(currentIndex)
        
        //go back to the sent memes scene
        //remove detailView from scenes stack
        navigationController?.popViewControllerAnimated(true)
        
    }

}
