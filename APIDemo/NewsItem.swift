//
//  XHNewsItem.swift
//  APIDemo
//
//  Created by Alex Hilton on 11/15/14.
//  Copyright (c) 2014 Alex Hilton. All rights reserved.
//

import Foundation
import UIKit

class NewsItem {
    var title: String?
    var thumbUrl: String?
    var id: String?
    var thumb: UIImage?
    
    init(newsTitle: String, newsThumbUrl: String, newsID: String) {
        self.title = newsTitle
        self.thumbUrl = newsThumbUrl
        self.id = newsID
    }
    
    func fetchThumb(#thumbQueue: NSOperationQueue, action: (image: UIImage)-> Void) {
        // load the url
        let request = NSURLRequest(URL: NSURL(string: thumbUrl!)!)
        NSURLConnection.sendAsynchronousRequest(request, queue: thumbQueue) {
            response, data, error in
            if error != nil {
                NSLog("Error is %@", error)
            } else {
                let image = UIImage(data: data)
                self.thumb = image
                dispatch_async(dispatch_get_main_queue()) {
                    action(image: image!)
                }
            }
        }
    }
}