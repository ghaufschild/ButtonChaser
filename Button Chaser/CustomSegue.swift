//
//  CustomSegue.swift
//  Button Chaser
//
//  Created by Garrett Haufschild on 12/15/15.
//  Copyright © 2015 Swag Productions. All rights reserved.
//

import UIKit

class CustomSegue: UIStoryboardSegue {
    
    override func perform() {
        let firstVCView = self.sourceViewController.view as UIView!             //View of source view controller
        let secondVCView = self.destinationViewController.view as UIView!       //View of destination view controller
        
        secondVCView.alpha = 0              //Make sure second view is invisible
        
        let window = UIApplication.sharedApplication().keyWindow        //Used to have both views on at the same time
        window?.insertSubview(secondVCView, aboveSubview: firstVCView)  //Put (invisible) second view on first view
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            firstVCView.alpha = 0       //First view turns invisible
            secondVCView.alpha = 1      //Second view becomes visible
            })
            { (Finished) -> Void in
                self.sourceViewController.presentViewController(self.destinationViewController as UIViewController,
                    animated: false,
                    completion: nil)    //Go to next view controller
        }
    }
}
