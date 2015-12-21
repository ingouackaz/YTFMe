//
//  SoundCVC.swift
//  NativeProjectBootstrap
//
//  Created by ingouackaz on 13/10/2015.
//  Copyright © 2015 Fancy Pants Games. All rights reserved.
//

import UIKit
import AVFoundation

class YTFSoundCVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var _audioPlayer : AVAudioPlayer  = AVAudioPlayer()
    override func viewDidLoad() {
        super.viewDidLoad()

        

        self.navigationItem.titleView = UIImageView(image: UIImage(named: "sons-title")) 
        
        UINavigationBar.appearance().translucent = true
        UINavigationBar.appearance().alpha = 0.7
        

        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:YTFNavBarTitleColor]
        //self.collectionView!.backgroundView = UIImageView(image:  UIImage(named: "fond-jaune")!)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return YTFSoundsName.count
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let cellWidth : CGFloat = (self.view.frame.width / 3) - 20
        
        
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! AudioCVCell
        cell.contentView.frame = cell.bounds

        
        let name = YTFImgSoundNamePrefix + String(indexPath.row)
        let img = UIImage(named: name)
        
       // cell.contentView.backgroundColor = UIColor(patternImage: img!)
        cell.imageView.image = img
        cell.titleLabel.text = YTFSoundsName[indexPath.row]
        // Configure the cell
    
        return cell
    }

    
    @IBAction func backAction(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        
       // var nameSound = YTFSoundsName[indexPath.row]
        
        let name = "sound" + String(indexPath.row + 1)

        print("name \(name)")
        let url = NSBundle.mainBundle().pathForResource(name, ofType: "wav")
        
        _audioPlayer = try! AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: url!))
        _audioPlayer.play()
    }
    // MARK: UICollectionViewDelegate



}
