//
//  MemeTextDelegate.swift
//  MemeMe Experiments
//
//  Created by John McCaffrey on 5/28/15.
//  Copyright (c) 2015 theARTboy LLC. All rights reserved.
//

import Foundation
import UIKit

class MemeTextDelegate: NSObject, UITextFieldDelegate{
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
//        var newText: NSString = textField.text
//        newText = newText.stringByReplacingCharactersInRange(range, withString: string)
//        if string.toInt() != nil || range.length==1 {
//            if newText.length < 6 {
                return true
//            }
//            
//        }
//        return false
        
        ////answer fro mthe forums
        //        if string.toInt() != nil || range.length==1 {
        //            var newText = textField.text as NSString
        //            newText = newText.stringByReplacingCharactersInRange(range, withString: string)
        //            if newText.length < 6 {
        //                println(range)
        //                return true
        //            }
        //        }
        //        return false
        //
    }
    ////udacity solution
    //    var newText = textField.text as NSString
    //    newText = newText.stringByReplacingCharactersInRange(range, withString: string)
    //
    //    return newText.length <= 5
    //}
    //
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM" {
            textField.text = ""
            
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
    }
    
}
