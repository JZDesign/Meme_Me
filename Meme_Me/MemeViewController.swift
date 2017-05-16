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
    
    
    // bool to prevent view from moving if unnecessary
    var topWasTouched: Bool = false
    
    // meme object struct
    struct Meme {
        var topText = ""
        var bottomText = ""
        var image = UIImage()
        var memedImage = UIImage()
    }
    
    // variable for settings update
    var fontString = "HelveticaNeue-CondensedBlack"
    
    
    // MARK: Lifcycle
    
    override func viewWillAppear(_ animated: Bool) {
        //set camera button based on device capability
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)

        //subscribe to slide
        subscribeToKeyboardNotifications()

        // text field attributes
        if imageView.image == nil {
            topTextField.text = "TOP"
            bottomTextField.text = "BOTTOM"
            }
        
        self.topTextField.delegate = self
        self.bottomTextField.delegate = self
        let memeTextAttributes:[String:Any] = [
            NSStrokeColorAttributeName: UIColor.black,
            NSFontAttributeName: UIFont(name: fontString, size: 40)!,
            NSForegroundColorAttributeName: UIColor.white,
            NSStrokeWidthAttributeName: -2.5]
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        topTextField.textAlignment = .center
        bottomTextField.textAlignment = .center
        topTextField.borderStyle = .none
        bottomTextField.borderStyle = .none
        topTextField.sizeToFit()
        bottomTextField.sizeToFit()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }

    
    
    

    
    // MARK: Actions
    
    @IBAction func pickAnImage(_ sender: Any) {
        let pickercontroller = UIImagePickerController()
        pickercontroller.delegate = self
        pickercontroller.sourceType = .photoLibrary
        self.present(pickercontroller, animated: true, completion: nil)
    }
    
    
    @IBAction func imageFromCamera(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
        
    }
    

    
    @IBAction func doShareAction(_ sender: Any) {
        // set image then launch activity controller to share or save meme
        let image = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        controller.completionWithItemsHandler = { (activityType, completed, returnedItems, activityError) -> () in
            if (completed) {
                // auto save, do not save duplicates if they select save image
                if activityType == UIActivityType.saveToCameraRoll {
                    // if user touches save launch confirmation and close activity
                    self.dismiss(animated: true, completion: nil)
                    self.saveAlert()
                } else {
                    self.save()
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
        
        present(controller, animated: true, completion: nil)
    }
    
    
    
    
        
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
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
