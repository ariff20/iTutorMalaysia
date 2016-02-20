//
//  SignUpViewController.swift
//  iTutor
//
//  Created by Sharifah Nazreen Ashraff ali on 12/02/2016.
//  Copyright © 2016 Syed Mohamed Ariff. All rights reserved.
//

import UIKit
import Eureka
import Parse
class SignUpViewController: FormViewController
{
    let username:String? = nil
    let password:String? = nil
    var tutorobject = PFObject(className: "User")
    override func viewDidLoad() {
        super.viewDidLoad()
       
       
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .Done, target: self, action: "doneTapped:")
        
         form +++ Section("Your Basic Details")
            <<< NameRow("name")
                {
                    $0.placeholder = "Your Name"
                    
                }
            
            <<< EmailRow("Emaillol")
                {
                    
                    $0.placeholder = "Email"
        
                }
            
        
            <<< PasswordRow("Passwordlol")
                {
                    $0.placeholder = "Password"
                }
            <<< PhoneRow("phone")
                {
                    $0.placeholder = "Your phone no,Customers will see this"
                }
            
            +++ Section("Select your Expertise")
            <<< MultipleSelectorRow<String>
                {
                    $0.tag = "Subjects"
                    $0.title = "Choose your Subjects"
                    $0.options = ["English","Mandarin","Maths","Science","Bahasa Malaysia"]
                    
                }
                .onPresent { from, to in
                    to.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: from, action: "multipleSelectorDone:")
            }
            <<< MultipleSelectorRow<String>
                {
                    $0.tag = "Levels"
                    $0.title = "Choose your levels"
                    $0.options = ["Standard 1-3","Standard 4-6","Form 1-3","Form 4-5"]
                    
                }
                .onPresent { from, to in
                    to.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: from, action: "multipleSelectorDone:")}
        
            
            <<< AlertRow<String>() {
                $0.tag = "Price"
                $0.title = "Pricing Range"
                $0.selectorTitle = "Choose"
                $0.options = ["RM10-20", "RM20-30", "RM30-40", "RM40-50", "RM50-60", "RM60-70"]
                }.onChange { row in
                    print(row.value)
                }
                .onPresent{ _, to in
                    to.view.tintColor = .purpleColor()
            }
            +++ Section("Where can you teach?")
            <<< TextRow()
                {
                    $0.placeholder = "State"
                }
            <<< TextRow()
                {
                    $0.placeholder = "Town,ex:Near Shah Alam"
                }

        }
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(true)
        self.navigationController?.navigationBarHidden=false
        
    }

    func multipleSelectorDone(item:UIBarButtonItem)
    {
        
        navigationController?.popViewControllerAnimated(true)
    }
    
        // Do any additional setup after loading the view.

func doneTapped(item:UIBarButtonItem)
{
    let user = PFUser()
    
    user.username = form.rowByTag("Emaillol")?.baseValue as! String
    user.password = form.rowByTag("Passwordlol")?.baseValue as! String
    user["Name"] = form.rowByTag("name")?.baseValue as! AnyObject
    user["PhoneNo"] = form.rowByTag("phone")?.baseValue as! AnyObject
    print(form.rowByTag("Subjects")?.baseValue)
    if let subjects = form.rowByTag("Subjects")?.baseValue
    {
        let arr = subjects.flatMap { $0 }
        user["Subjects"] = arr as! AnyObject
    }
    else
    {
        print("There is no subjects chosen")
    }
    
    
   
 
    
    
    
    user.signUpInBackgroundWithBlock({ (succeed, error) -> Void in
        
        // Stop the spinner
        //spinner.stopAnimating()
        if ((error) != nil) {
            var alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        } else {
            var alert = UIAlertView(title: "Success", message: "Signed Up", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }
    })
    

   

    }
}




    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


