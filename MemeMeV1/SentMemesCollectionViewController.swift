//
//  SentMemesCollectionViewController.swift
//  MemeMeV1
//
//  Created by Robles on 16/2/16.
//  Copyright © 2016 Francisco Robles. All rights reserved.
//

import Foundation
import UIKit

class SentMemesCollectionViewController: UICollectionViewController {
    
    let REUSABLE_CELL_ID = "MemeCollectionCell"
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    
    override func viewDidAppear(animated: Bool) {
        let space : CGFloat = 3.0
        let dimension = (self.view.frame.size.width - (2*space)) / 3.0

        flowLayout.minimumLineSpacing = space
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
    
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(memes.count)
        return memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(REUSABLE_CELL_ID, forIndexPath: indexPath) as! CustomMemeCell
        let meme = memes[indexPath.item]
        let imageView = UIImageView(image: meme.memedImaged)
        cell.backgroundView = imageView
        
        return cell
        
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let memeDetailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        memeDetailController.meme = self.memes[indexPath.row]
        self.navigationController!.pushViewController(memeDetailController, animated: true)
    }
    
    
//    UICollectionView
//    collectionView(_:numberOfItemsInSection:)
//    collectionView(_:cellForItemAtIndexPath:)
//    collectionView(_:didSelectItemAtIndexPath:)
    

    
}