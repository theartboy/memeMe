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

    override func viewDidLoad() {
        super.viewDidLoad()
        memeImage.contentMode = .ScaleAspectFill

        // Do any additional setup after loading the view.
        self.memeImage.image = meme.memedImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
