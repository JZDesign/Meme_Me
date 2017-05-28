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
    
    
    func save() {
        // Create the meme and store if not nil
        if let _ = topTextField?.text, bottomTextField?.text != nil, imageView?.image != nil {
            var meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, image: imageView.image!, memedImage: generateMemedImage())
            // save array to appdelegate and also to photo album
            let object = UIApplication.shared.delegate
            let appDelegate = object as! AppDelegate
            appDelegate.memes.append(meme)
            // disabled for 2.0
            //UIImageWriteToSavedPhotosAlbum(meme.memedImage, self, #selector(image(_:didFinishSavingWithError:_:)), nil)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    /*
     //disabled for 2.0
    // helper method to handle errors and complete the save, modified from stack overflow
    func image(_: UIImage, didFinishSavingWithError error: NSError?, _:UnsafeRawPointer) {
        if error == nil {
            saveAlert()
        } else {
            let ac = UIAlertController(title: "Save error", message: error?.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(ac, animated: true, completion: nil)
        }
    }
    
    // let user know that image was saved
    func saveAlert() {
        let ac = UIAlertController(title: "Saved!", message: "Your image has been saved to the photo album.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Heck Yes!", style: .default, handler: nil))
        present(ac, animated: true, completion: nil)
    }
    
     */
    
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
