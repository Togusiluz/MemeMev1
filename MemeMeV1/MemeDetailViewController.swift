//
//  MemeDetailViewController.swift
//  MemeMeV1
//
//  Created by Robles on 21/2/16.
//  Copyright © 2016 Francisco Robles. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailViewController: UIViewController {
    
    
    
    var meme : Meme!
    
    @IBOutlet weak var imageMeme: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        imageMeme.image = meme.memedImaged
        imageMeme.contentMode = UIViewContentMode.ScaleAspectFit
    }
    
}
