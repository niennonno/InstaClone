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
    
    // MARK: - Global Variables
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var signupActive = true
    
    //MARK: - Outlets
    @IBOutlet var iUserName: UITextField!
    
    @IBOutlet var iPassword: UITextField!
    
    @IBOutlet var signupButton: UIButton!
    
    @IBOutlet var loginButton: UIButton!
    
    @IBOutlet var registrationLabel: UILabel!
    
    //MARK: - UserDefined Functions
    
    func displayAlert( title: String, message: String){
        
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - Actions
    
    @IBAction func signUp(sender: AnyObject) {
        
        //checking if username and password are entered
        if iUserName.text == "" || iPassword == "" {
            
            displayAlert("Error in Form", message: "Enter a Username and Password")
            
        } else {
            
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
            activityIndicator.center = self.view.center
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            activityIndicator.hidesWhenStopped = true
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            if signupActive == true {
                
                let user = PFUser()
                
                user.username = iUserName.text
                user.password = iPassword.text
                
                var errorMessage = "Please Try Later"
                
                user.signUpInBackgroundWithBlock({ (success, error) -> Void in
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    if error == nil {
                        
                        //SignUp Successful
                        
                        self.performSegueWithIdentifier("login", sender: self)
                        
                    } else {
                        
                        if let errorString = error!.userInfo["error"] as? String {
                            
                            errorMessage = errorString
                            
                            self.displayAlert("Failed Sign Up", message: errorMessage)
                            
                        }
                        
                    }
                    
                })
                
            } else {
                
                PFUser.logInWithUsernameInBackground(iUserName.text!, password: iPassword.text!, block: { (user, error) -> Void in
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    if user != nil {
                        
                        //Logged In!
                        
                        self.performSegueWithIdentifier("login", sender: self)
                        
                    } else {
                        
                        var errorMessage = "Please Try Later"
                        
                        if let errorString = error!.userInfo["error"] as? String {
                            
                            errorMessage = errorString
                            
                            self.displayAlert("Failed Login", message: errorMessage)
                        }
                        
                    }
                    
                })
                
            }
            
        }
        
    }
    
    @IBAction func logIn(sender: AnyObject) {
        
        if signupActive == true {
            
            signupButton.setTitle("Login", forState: UIControlState.Normal)
            
            registrationLabel.text = "New to the app?"
            
            loginButton.setTitle("Sign Up", forState: UIControlState.Normal)
            
            signupActive = false
            
        } else {
            
            signupButton.setTitle("Sign Up", forState: UIControlState.Normal)
            
            registrationLabel.text = "Returning Back?"
            
            loginButton.setTitle("Login", forState: UIControlState.Normal)
            
            signupActive = true
            
        }
        
    }
    
    
    //MARK:
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if PFUser.currentUser() != nil {
            
            self.performSegueWithIdentifier("login", sender: self)

            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

