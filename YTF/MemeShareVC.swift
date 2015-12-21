//
//  MemeShareVC.swift
//  NativeProjectBootstrap
//
//  Created by ingouackaz on 22/10/2015.
//  Copyright © 2015 Fancy Pants Games. All rights reserved.
//

import UIKit

class MemeShareVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.titleView = UIImageView(image: UIImage(named: "meme-title"))

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func leaveAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }

}
