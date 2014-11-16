//
//  WebViewController.swift
//  APIDemo
//
//  Created by Alex Hilton on 11/15/14.
//  Copyright (c) 2014 Alex Hilton. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    var detailID = NSString()
    var detailURL = "http://qingbin.sinaapp.com/api/html/"
    var webview: UIWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        webview = UIWebView()
        webview!.frame = view.frame
        webview!.backgroundColor = UIColor.grayColor()
        view.addSubview(webview!)
        
        loadDataSource()
    }
    
    func loadDataSource() {
        var urlString = detailURL + "\(detailID).html"
        var url = NSURL(string: urlString)!
        var urlRequest = NSURLRequest(URL: url)
        webview!.loadRequest(urlRequest)
    }
}
