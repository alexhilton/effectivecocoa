//
//  CollectionViewExample.swift
//  APIDemo
//
//  Created by Alex Hilton on 11/26/14.
//  Copyright (c) 2014 Alex Hilton. All rights reserved.
//

import UIKit

class CollectionViewExample: UICollectionViewController {
    let letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    override func viewDidLoad() {
        collectionView.bounds = CGRectInset(collectionView.frame, 10, 10)
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.registerClass(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cell")
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return letters.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as UICollectionViewCell
        cell.backgroundColor = UIColor.darkGrayColor()
        var label = UILabel(frame: CGRect(x: 7, y: 7, width: 36, height: 36))
        label.text = letters[indexPath.row]
        label.backgroundColor = UIColor.whiteColor()
        label.textAlignment = NSTextAlignment.Center
        cell.contentView.addSubview(label)
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        let alert = UIAlertView()
        alert.title = "Noti"
        alert.message = "You have select \(letters[indexPath.row]). Take Care"
        alert.addButtonWithTitle("Got it")
        alert.show()
    }
}
