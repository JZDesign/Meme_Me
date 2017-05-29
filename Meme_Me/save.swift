    //
//  save.swift
//  Meme Me
//
//  Created by JacobRakidzich on 5/11/17.
//  Copyright © 2017 Jacob Rakidzich. All rights reserved.
//

import Foundation
import UIKit

extension MemeViewController{
    
    // MARK: Meme generator and saving methods
    
    
    func save(didSave: Bool) {
        // Create the meme and store if not nil
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        let count = appDelegate.memes.count
        if let _ = topTextField?.text, bottomTextField?.text != nil, imageView?.image != nil {
            var meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, image: imageView.image!, memedImage: generateMemedImage())
            // save array to appdelegate and also to photo album
            appDelegate.memes.append(meme)
            if appDelegate.memes.count > count{
                saveAlert(didSave: didSave, memedImage: meme.memedImage)
            }
        }
    }
    
    
    
    // helper method to handle errors and complete the save, modified from stack overflow
    
    func image(_: UIImage, didFinishSavingWithError error: NSError?, _:UnsafeRawPointer) {
        if error == nil {
            let ac = UIAlertController(title: "Save Complete!", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Heck Yes!", style: .default, handler:{(action:UIAlertAction) in self.dismiss(animated: true)}))
            present(ac, animated: true, completion: nil)
        } else {
            let ac = UIAlertController(title: "Save error", message: error?.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler:{(action:UIAlertAction) in self.dismiss(animated: true)}))
            present(ac, animated: true, completion: nil)
        }
        
    }
    
    // let user know that image was saved or offer to save it
    func saveAlert(didSave: Bool, memedImage: UIImage) {
        
        var ac: UIAlertController
        
        let unsavedMessage = "Do you want to save your image to the Photo Gallery?"
        let savedMessage = "Your image has been saved to the Photo Album."
        
        let action = UIAlertAction(title: "Heck Yes!", style: .default, handler: {(action:UIAlertAction!) in self.dismiss(animated: true)})
        
        let save = UIAlertAction(title: "Yes", style: .default, handler: {(action:UIAlertAction) in UIImageWriteToSavedPhotosAlbum(memedImage, self, #selector(self.image(_:didFinishSavingWithError:_:)), nil)
        })
        
        if didSave {
            ac = UIAlertController(title: "Saved!", message: savedMessage, preferredStyle: .alert)
            ac.addAction(action)
        } else {
            ac = UIAlertController(title: "Hey!", message: unsavedMessage, preferredStyle: .alert)
            ac.addAction(save)
            ac.addAction(UIAlertAction(title: "No Thanks", style: .destructive, handler:{(action:UIAlertAction) in self.dismiss(animated: true)}))
        }
        present(ac, animated: true, completion: nil)
        
    
        
    }
    
    
    
    // remove tool and navigation bars and save the data on the screen as a meme.
    func generateMemedImage() -> UIImage {
        //hide top and bottom bars to ensure a clean meme
        self.navigationController?.delegate = self
        navigationController?.isNavigationBarHidden = true
        toolbar.isHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        //re display bars so user can make more memes
        navigationController?.isNavigationBarHidden = false
        toolbar.isHidden = false
        
        return memedImage
    }
    
    
}
