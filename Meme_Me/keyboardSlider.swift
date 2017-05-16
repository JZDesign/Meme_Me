//
//  keyboardSlider.swift
//  Meme Me
//
//  Created by JacobRakidzich on 5/11/17.
//  Copyright © 2017 Jacob Rakidzich. All rights reserved.
//

import Foundation
import UIKit

extension MemeViewController {
    
    
    // MARK: Keyboard Slider and observer methods
    
    
    func keyboardWillShow(_ notification: NSNotification) {
        // selector method to move keyboard up
        if topWasTouched == false {
            view.frame.origin.y = 0 - getKeyboardHeight(notification as Notification)
        }
    }
    
    /*
     
     '''this function was choppy, even with a UIView animation'''
     
     func keyboardWillDissapear(_ notification: NSNotification) {
     view.frame.origin.y = 0
     }
     */
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        // get exact height of keyboard on all devices and convert to float value to return for use
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
        
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        // observer method to hide keyboard
        //NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDissapear(_:)), name: .UIKeyboardDidHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
    }
    

}
