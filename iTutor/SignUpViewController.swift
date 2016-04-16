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
    var tutorGeoPointz = PFGeoPoint()
    override func viewDidLoad() {
        super.viewDidLoad()
       
       self.navigationController?.navigationBar.translucent = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .Done, target: self, action: #selector(doneTapped))
         navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: #selector(cancelTapped))
        
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
                    $0.options = ["Selangor","Kelantan","Terengganu","Sabah","Sarawak","Johor","Pahang","Kedah","Perlis","Wilayah","Pulau Pinang","Labuan","Putrajaya","Perak","Melaka"]
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
    func cancelTapped()
    {
        self.dismissViewControllerAnimated(true, completion: nil)
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
    func showAlert(title : String?,message : String?)
    {
        let alertz = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alertz.addAction(UIAlertAction(title: "OK", style: .Default) { _ in
            self.dismissViewControllerAnimated(true, completion: nil)})
        self.presentViewController(alertz, animated: true){}
    }
func doneTapped()
{
     let user = PFUser()
    if let userName = form.rowByTag("Emaillol")?.baseValue as? String
    {
        user.username = userName
    }
    else
    {
        self.showAlert("Error!", message: "Please enter your username!")
    }
    if let passWord = form.rowByTag("Passwordlol")?.baseValue as? String
    {
        user.password = passWord
    }
    else
    {
        self.showAlert("Error!", message: "Please enter your password!")
    }
    if let name = form.rowByTag("name")?.baseValue as? AnyObject
    {
        user["Name"] = name
    }
    else
    {
        
        self.showAlert("Error!", message: "Please enter your name!")
    }
    if let phoneno = form.rowByTag("phone")?.baseValue as? AnyObject
    {
        user["PhoneNo"] = phoneno
    }
    else
    {
        self.showAlert("Error!", message: "Please enter your phonenumber!")
    }
    if let gender = form.rowByTag("Gender")?.baseValue as? AnyObject
    {
        user["Gender"] = gender
    }
    else
    {
        self.showAlert("Error!", message: "Please enter your gender!")
    }
    if let pricingrange = form.rowByTag("Price")?.baseValue as? AnyObject
    {
        user["PricingRange"] = pricingrange
    }
    else
    {
        self.showAlert("Error!", message: "Please enter your pricing range!")
    }
    if let desc = form.rowByTag("Desc")?.baseValue as? AnyObject
    {
         user["Desc"] = desc
    }
    if let imagez = form.rowByTag("Image")?.baseValue as? UIImage
    {
        let imageData: NSData = UIImageJPEGRepresentation(imagez, 1.0)!
        let profphoto = PFFile(name: "profile_photo", data: imageData)
        user["ProfPhoto"] = profphoto
    }
    
    if let state =  form.rowByTag("State")?.baseValue as? AnyObject
    {
         user["State"] = state
    }
    else
    {
        
        self.showAlert("Error!", message: "Please enter your state!")
    }
    if let town = form.rowByTag("Town")?.baseValue as? AnyObject
    {
        user["Town"] = town
    }
    else
    {
        self.showAlert("Error!", message: "Please enter your town!")
    }
    
    let geocoder = CLGeocoder()
    geocoder.geocodeAddressString((form.rowByTag("Town")?.baseValue as? String)!){
        placemark, error in
        if let error = error {
            let alertz = UIAlertController(title: "Oops!", message:"\(error.localizedDescription)", preferredStyle: .Alert)
            alertz.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
            self.presentViewController(alertz, animated: true){}
            return
        }
        if let  placemark = placemark{
            user["StateGeopoint"] = 0
            if placemark.count > 0 {
                
                let placemark = placemark.first!
                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                self.tutorGeoPointz.latitude = coordinates.latitude
                self.tutorGeoPointz.longitude = coordinates.longitude
                print(self.tutorGeoPointz)
                
                user["StateGeopoint"] = PFGeoPoint(latitude: self.tutorGeoPointz.latitude, longitude: self.tutorGeoPointz.longitude)
        
            }
        }
        
        
    }
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
        
        
        if ((error) != nil) {
            self.showAlert("Oops", message: error?.localizedDescription)
            
        } else {
            self.showAlert("Yay", message: "Signed Up!")
            
        }
    })
       

    }
}



