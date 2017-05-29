//
//  SettingsViewController.swift
//  Meme Me
//
//  Created by JacobRakidzich on 5/12/17.
//  Copyright © 2017 Jacob Rakidzich. All rights reserved.
//

import UIKit



let settingsPickerDataSource = SettingsPicker()

// protocol delegate to pass data backward
protocol SettingsViewControllerDelegate {
    func readData(fontType: String, theBackgroundColor: UIColor)
}

class SettingsViewController: UIViewController, UINavigationControllerDelegate, UIPickerViewDelegate {
    
    

    @IBOutlet weak var settingsPicker: UIPickerView!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var fontField: UITextField!
    
    var delegate : SettingsViewControllerDelegate?
    
    
    // variables to change settings
    var backgroundColor = UIColor()
    var textAttributeFont = UIFont.familyNames[0]
    var textAttributes:[String:Any] = [:]
    
    

    
    // MARK: LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        // set picker
        settingsPicker.delegate = self
        settingsPicker.dataSource = settingsPickerDataSource
        
        // update background color to default text
        colorView.backgroundColor = UIColor.blue
        
        // update text attributes
        textAtt()
        
    }
    
    //set font settings 
    func textAtt() {
        textAttributes = [
            NSStrokeColorAttributeName: UIColor.black,
            NSFontAttributeName: UIFont(name: textAttributeFont, size: 40)!,
            NSForegroundColorAttributeName: UIColor.white,
            NSStrokeWidthAttributeName: -2.5]
        fontField.defaultTextAttributes = textAttributes
        fontField.textAlignment = .center
        fontField.sizeToFit()
    }
    
    
    
    // MARK: Actions
    
    // update settings or revert to defaults by passing data through the settings delegate
    @IBAction func doDoneButton(_ sender: Any) {
        self.delegate?.readData(fontType: textAttributeFont, theBackgroundColor: backgroundColor)
        dismiss(animated: true)
    }
    
    @IBAction func doCancelButton(_ sender: Any) {
        self.delegate?.readData(fontType: "HelveticaNeue-CondensedBlack", theBackgroundColor: UIColor.init(colorLiteralRed: 0.258, green: 0.258, blue: 0.258, alpha: 1.0))
        dismiss(animated: true)
    }
    


    
    // MARK: DELEGATE
    // fill picker with options and update settings on row selection
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let componets = [settingsPickerDataSource.colorString,UIFont.familyNames]
        return componets[component][row]
    }
   
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0{
            backgroundColor = settingsPickerDataSource.colors[settingsPickerDataSource.colorString[row]]!
            colorView.backgroundColor = backgroundColor
        } else {
            textAttributeFont = UIFont.familyNames[row]
            textAtt()
        }
    }
    

    

}
