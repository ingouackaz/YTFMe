//
//  MemeVC.swift
//  NativeProjectBootstrap
//
//  Created by ingouackaz on 21/10/2015.
//  Copyright © 2015 Fancy Pants Games. All rights reserved.
//

import UIKit

class MemeVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate,UICollectionViewDelegateFlowLayout {

    
    @IBOutlet weak var titleImageView: UIImageView!

    @IBOutlet weak var collectionView: UICollectionView!

    
    @IBOutlet weak var upTextField: UITextField!

    
    @IBAction func endMemeAction(sender: AnyObject) {
        self.performSegueWithIdentifier("endMeme", sender: nil)
    }
    
    var _width : CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "meme-title"))

        
        self.upTextField.autocapitalizationType = .AllCharacters

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func leaveAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        _width  = (self.collectionView.frame.width / 3) - 20
        
        
        return CGSize(width: _width , height: _width)
    }
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! MemeCVCell

        cell.imageView.frame = CGRect(x: 0, y: 0, width: _width, height: _width)
        cell.needsUpdateConstraints()
        return cell
        
    }
}
