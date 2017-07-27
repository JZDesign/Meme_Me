//
//  MemeViewController.swift
//  Meme Me
//
//  Created by JacobRakidzich on 5/10/17.
//  Copyright © 2017 Jacob Rakidzich. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, SettingsViewControllerDelegate {
    
    @IBOutlet var views: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet var cancelButtonOutlet: UIBarButtonItem!
    
var memes: [Meme]!
    
    let keyboardSlider = KeyboardSlider()
    
  
    
    // variable for settings update
    var fontString = "HelveticaNeue-CondensedBlack"
    
    
    // MARK: Lifcycle
    
    override func viewWillAppear(_ animated: Bool) {
        //set camera button based on device capability
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        // find memes
        memes = (UIApplication.shared.delegate as! AppDelegate).memes
        
        // set cancel button isEnabled based on meme count
        if memes.count < 1{
            cancelButtonOutlet.isEnabled = false
        } else {
            cancelButtonOutlet.isEnabled = true
        }
        
        //subscribe to slide
        keyboardSlider.subscribeToKeyboardNotifications(view: view)
        
        // text field reset
        if imageView.image == nil {
            topTextField.text = "TOP"
            bottomTextField.text = "BOTTOM"
            }
        // text field attributes
        // if called in viewDidLoad, text type does not update after settings
        textFieldAttributes(textField: topTextField)
        textFieldAttributes(textField: bottomTextField)

       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        keyboardSlider.unsubscribeFromKeyboardNotifications()
    }

    
    // MARK: Textfield
    
    func textFieldAttributes(textField: UITextField) {
        let memeTextAttributes:[String:Any] = [
            NSStrokeColorAttributeName: UIColor.black,
            NSFontAttributeName: UIFont(name: fontString, size: 40)!,
            NSForegroundColorAttributeName: UIColor.white,
            NSStrokeWidthAttributeName: -2.5]

        textField.delegate = self
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
        textField.borderStyle = .none
        textField.sizeToFit()
    }
    

    // MARK: ImagePickerHelper for Actions
    
    func helperImagePicker(sourceType: UIImagePickerControllerSourceType) -> UIImagePickerController {
        // assign source type to imagePicker and return it based on selected button
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = sourceType
        return picker
    }
    
    
    // MARK: Actions
    
    @IBAction func pickAnImage(_ sender: Any) {
        present(helperImagePicker(sourceType: .photoLibrary), animated: true, completion: nil)
    }
    
    
    @IBAction func imageFromCamera(_ sender: Any) {
        present(helperImagePicker(sourceType: .camera), animated: true, completion: nil)
        
    }
    

    
    @IBAction func doShareAction(_ sender: Any) {
        // set image then launch activity controller to share or save meme
        let image = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        controller.completionWithItemsHandler = { (activityType, completed, returnedItems, activityError) -> () in
            if completed {
                // auto save, do not save duplicates if they select save image
                self.save(didSave: activityType == UIActivityType.saveToCameraRoll)
            }
        }
        present(controller, animated: true, completion: nil)
    }
    
    
    // go to tab bar and cancel meme creation
    @IBAction func doCancelButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
        
    // MARK: - Navigation
    
    // Send user to settings page and ensure display matches picker defaults.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Settings"{
            let destinationNavigationController = segue.destination as! UINavigationController
            let targetController = destinationNavigationController.topViewController as! SettingsViewController
            targetController.delegate = self
            targetController.textAttributeFont = UIFont.familyNames[0]
            targetController.backgroundColor = .blue
        }
    }

    
    
    
    // MARK: Settings Delegate
    
    // update settings by calling data passed backward through the settings delegate
    func readData(fontType: String, theBackgroundColor: UIColor) {
        self.view.backgroundColor = theBackgroundColor
        self.fontString = fontType
    }
    

    
}
