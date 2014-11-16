//
//  TableViewExampleController.swift
//  APIDemo
//
//  Created by Alex Hilton on 11/14/14.
//  Copyright (c) 2014 Alex Hilton. All rights reserved.
//

import UIKit

class SimpleTableView: UITableViewController {
    var fruits = ["Go back", "Apple", "Pear", "Cherry", "Peach", "Orange"]
    var leftButton: UIButton?
    var rightButton: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        setupLeftButton()
        setupRightButton()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    func initView() {
        tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func setupLeftButton() {
        leftButton = UIButton.buttonWithType(UIButtonType.Custom) as? UIButton
        leftButton!.frame = CGRectMake(0, 0, 50, 40)
        leftButton?.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        leftButton?.setTitle("Edit", forState: UIControlState.Normal)
        leftButton!.tag = 100
        leftButton!.userInteractionEnabled = true
        leftButton?.addTarget(self, action: "leftButtonClicked", forControlEvents: UIControlEvents.TouchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton!)
    }
    
    func leftButtonClicked() {
        NSLog("Left bar button")
        if leftButton!.tag == 100 {
            tableView?.setEditing(true, animated: true)
            leftButton?.tag = 200
            leftButton?.setTitle("Done", forState: UIControlState.Normal)
            rightButton!.enabled = false
        } else {
            rightButton!.enabled = true
            tableView?.setEditing(false, animated: true)
            leftButton!.tag = 100
            leftButton?.setTitle("Edit", forState: UIControlState.Normal)
        }
    }
    
    func setupRightButton() {
        rightButton = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.Plain, target: self, action: "rightButtonClicked")
        navigationItem.rightBarButtonItem = rightButton
    }
    
    func rightButtonClicked() {
        var row = fruits.count
        var indexPath = NSIndexPath(forRow: row, inSection: 0)
        fruits.append("more apple")
        tableView?.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return fruits.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
        let row = indexPath.row as Int
        cell.textLabel.text = fruits[row]

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            fruits.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        // just rearrange the stuff in array
        let tmp: String? = fruits[fromIndexPath.row]
        fruits[fromIndexPath.row] = fruits[toIndexPath.row]
        fruits[toIndexPath.row] = tmp!
    }

    // MARK: - Delegation
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            navigationController?.popViewControllerAnimated(true)
            return
        }
        let alert = UIAlertView()
        alert.title = "Tip"
        alert.message = "What you choose is \(fruits[indexPath.row])"
        alert.addButtonWithTitle("OKay")
        alert.show()
    }
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
