//
//  ForgotYourPasswordViewController.swift
//  iTutor
//
//  Created by Sharifah Nazreen Ashraff ali on 01/04/2016.
//  Copyright © 2016 Syed Mohamed Ariff. All rights reserved.
//

import Foundation
import UIKit
import Material
import Parse

class ForgotYourPasswordViewController : UIViewController
{
    
    @IBOutlet var resetpassword: RaisedButton!
    @IBOutlet var emailtextfield: TextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailtextfield.placeholder = "Your Email"
        emailtextfield.font = RobotoFont.regularWithSize(20)
        emailtextfield.textColor = MaterialColor.black
        
        emailtextfield.titleLabel = UILabel()
        emailtextfield.titleLabel!.font = RobotoFont.mediumWithSize(12)
        emailtextfield.titleLabelColor = MaterialColor.grey.lighten1
        emailtextfield.titleLabelActiveColor = MaterialColor.blue.accent3
        emailtextfield.clearButtonMode = .WhileEditing
        resetpassword.setTitle("Reset your password now!", forState: .Normal)
        resetpassword.backgroundColor = MaterialColor.blue.darken1
        resetpassword.titleLabel!.font = RobotoFont.mediumWithSize(13)
    }

    @IBAction func resetPassword(sender: AnyObject)
    {
        let email = self.emailtextfield.text
        
        let finalEmail = email!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        // Send a request to reset a password
        PFUser.requestPasswordResetForEmailInBackground(finalEmail)
        
        let alertz = UIAlertController(title:"Password Reset", message:"An email containing information on how to reset your password has been sent to " + finalEmail + ".", preferredStyle: .Alert)
        alertz.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
        self.presentViewController(alertz, animated: true){}
    }
    
}
