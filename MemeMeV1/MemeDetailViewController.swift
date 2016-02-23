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
    var memeIndex : Int = -1
    
    @IBOutlet weak var imageMeme: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        imageMeme.image = meme.memedImaged
        imageMeme.contentMode = UIViewContentMode.ScaleAspectFit
    
    
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .Plain, target: self, action: "editMeme")
    }
    
    func editMeme(){
        let editMemeViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        editMemeViewController.editedMeme = meme
        editMemeViewController.editedIndex = memeIndex
        presentViewController(editMemeViewController, animated: true, completion: nil)
    }
    
    
}
