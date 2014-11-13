//
//  DetailedViewController.swift
//  HypnoNerdSwift
//
//  Created by FRANCIS HUYNH on 11/11/14.
//  Copyright (c) 2014 Francis Huynh. All rights reserved.
//

import Foundation
import UIKit
class DetailedViewController  : UIViewController{
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

    
    override init() {
        super.init(nibName: "DetailedViewController", bundle: NSBundle.mainBundle())
    }

    convenience required init(coder aDecoder: NSCoder) {
        self.init()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        println("willAppear \(item)")
        name.text = item?.name
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
        item?.name = name.text
    }
}