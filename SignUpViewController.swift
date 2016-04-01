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

    override func viewDidLoad() {
        super.viewDidLoad()
       
       
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .Done, target: self, action: #selector(doneTapped))
        
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
            <<< AlertRow<String>()
                {
                    $0.tag = "Gender"
                    $0.title = "Your Gender"
                    $0.selectorTitle = "Choose"
                    $0.options = ["Male","Female"]
            }.onChange { row in
                    print(row.value)
                }
                .onPresent{ _, to in
                    to.view.tintColor = .purpleColor()
            }
            <<< TextRow()
                {
                    $0.tag = "Desc"
                    $0.placeholder = "Description"
                 }
            <<< ImageRow()
                {
                    $0.tag = "Image"
                    $0.title = "Choose your profile pic"
                }
            
            +++ Section("Select your Expertise")
            <<< MultipleSelectorRow<String>
                {
                    $0.tag = "Subjects"
                    $0.title = "Choose your Subjects"
                    $0.options = ["English","Mandarin","Maths","Science","Bahasa Malaysia"]
                    
                }
                .onPresent { from, to in
                    to.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: from, action: #selector(self.multipleSelectorDone))
            }
            <<< MultipleSelectorRow<String>
                {
                    $0.tag = "Levels"
                    $0.title = "Choose your levels"
                    $0.options = ["Standard 1-3","Standard 4-6","Form 1-3","Form 4-5"]
                    
                }
                .onPresent { from, to in
                    to.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: from, action: #selector(self.multipleSelectorDone))}
        
            
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
            +++ Section("Where and when can you teach?")
            <<< AlertRow<String>()
                {
                    $0.tag = "State"
                    $0.title = "State"
                    $0.selectorTitle = "Choose"
                    $0.options = ["Selangor","Kelantan","Terengganu","Sabah","Sarawak","Johor","Pahang","Kedah","Perlis","Wilayah","Pulau Pinang","Labuan","Putrajaya"]
                }.onChange { row in
                    print(row.value)
                }
                .onPresent{ _, to in
                    to.view.tintColor = .purpleColor()
            }
            <<< TextRow()
                {
                    $0.tag = "Town"
                    $0.placeholder = "Town,ex:Shah Alam,Petaling Jaya"
                }
            <<< MultipleSelectorRow<String>
                {
                    $0.tag = "Day"
                    $0.title = "Choose your available days"
                    $0.options = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
                    
                }
                .onPresent { from, to in
                    to.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: from, action: #selector(self.multipleSelectorDone))}

        }
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(true)
        self.navigationController?.navigationBarHidden=false
        
    }

    func multipleSelectorDone()
    {
        
        navigationController?.popViewControllerAnimated(true)
    }
    
        // Do any additional setup after loading the view.

func doneTapped()
{
     let user = PFUser()
    
    user.username = form.rowByTag("Emaillol")?.baseValue as? String
    user.password = form.rowByTag("Passwordlol")?.baseValue as? String
    user["Name"] = form.rowByTag("name")?.baseValue as? AnyObject
    user["PhoneNo"] = form.rowByTag("phone")?.baseValue as? AnyObject
    user["Gender"] = form.rowByTag("Gender")?.baseValue as? AnyObject
    user["PricingRange"] = form.rowByTag("Price")?.baseValue as? AnyObject
    user["Desc"] = form.rowByTag("Desc")?.baseValue as? AnyObject
    let image = form.rowByTag("Image")?.baseValue as? UIImage
    let imageData: NSData = UIImageJPEGRepresentation(image!, 1.0)!
    let profphoto = PFFile(name: "profile_photo", data: imageData)
    user["ProfPhoto"] = profphoto
    user["State"] = form.rowByTag("State")?.baseValue as? AnyObject
    user["Town"] = form.rowByTag("Town")?.baseValue as? AnyObject
    if let days = form.rowByTag("Day")?.baseValue as? Set<String>
    {
        let day = days.flatMap { $0 }
        user["Days"] = day as AnyObject
    }
    if let subjects = form.rowByTag("Subjects")?.baseValue as? Set<String>
    {
        let sub = subjects.flatMap { $0 }
        user["Subjects"] = sub as AnyObject
        
    }
    else
    {
        print("Error,There is no subjects chosen")
    }
    if let levels = form.rowByTag("Levels")?.baseValue as? Set<String>
    {
        let lev = levels.flatMap{ $0 }
        user["Levels"] = lev as AnyObject
    }
    else
    {
        print("Error,There no levels chosen")
    }
    
    
   
 
    
    
    
    user.signUpInBackgroundWithBlock({ (succeed, error) -> Void in
        
        // Stop the spinner
        //spinner.stopAnimating()
        if ((error) != nil) {
            let alertz = UIAlertController(title: "Oops!", message:"\(error)", preferredStyle: .Alert)
            alertz.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
            self.presentViewController(alertz, animated: true){}
            
        } else {
            let alert = UIAlertController(title: "Yay!", message:"Signed Up", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in
                self.dismissViewControllerAnimated(true, completion: nil)})
            self.presentViewController(alert, animated: true){}
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


