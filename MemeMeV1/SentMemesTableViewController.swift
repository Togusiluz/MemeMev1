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
    
    let REUSABLE_CELL = "MemeCell"
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCellWithIdentifier(REUSABLE_CELL, forIndexPath: indexPath) as UITableViewCell
        let meme = memes[indexPath.item]
        cell.textLabel?.text = meme.upText
        return cell;
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //
    }
    


    
//    UITableView
//    tableView(_:numberOfRowsInSection:)
//    tableView(_:cellForRowAtIndexPath:)
//    tableView(_:didSelectRowAtIndexPath:)
    
    
}