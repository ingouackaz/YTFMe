//
//  SocialNetworkTVC.swift
//  NativeProjectBootstrap
//
//  Created by ingouackaz on 20/10/2015.
//  Copyright © 2015 Fancy Pants Games. All rights reserved.
//

import UIKit

class SocialNetworkTVC: UITableViewController {


    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.titleView = UIImageView(image: UIImage(named: "reseauxsociaux-title"))
        
        UINavigationBar.appearance().translucent = true
        UINavigationBar.appearance().alpha = 0.7
        
   
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:YTFNavBarTitleColor]
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    @IBAction func socialButtonPressed(sender: AnyObject) {

        let button = sender as! UIButton
        
        
        switch button.tag {
        case 1:
            SocialNetwork.Twitter.openPage()
        case 2:
            SocialNetwork.Instagram.openPage()
        default:
            SocialNetwork.Facebook.openPage()
        }
        // SocialNetwork
       // button.tag
    }
    
    @IBAction func leaveAction(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
