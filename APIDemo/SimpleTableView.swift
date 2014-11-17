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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        setupRightButton()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.leftBarButtonItem = self.editButtonItem()
    }

    func initView() {
        tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func setupRightButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.Plain, target: self, action: "rightButtonClicked")
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
        return indexPath.row != 0
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
            // let's go back to where we were from
            navigationController?.popViewControllerAnimated(true)
            return
        }
        
        let alert = UIAlertView()
        alert.title = "Tip"
        alert.message = "What you order is \(fruits[indexPath.row]), will be served shortly."
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
