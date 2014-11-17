//
//  NewsTableViewController.swift
//  APIDemo
//
//  Created by Alex Hilton on 11/14/14.
//  Copyright (c) 2014 Alex Hilton. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {
    var newsFeed = []
    
    var thumbQueue: NSOperationQueue?
    
    let hackerNews = "http://qingbin.sinaapp.com/api/lists?ntype=%E5%9B%BE%E7%89%87&pageNo=1&pagePer=10&list.htm"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsFeed = []
        thumbQueue = NSOperationQueue()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        tableView!.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: "loadNewsFeed", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refreshControl
        
        loadNewsFeed()
    }

    func loadNewsFeed() {
        refreshControl?.beginRefreshing()
        let loadURL = NSURL(string: hackerNews)
        let request = NSURLRequest(URL: loadURL!)
        let loadDataSourceQueue = NSOperationQueue()
        
        NSURLConnection.sendAsynchronousRequest(request, queue: loadDataSourceQueue) {
            response, data, error in
            if error != nil  {
                NSLog("error: %@", error)
                dispatch_async(dispatch_get_main_queue()) {
                    self.refreshControl!.endRefreshing()
                }
            } else {
                let json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                let newsDataSource = json["item"] as NSArray
                
                var currentNewsDataSource = NSMutableArray()
                for news: AnyObject in newsDataSource {
                    let newsItem = NewsItem(newsTitle: news["title"] as String, newsThumbUrl: news["thumb"] as String, newsID: news["id"] as String)
                    currentNewsDataSource.addObject(newsItem)
                    NSLog("got new item title \(newsItem.title), thumb \(newsItem.thumbUrl)")
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.newsFeed = currentNewsDataSource
                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                }
            }
        }
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
        return newsFeed.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
        let newsItem = newsFeed[indexPath.row] as NewsItem
        cell.textLabel.text = newsItem.title
        cell.imageView.contentMode = UIViewContentMode.ScaleAspectFit
        cell.textLabel.lineBreakMode = .ByWordWrapping
        cell.textLabel.numberOfLines = 0 // why this works?
        if let image = newsItem.thumb {
            cell.imageView.image = image
        } else {
            newsItem.fetchThumb(thumbQueue: thumbQueue!) {
                image in
                cell.imageView.image = image
                self.tableView?.reloadData()
            }
        }
        
        return cell
    }


    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

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
    
    // MARK: - Delegation
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let row = indexPath.row as Int
        let data = newsFeed[row] as NewsItem
        let webview = WebViewController()
        webview.detailID = data.id!
        navigationController?.pushViewController(webview, animated: true)
    }

}
