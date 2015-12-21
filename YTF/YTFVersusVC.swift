//
//  YTFVersusVC.swift
//  YTFNativeBootstrap
//
//  Created by ingouackaz on 14/12/2015.
//  Copyright © 2015 Fancy Pants Games. All rights reserved.
//

import UIKit

class YTFVersusVC: UIViewController {

    
    @IBOutlet weak var playerTeamImageView: UIImageView!
    @IBOutlet weak var ennemyTeamImageView: UIImageView!

    @IBOutlet weak var bonus1: UIButton!
    @IBOutlet weak var bonus2: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // yourImageView.transform = CGAffineTransformMakeScale(-1, 1); //Flipped        
        
        bonus1.layer.masksToBounds = true
        bonus1.layer.cornerRadius = 23
        
        
        bonus2.layer.masksToBounds = true
        bonus2.layer.cornerRadius = 23
        
       /*
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "versus-bg-bleu")?.drawInRect(self.view.bounds)
        _ = UIGraphicsGetImageFromCurrentImageContext()
        */
        //self.view.backgroundColor = UIColor(patternImage: image)
        var  rotationAndPerspectiveTransformLeft : CATransform3D = CATransform3DIdentity;
        rotationAndPerspectiveTransformLeft.m34 = 1.0 / -400;
        rotationAndPerspectiveTransformLeft = CATransform3DRotate(rotationAndPerspectiveTransformLeft, 45.0 * CGFloat(M_PI) / 180.0, 0.0, 1.0, 0.0);
        
        
        
        var  rotationAndPerspectiveTransformRight : CATransform3D = CATransform3DIdentity;
        rotationAndPerspectiveTransformRight.m34 = 1.0 / -400;
        rotationAndPerspectiveTransformRight = CATransform3DRotate(rotationAndPerspectiveTransformRight, 45.0 * CGFloat(M_PI) / 180.0, 0.0, -1.0, 0.0);
        
        
        playerTeamImageView.layer.transform = rotationAndPerspectiveTransformLeft;
        ennemyTeamImageView.layer.transform = rotationAndPerspectiveTransformRight
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
