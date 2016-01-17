//
//  ViewController.swift
//  MemeMeV1
//
//  Created by Robles on 13/1/16.
//  Copyright © 2016 Francisco Robles. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    @IBOutlet weak var imageChoosenView: UIImageView!
    
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var toolbar: UIToolbar!

    
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
    
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName: UIColor.whiteColor() ,
        NSFontAttributeName : UIFont(name: "Impact", size: 40)!,
        NSStrokeWidthAttributeName : -3
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetTextField(topText)
        resetTextField(bottomText)
        
        subscribeToKeyboardNotifications()
        
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        shareButton.enabled = false
        cancelButton.enabled = false
    }

    func resetTextField( textField:UITextField!){
        if let text = textField {
            text.delegate = self
            text.defaultTextAttributes = memeTextAttributes
            text.textAlignment = .Center
        }
    }
    

    @IBAction func takePhoto(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(imagePicker, animated: true, completion: nil)
    }

    @IBAction func shareMeme(sender: AnyObject) {
        let meme = saveMeme()
        let controller = UIActivityViewController(activityItems: [meme.memedImaged], applicationActivities: nil)
        presentViewController(controller, animated: true, completion: nil)
    }
    
    
    @IBAction func PickImage(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageChoosenView.image = image
        }
        shareButton.enabled = true
        cancelButton.enabled = true
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func clearTopText(sender: AnyObject) {
        topText.text=""
    }
    
    @IBAction func clearBottomText(sender: AnyObject) {
        bottomText.text=""
    }
    
    @IBAction func checkEmptyTopText(sender: AnyObject) {
        if let text = topText.text {
            if text == ""{
                topText.text="TOP"
                resetTextField(topText)
            }
        }
    }
    
    @IBAction func checkEmptyBottomText(sender: AnyObject) {
        if let text = bottomText.text {
            if text == ""{
                bottomText.text="BOTTOM"
                resetTextField(bottomText)
            }
        }
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if (bottomText.isFirstResponder()){
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if (bottomText.isFirstResponder()){
        view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func resetMeme(sender: AnyObject) {
        shareButton.enabled=false;
        cancelButton.enabled=false;
        imageChoosenView.image = nil;
        topText.text="TOP"
        bottomText.text="BOTTOM"
    }
    
    func saveMeme()->Meme{
        return Meme(upText: topText.text!, downText: bottomText.text!, image: imageChoosenView.image!, memedImage: createMemeImage())
    }
    
    func createMemeImage()->UIImage{
        navigationBar.hidden=true
        toolbar.hidden=true
        // Render view to an image
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // TODO:  Show toolbar and navbar
        navigationBar.hidden=false
        toolbar.hidden=false
        
        return memedImage
    }
    
    
}

