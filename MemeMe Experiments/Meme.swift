//
//  Meme.swift
//  MemeMe Experiments
//
//  Created by John McCaffrey on 5/30/15.
//  Copyright (c) 2015 theARTboy LLC. All rights reserved.
//

import Foundation
import UIKit


struct Meme{
    let topText: String!
    let bottomText: String!
    let image: UIImage!
    let memedImage: UIImage!
    
    
    init (let topText:String, let bottomText:String, let image: UIImage, let memedImage:UIImage){
        self.topText = topText
        self.bottomText = bottomText
        self.image = image
        self.memedImage = memedImage
    }
}