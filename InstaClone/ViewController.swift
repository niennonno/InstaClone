//
//  ViewController.swift
//  InstaClone
//
//  Created by Aditya Vikram Godawat on 20/01/16.
//  Copyright © 2016 Wow Labz. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet var iUserName: UITextField!
    
    @IBOutlet var iPassword: UITextField!
   
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBAction func signUp(sender: AnyObject) {
        
        //checking if username and password are entered
        
        if iUserName.text == "" || iPassword == "" {
            
            let alert = UIAlertController(title: "Error in Form", message: "Enter a Username and Password", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                
                self.dismissViewControllerAnimated(true, completion: nil)
                
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
        
        } else {
            
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
            activityIndicator.center = self.view.center
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            activityIndicator.hidesWhenStopped = true
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            var user = PFUser()
            
            user.username = iUserName.text
            user.password = iPassword.text
            
            user.signUpInBackgroundWithBlock({ (success, error) -> Void in
                
                self.activityIndicator.stopAnimating()
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                
                if error == nil {
                    
                    
                    
                }
                
            })
            
            
        }
        
    }
 
    @IBAction func logIn(sender: AnyObject) {
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

