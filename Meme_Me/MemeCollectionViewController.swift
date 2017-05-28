//
//  MemeCollectionViewController.swift
//  Meme_Me
//
//  Created by JacobRakidzich on 5/27/17.
//  Copyright © 2017 Jacob Rakidzich. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MemeCollectionViewController: UICollectionViewController  {
    
    
    @IBOutlet var flowLayout: UICollectionViewFlowLayout!
   
    var memes: [Meme]!
    var cell: MemeCollectionViewCell!
    
    // MARK: LifeCycle

    override func viewWillAppear(_ animated: Bool) {
        
        // find memes to display
        memes = (UIApplication.shared.delegate as! AppDelegate).memes
        
        //flow layout
        flow()
        
        //reload
        collectionView?.reloadData()
    }
    
    
    
    // MARK: flow Layout
    
    func flow() {
        let space: CGFloat = 3.0
        let width = (view.frame.size.width - (2 * space)) / space
        let height = (view.frame.size.height - (2 * space)) / space
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    
    // MARK: COLLECTION VIEW
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    // set cell images to sent meme objects
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MemeCollectionViewCell
        cell.imageView?.image = self.memes[indexPath.item].memedImage
        return cell
    }
    // on click show larger image in detail view
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        controller.image = memes[indexPath.item].memedImage
        self.navigationController!.pushViewController(controller, animated: true)
    }
    
     
 
}
