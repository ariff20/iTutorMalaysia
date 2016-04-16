//
//  TutorLogInViewController.swift
//  iTutor
//
//  Created by Sharifah Nazreen Ashraff ali on 10/02/2016.
//  Copyright © 2016 Syed Mohamed Ariff. All rights reserved.
//

import UIKit
import Material
import Parse
class TutorLogInViewController: UIViewController {

    
    @IBOutlet var signupbutton: FlatButton!
    @IBOutlet var forgotyourpassword: FlatButton!
    @IBOutlet var loginbutton: RaisedButton!
    @IBOutlet var passwordtextfield: TextField!
    @IBOutlet var emailtextfield: TextField!
    
    @IBOutlet var wholeview: UIView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.toolbar.hidden = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: #selector(cancelTapped))
        emailtextfield.placeholder = "Email"
        emailtextfield.font = RobotoFont.regularWithSize(20)
        emailtextfield.textColor = MaterialColor.black
        
        emailtextfield.titleLabel = UILabel()
        emailtextfield.titleLabel!.font = RobotoFont.mediumWithSize(12)
        emailtextfield.titleLabelColor = MaterialColor.grey.lighten1
        emailtextfield.titleLabelActiveColor = MaterialColor.blue.accent3
        emailtextfield.clearButtonMode = .WhileEditing
        passwordtextfield.placeholder = "Password"
        passwordtextfield.font = RobotoFont.regularWithSize(20)
       passwordtextfield.textColor = MaterialColor.black
        
        passwordtextfield.titleLabel = UILabel()
        passwordtextfield.secureTextEntry = true
        passwordtextfield.titleLabel!.font = RobotoFont.mediumWithSize(12)
        passwordtextfield.titleLabelColor = MaterialColor.grey.lighten1
        passwordtextfield.titleLabelActiveColor = MaterialColor.blue.accent3
       passwordtextfield.clearButtonMode = .WhileEditing
        loginbutton.setTitle("Login", forState: .Normal)
        loginbutton.titleLabel!.font = RobotoFont.mediumWithSize(24)
        forgotyourpassword.setTitle("Forgot your password?", forState: .Normal)
        forgotyourpassword.titleLabel!.font = RobotoFont.mediumWithSize(19)
        signupbutton.setTitle("Sign Up Now!", forState: .Normal)
        signupbutton.titleLabel!.font = RobotoFont.mediumWithSize(22)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func loginButton(sender: AnyObject)
    {
        if emailtextfield.text?.characters.count < 5 {
            let alertz = UIAlertController(title: "Invalid!", message:"Username must be greater than 5 characters", preferredStyle: .Alert)
            alertz.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
            self.presentViewController(alertz, animated: true){}
            
        } else if passwordtextfield.text?.characters.count < 8 {
            let alertz = UIAlertController(title: "Invalid!", message:"Password must be greater than 8 characters", preferredStyle: .Alert)
            alertz.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
            self.presentViewController(alertz, animated: true){}
            
        }
        else {
            CheckInternet.checkInternet(false, completionHandler:
                {(internet:Bool) -> Void in
                    
                    if (internet)
                    {
                        let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
                        spinner.startAnimating()
                        
                        // Send a request to login
                        PFUser.logInWithUsernameInBackground(self.emailtextfield.text!, password: self.passwordtextfield.text!, block: { (user, error) -> Void in
                            
                            // Stop the spinner
                            spinner.stopAnimating()
                            
                            if ((user) != nil) {
                                let alert = UIAlertController(title: "Success!", message:"Logged In", preferredStyle: .Alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in
                                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                        self.performSegueWithIdentifier("tutoredit", sender: self)
                                    })})
                                self.presentViewController(alert, animated: true){}
                                
                             
                                
                            } else {
                                if(error?.code == 101)
                                {
                                    let alertza = UIAlertController(title: "Oops!", message:"Invalid username or password!", preferredStyle: .Alert)
                                    alertza.addAction(UIAlertAction(title: "OK", style: .Default) { _ in})
                                    self.presentViewController(alertza, animated: true){}
                                }
                                else
                                {
                                    let alertz = UIAlertController(title: "Oops!", message:"\(error?.localizedDescription)", preferredStyle: .Alert)
                                    alertz.addAction(UIAlertAction(title: "OK", style: .Default) { _ in
                                        self.dismissViewControllerAnimated(true, completion: nil)})
                                    self.presentViewController(alertz, animated: true){}
                                }
                                
                            }
                        })
                    }
                    else
                    {
                        print("Internet does not exist")
                        dispatch_async(dispatch_get_main_queue(), { CheckInternet.reportLoginFailureWithShake(self.wholeview,controller: self) })
                        let alertz = UIAlertController(title: "Oops!", message:"No internet connection", preferredStyle: .Alert)
                        alertz.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
                        self.presentViewController(alertz, animated: true){}
                        
                    }
            })
    
        }
    }

    func cancelTapped()
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func signupButton(sender: AnyObject)
    {
        let vc = storyboard!.instantiateViewControllerWithIdentifier("TutorSignUp") as! SignUpViewController
        let navigationController = UINavigationController(rootViewController: vc)
        self.presentViewController(navigationController, animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    @IBAction func forgotyourPassword(sender: AnyObject)
    {
        self.performSegueWithIdentifier("forgotpassword", sender: self)
    }


}
