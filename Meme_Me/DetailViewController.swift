//
//  DetailViewController.swift
//  Meme_Me
//
//  Created by JacobRakidzich on 5/28/17.
//  Copyright © 2017 Jacob Rakidzich. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var memeImage: UIImageView!

    var image: UIImage!
    
    //display image and hide tab bar
    override func viewWillAppear(_ animated: Bool) {
        memeImage.image = image
        self.tabBarController?.tabBar.isHidden = true
    }
    
    //display tab bar on view dismissal
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
}
