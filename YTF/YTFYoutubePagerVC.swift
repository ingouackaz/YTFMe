//
//  ViewController.swift
//  PageMenuDemoStoryboard
//
//  Created by Niklas Fahl on 12/19/14.
//  Copyright (c) 2014 CAPS. All rights reserved.
//

import UIKit



class YTFYoutubePagerVC: UIViewController, CAPSPageMenuDelegate {
    
    var pageMenu : CAPSPageMenu?
    @IBOutlet weak var frameView: UIView!

    var firstAppear : Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.title = "PAGE MENU"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        // MARK: - Scroll menu setup
        
        // Initialize view controllers to display and place in array
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "yt-title"))
        
        UINavigationBar.appearance().translucent = true
        UINavigationBar.appearance().alpha = 0.7
        let controllers : [YTFYoutubeTVC] = self.loadChannelsPages()
        
        let itemWidth : CGFloat = self.view.frame.width / 2.5
        let parameters2: [CAPSPageMenuOption] = [
            .ScrollMenuBackgroundColor(UIColor.clearColor()),
            .ViewBackgroundColor(UIColor.clearColor()),
            .SelectionIndicatorColor(UIColor.blackColor()),
            .BottomMenuHairlineColor(UIColor(red: 20.0/255.0, green: 20.0/255.0, blue: 20.0/255.0, alpha: 0.1)),
            .MenuItemFont(UIFont(name: "HelveticaNeue", size: 13.0)!),
            .MenuHeight(40.0),
            .MenuItemWidth(itemWidth),
            .UnselectedMenuItemLabelColor(UIColor.lightGrayColor()),
            .SelectedMenuItemLabelColor(UIColor.blackColor()),
            .CenterMenuItems(true)
        ]
        
        
        // Initialize scroll menu
        pageMenu = CAPSPageMenu(viewControllers:controllers, frame: CGRectMake(0.0, 64.0, self.view.frame.width, self.view.frame.height), pageMenuOptions: parameters2)
        
        
        pageMenu?.centerMenuItems = true
        // Optional delegate
        pageMenu!.delegate = self
        
        self.view.addSubview(pageMenu!.view)
        
    }

    @IBAction func leaveAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    override func viewDidLayoutSubviews() {
        
        
        

        

    }
    
    
    func loadChannelsPages() -> [YTFYoutubeTVC] {
    
        var controllers : [YTFYoutubeTVC] = []
    
        for (_, channelId) in YTFYoutubeChannelsUrls.enumerate() {
        
            let controller : YTFYoutubeTVC = self.storyboard?.instantiateViewControllerWithIdentifier("YTFYoutubeTVC") as! YTFYoutubeTVC

            controller.channelId = channelId.values.first!
            controller.title = channelId.keys.first!
            controller.parentNavigationController = self.navigationController
            controllers.append(controller)
            
        }
        
        return controllers
    
    }

}


