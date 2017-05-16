//
//  keyboardSlider.swift
//  Meme Me
//
//  Created by JacobRakidzich on 5/11/17.
//  Copyright © 2017 Jacob Rakidzich. All rights reserved.
//

import Foundation
import UIKit

//extension MemeViewController {

class KeyboardSlider: NSObject {
    
    // variables to hold and process information from the view using this class
    var view: UIView?
    var top = Bool()
    
    
    func keyboardWillShow(notification: NSNotification) {
        // selector method to move keyboard up
        if top == false {
            view?.frame.origin.y = 0 - getKeyboardHeight(notification as Notification)
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
    
    func subscribeToKeyboardNotifications(view: UIView) {
        // assigning view class' counterparts
        self.view = view
        // when UIKeyboardWillShow do keyboardWillShow function
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
    }
    

}
