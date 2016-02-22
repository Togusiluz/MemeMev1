//
//  ViewController.swift
//  MemeMeV1
//
//  Created by Robles on 13/1/16.
//  Copyright © 2016 Francisco Robles. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    @IBOutlet weak var imageChoosenView: UIImageView!
    
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var toolbar: UIToolbar!
    
    
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
        cancelButton.enabled = true
    }

    func resetTextField( textField:UITextField!){
        if let text = textField {
            text.delegate = self
            text.defaultTextAttributes = memeTextAttributes
            text.textAlignment = .Center
        }
    }
    

    @IBAction func takePhoto(sender: AnyObject) {
        getImage(UIImagePickerControllerSourceType.Camera)
    }
    
    @IBAction func PickImage(sender: AnyObject) {
        getImage(UIImagePickerControllerSourceType.PhotoLibrary)
    }
    
    func getImage (sourceType : UIImagePickerControllerSourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func shareMeme(sender: AnyObject) {
        let meme = createMemeImage()
        let controller = UIActivityViewController(activityItems: [meme], applicationActivities: nil)
        
        controller.completionWithItemsHandler = {(activityType, completed:Bool, returnedItems, error) in
            if completed {
               self.saveMeme()
            }
        }
        
        presentViewController(controller, animated: true, completion: nil)
    }
    
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageChoosenView.image = image
            imageChoosenView.contentMode = UIViewContentMode.ScaleAspectFit
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
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {

        view.frame.origin.y = 0
        
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
    
    @IBAction func cancelMeme(sender: AnyObject) {
        shareButton.enabled=false;
        cancelButton.enabled=false;
        imageChoosenView.image = nil;
        topText.text="TOP"
        bottomText.text="BOTTOM"
        
        dismissViewControllerAnimated(false, completion: nil)
        
    }
    
    func saveMeme(){
        let meme = Meme(upText: topText.text!, downText: bottomText.text!, originalImage: imageChoosenView.image!, memedImaged: createMemeImage())
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
        let sentMemesView: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SentMemesView") as UIViewController
        
        presentViewController(sentMemesView, animated: false, completion: nil)
    }
    
    func createMemeImage()->UIImage{
        navigationBar.hidden=true
        toolbar.hidden=true
        // Render view to an image
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        navigationBar.hidden=false
        toolbar.hidden=false
        
        return memedImage
    }
    
    
}

