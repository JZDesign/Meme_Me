//
//  SettingsPicker.swift
//  Meme Me
//
//  Created by JacobRakidzich on 5/12/17.
//  Copyright © 2017 Jacob Rakidzich. All rights reserved.
//

import UIKit

class SettingsPicker: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    var colors = ["Blue" : UIColor.blue, "Green" : UIColor.green, "Red" : UIColor.red, "Yellow" : UIColor.yellow, "Orange" :  UIColor.orange, "Purple" : UIColor.purple, "Brown" : UIColor.brown, "Black" : UIColor.black, "White" : UIColor.white]
    
    var colorString = ["Blue", "Green" , "Red" , "Yellow" , "Orange" , "Purple" , "Brown", "Black", "White"]
    


    
    // MARK: DATASOURCE
    
    // update picker view limits
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if component == 0 {
            return colorString.count
        } else {
            return UIFont.familyNames.count
        }
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    

}
