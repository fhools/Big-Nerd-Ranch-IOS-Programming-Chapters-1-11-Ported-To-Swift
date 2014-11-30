//
//  Item.swift
//  HypnoNerdSwift
//
//  Created by FRANCIS HUYNH on 11/7/14.
//  Copyright (c) 2014 Francis Huynh. All rights reserved.
//

import Foundation

class Item : Equatable {
    var name: String?
    var itemKey = NSUUID().UUIDString
    init(name aName:String) {
        name = aName
    }
    
}

func ==(lhs: Item, rhs: Item) -> Bool {
    return lhs.name == rhs.name
}
