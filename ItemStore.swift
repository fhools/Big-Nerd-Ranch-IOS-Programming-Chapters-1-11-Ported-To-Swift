//
//  ItemStore.swift
//  HypnoNerdSwift
//
//  Created by FRANCIS HUYNH on 11/6/14.
//  Copyright (c) 2014 Francis Huynh. All rights reserved.
//

import Foundation

class ItemStore {
    var myItems : [Item] = []
    class var sharedStore : ItemStore {
        struct Static {
            static var instance: ItemStore?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = ItemStore()
        }
        
        return Static.instance!
    }
    
    func createItem(name aName: String) -> Item {
        var anItem = Item(name: aName)
        ItemStore.sharedStore.myItems.append(anItem)
        return anItem
    }
    
    func allItems() -> [Item] {
        return ItemStore.sharedStore.myItems
    }
    
    func removeItemAtIndex(index: Int) -> Item {
        var item = myItems[index]
        myItems.removeAtIndex(index)
        return item
    }
    
    func moveItemAtIndex(fromIndex:Int, toIndex:Int) {
        if fromIndex == toIndex {
            return
        }
        
        var item = removeItemAtIndex(fromIndex)
        myItems.insert(item, atIndex: toIndex)
    }
}
