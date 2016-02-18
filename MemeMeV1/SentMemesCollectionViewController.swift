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
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    
//    UICollectionView
//    collectionView(_:numberOfItemsInSection:)
//    collectionView(_:cellForItemAtIndexPath:)
//    collectionView(_:didSelectItemAtIndexPath:)
    

    
}