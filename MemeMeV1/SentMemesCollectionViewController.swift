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
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(REUSABLE_CELL_ID, forIndexPath: indexPath) as! CustomMemeCell
        let meme = memes[indexPath.item]
        
       // cell.setText(meme.top, bottomString: meme.bottom)
        let imageView = UIImageView(image: meme.memedImaged)
        cell.backgroundView = imageView
        
        return cell
        
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // TODO:
    }
    
    
//    UICollectionView
//    collectionView(_:numberOfItemsInSection:)
//    collectionView(_:cellForItemAtIndexPath:)
//    collectionView(_:didSelectItemAtIndexPath:)
    

    
}