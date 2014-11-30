//
//  DetailedViewController.swift
//  HypnoNerdSwift
//
//  Created by FRANCIS HUYNH on 11/11/14.
//  Copyright (c) 2014 Francis Huynh. All rights reserved.
//

import Foundation
import UIKit
class DetailedViewController  : UIViewController , UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {
    weak var _item: Item?
    weak var item: Item? {
        get {
            return self._item
        }
        set(setItem) {
            println("Setting to \(setItem)")
            self.navigationItem.title = setItem?.name
            _item = setItem
        }
    }
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var toolbar: UIToolbar!
    
    override init() {
        super.init(nibName: "DetailedViewController", bundle: NSBundle.mainBundle())
    }

    convenience required init(coder aDecoder: NSCoder) {
        self.init()
    }
    
    @IBAction func backgroundTapped(sender: UIControl) {
        self.view.endEditing(true)
    }
    
    // MARK: View Life Cycle
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        println("willAppear \(item)")
        name.text = item?.name
        var itemKey = item?.itemKey
        self.imageView.image = ImageStore.sharedStore.imageForKey(itemKey!)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
        item?.name = name.text
    }
    
    @IBAction func takePicture(sender: AnyObject) {
        var picker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            picker.sourceType = UIImagePickerControllerSourceType.Camera
        } else {
            picker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        }
        picker.delegate = self
        self.presentViewController(picker, animated: true, completion: nil)
        
    }
    // MARK: ImagePicker
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        var image = info[UIImagePickerControllerOriginalImage] as UIImage
        ImageStore.sharedStore.setImage(image, forKey: (item?.itemKey)!)
        println(ImageStore.sharedStore.dictionary)
        self.imageView.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
   
    }
    // MARK: TextField
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}