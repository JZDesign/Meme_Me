//
//  textField.swift
//  Meme Me
//
//  Created by JacobRakidzich on 5/11/17.
//  Copyright © 2017 Jacob Rakidzich. All rights reserved.
//

import Foundation
import UIKit

extension MemeViewController{
    
    
    
    // MARK: TextFieldDelegate Methods
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // delete all text on didBeginEditing
        // set class boolean in order to move view properly
        if (textField == self.topTextField) {
            keyboardSlider.top = true
            topTextField.text = ""
        }
        else {
            keyboardSlider.top = false
            bottomTextField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // hide keyboard and reset boolean
        keyboardSlider.top = false
        textField.resignFirstResponder()
        if view.frame.origin.y != 0 {
            // smooth animation to hide the keyboard in place of the observer
            // using the observer was choppy
            UIView.setAnimationCurve(UIViewAnimationCurve.easeInOut)
            UIView.animate(withDuration: 0.2) {
                self.view.frame.origin.y = 0
            }
        }
        
        return true
    }
    

}
