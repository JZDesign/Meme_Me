//
//  MemeTableViewController.swift
//  Meme_Me
//
//  Created by JacobRakidzich on 5/27/17.
//  Copyright © 2017 Jacob Rakidzich. All rights reserved.
//

import UIKit

class MemeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var memeTableView: UITableView!

    var memes: [Meme]!
    
    
    // MARK: LifeCycle

    override func viewWillAppear(_ animated: Bool) {
        
        //find sent memes to display
        memes = (UIApplication.shared.delegate as! AppDelegate).memes
        
        //reload data
        memeTableView.reloadData()
        
        // if there are no memes send user to the meme editor to create one
        if memes.count < 1 {
            self.navigationController?.performSegue(withIdentifier: "defaultSegue", sender: self)
        }

    }
    
    
    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }

    // set image and text of cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memeCell", for: indexPath)
        cell.textLabel?.text = self.memes[indexPath.item].topText + " " + self.memes[indexPath.item].bottomText
        cell.imageView?.image = self.memes[indexPath.item].memedImage
        return cell
    }
    
    // display larger image in detail view
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        controller.image = memes[indexPath.item].memedImage
        self.navigationController!.pushViewController(controller, animated: true)

    }

}
