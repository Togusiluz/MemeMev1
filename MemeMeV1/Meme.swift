//
//  Meme.swift
//  MemeMeV1
//
//  Created by Robles on 17/1/16.
//  Copyright © 2016 Francisco Robles. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    var upText : String
    var downText : String
    var originalImage : UIImage
    var memedImaged : UIImage
    
    init(upText: String, downText:String,image: UIImage, memedImage: UIImage){
        self.upText=upText
        self.downText = downText
        self.originalImage = image
        self.memedImaged = memedImage
    }
    
}