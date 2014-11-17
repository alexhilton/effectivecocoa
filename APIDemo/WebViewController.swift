//
//  WebViewController.swift
//  APIDemo
//
//  Created by Alex Hilton on 11/15/14.
//  Copyright (c) 2014 Alex Hilton. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {
    var detailID = NSString()
    var detailURL = "http://qingbin.sinaapp.com/api/html/"
    var webview: UIWebView?
    var indicator: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        webview = UIWebView()
        webview!.frame = view.frame
        webview!.backgroundColor = UIColor.grayColor()
        webview!.delegate = self
        view.addSubview(webview!)
        indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        indicator?.center = CGPointMake(view.frame.size.width / 2, view.frame.size.height / 2)
        indicator?.color = UIColor.purpleColor()
        view.addSubview(indicator!)
        
        loadDataSource()
    }
    
    func loadDataSource() {
        var urlString = detailURL + "\(detailID).html"
        var url = NSURL(string: urlString)!
        var urlRequest = NSURLRequest(URL: url)
        webview!.loadRequest(urlRequest)
    }
    
    // MARK: - Webview delegate
    func webViewDidStartLoad(webView: UIWebView) {
        indicator?.startAnimating()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        indicator?.stopAnimating()
    }
}
