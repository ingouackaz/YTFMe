//
//  HomeVC.swift
//  NativeProjectBootstrap
//
//  Created by ingouackaz on 08/10/2015.
//  Copyright © 2015 Fancy Pants Games. All rights reserved.
//

import UIKit
//import Crashlytics

class YTFHomeVC: UIViewController, HomeViewDelegate, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var backgroundImageView: UIImageView!

    @IBOutlet weak var profilImageView: UIImageView!
    @IBOutlet weak var titleImageView: UIImageView!

    var _firstAppear : Bool = true
    var _homeView : HomeView = HomeView()
    var _selectedButton : UIButton = UIButton()
    
    var _ytf : YTF = YTF.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // TODO: Move this method and customize the name and parameters to track your key metrics
        //       Use your own string attributes to track common values over time
        //       Use your own number attributes to track median value over time
      //  Answers.logCustomEventWithName("Video Played", customAttributes: ["Category":"Comedy", "Length":350])

        
        _homeView = (NSBundle.mainBundle().loadNibNamed("HomeView",
        owner: self, options: nil)[YTFDevice] as? HomeView)!
        _homeView.delegate = self
        self.view.addSubview(_homeView)

        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func homeButtonDidPressed(button: UIButton) {
        
        _selectedButton = button
        self.performSegueWithIdentifier(YTFIcon.allValues[button.tag].rawValue, sender: nil)

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

    }


    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    let transition = BubbleTransition()
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController
        controller.transitioningDelegate = self
        controller.modalPresentationStyle = .Custom
        
        
        if (segue.identifier == YTFIcon.Jeu.rawValue){
           /* let nc : CBNavigationController = segue.destinationViewController as! CBNavigationController
            
            
            if let _ = CBUser.currentUser {
                
                // loadHomeGame directly
                let storyboard : UIStoryboard = UIStoryboard(name: "YTFChuckGame", bundle: NSBundle.mainBundle())
                let vc : CBHomeVC = storyboard.instantiateViewControllerWithIdentifier("CBHomeVC") as! CBHomeVC
                
                nc.setViewControllers([vc], animated: true)
            }*/
        }
        

        
        
    }
    
    // MARK: UIViewControllerTransitioningDelegate
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .Present
        transition.startingPoint = _selectedButton.center
        transition.bubbleColor = UIColor.clearColor()
        return transition
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .Dismiss
        transition.startingPoint = _selectedButton.center
        transition.bubbleColor = UIColor.clearColor()

        return transition
    }
}
