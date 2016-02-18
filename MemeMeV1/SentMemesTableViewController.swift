//
//  SentMemesTableViewController.swift
//  MemeMeV1
//
//  Created by Robles on 16/2/16.
//  Copyright © 2016 Francisco Robles. All rights reserved.
//

import Foundation
import UIKit

class SentMemesTableViewController: UITableViewController {
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
//    UITableView
//    tableView(_:numberOfRowsInSection:)
//    tableView(_:cellForRowAtIndexPath:)
//    tableView(_:didSelectRowAtIndexPath:)
    
    
}