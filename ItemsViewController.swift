//
//  ViewController.swift
//  HypnoNerdSwift
//
//  Created by FRANCIS HUYNH on 11/6/14.
//  Copyright (c) 2014 Francis Huynh. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {

    @IBAction func addNewItem(sender: AnyObject?) {
        var i = ItemStore.sharedStore.allItems().count
        var item  = ItemStore.sharedStore.createItem(name: "new item \(i)")
        
        var index = find(ItemStore.sharedStore.allItems(), item)
        var newIndex = NSIndexPath(forRow: index!, inSection: 0)
        tableView.insertRowsAtIndexPaths([newIndex], withRowAnimation: UITableViewRowAnimation.Top)
        println("Insert new item at \(index)")
        
    }
    
    @IBAction func toggleEditingMode(sender: AnyObject?) {
        
        if (self.editing) {
            println("Toggling editing mode to false")
            sender?.setTitle("Edit", forState: UIControlState.Normal)
            self.setEditing(false, animated: true)
        } else {
            println("Toggling editing mode to true")
            sender?.setTitle("Done", forState: UIControlState.Normal)
            self.setEditing(true, animated: true)
        }
    }
    var _headerView: UIView?
    
    var headerView : UIView {
        get {
            if (_headerView == nil) {
                _headerView = NSBundle.mainBundle().loadNibNamed("HeaderView", owner: self, options: nil)![0] as? UIView
            }
            return _headerView!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        //tableView.tableHeaderView = headerView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    required init(coder aDecoder: NSCoder) {
        println("ItemsViewController coder")
        super.init(coder: aDecoder)
    }
    
    
    override init(style: UITableViewStyle) {
        println("ItemsViewController style")
        super.init(style: style)
        self.navigationItem.title = "Anthonys List"
    
        // SEL in swift are strings, if the selector takes an argument add ':' at the end
        var bbi = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addNewItem:")
        self.navigationItem.rightBarButtonItem = bbi
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
    }
    
    override  init() {
        println("ItemsViewController init")
        super.init(style: UITableViewStyle.Plain)
        
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        for i in 0..<20 {
            ItemStore.sharedStore.createItem(name:"Item #\(i+1)")
        }
//        tableView.reloadData()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemStore.sharedStore.allItems().count + 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath) as UITableViewCell
        if indexPath.row == ItemStore.sharedStore.allItems().count {
            cell.textLabel.text = "No Item here"
        } else {
            cell.textLabel.text = ItemStore.sharedStore.allItems()[indexPath.row].name!
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == ItemStore.sharedStore.allItems().count {
            return CGFloat(40)
        } else {
            return CGFloat(60)
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            println("Deleting row index \(indexPath.row)")
            println("Before: \(ItemStore.sharedStore.allItems().count)")
            ItemStore.sharedStore.removeItemAtIndex(indexPath.row)
            println("After: \(ItemStore.sharedStore.allItems().count)")
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }
    
    override func tableView(tableView: UITableView, targetIndexPathForMoveFromRowAtIndexPath sourceIndexPath: NSIndexPath, toProposedIndexPath proposedDestinationIndexPath: NSIndexPath) -> NSIndexPath {
        if sourceIndexPath.row >= ItemStore.sharedStore.allItems().count {
            println("not allowed\(sourceIndexPath)")
            return sourceIndexPath
        } else {
            println("got it \(proposedDestinationIndexPath)")
            return proposedDestinationIndexPath
        }
    }
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        println("Moving from \(sourceIndexPath) to \(destinationIndexPath)")
        ItemStore.sharedStore.moveItemAtIndex(sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    
    override func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String! {
        return "Delete It!"
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var dvc = DetailedViewController()
        dvc.item = ItemStore.sharedStore.allItems()[indexPath.row]
        println("Showing \(dvc.item?.name)")
        
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
}

