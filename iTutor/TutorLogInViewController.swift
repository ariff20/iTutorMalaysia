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
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            var alert = UIAlertView(title: "Invalid", message: "Username must be greater than 5 characters", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        } else if passwordtextfield.text?.characters.count < 8 {
            var alert = UIAlertView(title: "Invalid", message: "Password must be greater than 8 characters", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        }
        else {
            // Run a spinner to show a task in progress
            var spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
            spinner.startAnimating()
            
            // Send a request to login
            PFUser.logInWithUsernameInBackground(emailtextfield.text!, password: passwordtextfield.text!, block: { (user, error) -> Void in
                
                // Stop the spinner
                spinner.stopAnimating()
                
                if ((user) != nil) {
                    var alert = UIAlertView(title: "Success", message: "Logged In", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Home") as! UIViewController
                        self.presentViewController(viewController, animated: true, completion: nil)
                    })
                    
                } else {
                    var alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                }
            })
        }
    }
    
    
    @IBAction func signupButton(sender: AnyObject)
    {
        let vc = storyboard!.instantiateViewControllerWithIdentifier("TutorSignUp") as! SignUpViewController
        let navigationController = UINavigationController(rootViewController: vc)
        self.presentViewController(navigationController, animated: true, completion: nil)
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
