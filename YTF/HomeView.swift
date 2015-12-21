//
//  HomeView.swift
//  NativeProjectBootstrap
//
//  Created by ingouackaz on 27/10/2015.
//  Copyright © 2015 Fancy Pants Games. All rights reserved.
//

import UIKit


@objc protocol HomeViewDelegate {

    optional func homeButtonDidPressed(button:UIButton)
    
}




class HomeView: UIView {

    var delegate:HomeViewDelegate? = nil

    
    @IBAction func homeButtonPressed(sender: AnyObject) {

        let button = sender as! UIButton
        
        if (self.delegate != nil){
            self.delegate!.homeButtonDidPressed!(button)
        }
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
