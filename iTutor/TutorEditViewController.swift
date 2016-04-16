//
//  TutorEditViewController.swift
//  iTutor
//
//  Created by Sharifah Nazreen Ashraff ali on 18/03/2016.
//  Copyright © 2016 Syed Mohamed Ariff. All rights reserved.
//

import UIKit
import Eureka
import Parse
class TutorEditViewController: FormViewController
{
    let username:String? = nil
    let password:String? = nil
    var objectid:String?
    var currentuser = PFUser.currentUser()
    var tutorGeoPoint = PFGeoPoint()
    var imagez:UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tutor Edit"
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.toolbar.hidden = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .Done, target: self, action: #selector(doneTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .Done , target: self, action: #selector(logOut))
        var items: Array<UIBarButtonItem> = []
        let favorite = UIBarButtonItem(title: "Delete Account", style: .Plain, target: self, action: #selector(deleteAccount))
        items.append(favorite)
        self.setToolbarItems(items, animated: false)
        
        form +++ Section("Your Basic Details")
            <<< NameRow("name")
                {
                    $0.placeholder = "Your Name"
                    $0.value = currentuser?.objectForKey("Name") as? String
                }
            
            <<< EmailRow("Emaillol")
                {
                    
                    $0.placeholder = "Email"
                    $0.value = currentuser?.objectForKey("username") as? String
            }
            
            
            <<< PasswordRow("Passwordlol")
                {
                    $0.placeholder = "Password"
                    $0.value = currentuser?.objectForKey("password") as? String
            }
            <<< PhoneRow("phone")
                {
                    $0.placeholder = "Your phone no,Customers will see this"
                    $0.value = currentuser?.objectForKey("PhoneNo") as? String
            }
            <<< AlertRow<String>()
                {
                    $0.tag = "Gender"
                    $0.title = "Your Gender"
                    $0.selectorTitle = "Choose"
                    $0.options = ["Male","Female"]
                    $0.value = currentuser?.objectForKey("Gender") as? String
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
                    $0.value = currentuser?.objectForKey("Desc") as? String
            }
            <<< ImageRow()
                {
                    $0.tag = "Image"
                    $0.title = "Choose your profile pic"
                    let myvalue = $0
                    if let tutorPic = currentuser!.objectForKey("ProfPhoto") as! PFFile!
                    {
                        tutorPic.getDataInBackgroundWithBlock({(imageData:NSData?,error:NSError?)->Void in
                            if(error == nil)
                            {
                                let image = UIImage(data: imageData!)
                                print("YOOWAHH")
                                print(image)
                                print("***********")
                                self.imagez = image
                                print(self.imagez)
                                myvalue.value = image
                                
                               
                            }
                        })
                        myvalue.value = $0.value
                        
                    }
                    
                    
            }
            
            +++ Section("Select your Expertise")
            <<< MultipleSelectorRow<String>
                {
                    $0.tag = "Subjects"
                    $0.title = "Choose your Subjects"
                    $0.options = ["English","Mandarin","Maths","Science","Bahasa Malaysia"]
                    if let userSubjects = currentuser?.objectForKey("Subjects") as? [String] {
                        let subjects = Set(userSubjects)
                        $0.value = subjects
                    }

            
                    
                    
                }
                .onPresent { from, to in
                    to.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: from, action: #selector(self.multipleSelectorDone))
            }
            <<< MultipleSelectorRow<String>
                {
                    $0.tag = "Levels"
                    $0.title = "Choose your levels"
                    $0.options = ["Standard 1-3","Standard 4-6","Form 1-3","Form 4-5"]
                    if let userLevels = currentuser?.objectForKey("Levels") as? [String] {
                        let levels = Set(userLevels)
                        $0.value = levels
                    }
                    
                    
                }
                .onPresent { from, to in
                    to.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: from, action: #selector(self.multipleSelectorDone))}
            
            
            <<< AlertRow<String>() {
                $0.tag = "Price"
                $0.title = "Pricing Range"
                $0.selectorTitle = "Choose"
                $0.options = ["RM10-20", "RM20-30", "RM30-40", "RM40-50", "RM50-60", "RM60-70"]
                $0.value = currentuser?.objectForKey("PricingRange") as? String
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
                    $0.value = currentuser?.objectForKey("State") as? String

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
                    $0.value = currentuser?.objectForKey("Town") as? String

            }
            <<< MultipleSelectorRow<String>
                {
                    $0.tag = "Day"
                    $0.title = "Choose your available days"
                    $0.options = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
                    if let userDays = currentuser?.objectForKey("Days") as? [String] {
                        let days = Set(userDays)
                        $0.value = days
                    }

                    
                }
                .onPresent { from, to in
                    to.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: from, action: #selector(self.multipleSelectorDone))}
        
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
    func logOut()
    {
        if PFUser.currentUser() != nil {
           PFUser.logOut()
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.performSegueWithIdentifier("tutorlogin", sender: self)
            })
        }
        
    }
    
    func deleteAccount()
    {
        
        PFUser.currentUser()?.deleteInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
            
            if success {
                print("yoo")
                let alertController = UIAlertController(title: "Success!", message: "Now Please Login", preferredStyle: .Alert)
                
                let enterAppAction = UIAlertAction(title: "OK", style: .Default, handler: { (UIAlertAction) -> Void in
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("TutorLoginViewController")
                        self.presentViewController(viewController, animated: true, completion: nil)
                    })
                })
                
                alertController.addAction(enterAppAction)
                
                self.presentViewController(alertController, animated: true, completion: nil)
                
            }else {
                
                print(error)
                let alert = UIAlertController(title: "Oh no!", message:error?.localizedDescription , preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in
                    self.dismissViewControllerAnimated(true, completion: nil)})
                self.presentViewController(alert, animated: true){}
                
            }
        })
    }




    func doneTapped()
    {

        currentuser?.username = form.rowByTag("Emaillol")?.baseValue as? String
        currentuser?.password = form.rowByTag("Passwordlol")?.baseValue as? String
        currentuser?.setValue(form.rowByTag("name")?.baseValue as? AnyObject, forKey: "Name")
        currentuser?.setValue(form.rowByTag("phone")?.baseValue as? AnyObject, forKey: "PhoneNo")
        currentuser?.setValue(form.rowByTag("Gender")?.baseValue as? AnyObject, forKey: "Gender")
        currentuser?.setValue(form.rowByTag("Price")?.baseValue as? AnyObject, forKey: "PricingRange")
        currentuser?.setValue(form.rowByTag("Desc")?.baseValue as? AnyObject, forKey: "Desc")
        
        if let imagez = form.rowByTag("Image")?.baseValue as? UIImage
        {
            let imageData: NSData = UIImageJPEGRepresentation(imagez, 1.0)!
            let profphoto = PFFile(name: "profile_photo", data: imageData)
            currentuser?.setValue(profphoto, forKey: "ProfPhoto")
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
                if placemark.count > 0 {
                    let placemark = placemark.first!
                    let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                    self.tutorGeoPoint.latitude = coordinates.latitude
                    self.tutorGeoPoint.longitude = coordinates.longitude
                    print(self.tutorGeoPoint)
                    
                    self.currentuser?.setValue(self.tutorGeoPoint, forKey: "StateGeopoint")
                    
                }
            }
            
            
        }
        if let state = form.rowByTag("State")?.baseValue as? AnyObject
        {
            currentuser?.setValue(state, forKey: "State")
        }
        if let town = form.rowByTag("Town")?.baseValue as? AnyObject
        {
            currentuser?.setValue(town, forKey: "Town")
        }

        //converting NSArray to a Swift Set
        if let days = form.rowByTag("Day")?.baseValue as? Set<String>
        {
            let day = days.flatMap { $0 }
            currentuser?.setValue(day, forKey: "Days")
        }
        if let subjects = form.rowByTag("Subjects")?.baseValue as? Set<String>
        {
            let sub = subjects.flatMap { $0 }
            currentuser?.setValue(sub, forKey: "Subjects")
        }
        else
        {
            print("Error,There is no subjects chosen")
        }
        if let levels = form.rowByTag("Levels")?.baseValue as? Set<String>
        {
            let lev = levels.flatMap{ $0 }
            currentuser?.setValue(lev, forKey: "Levels")
        }
        else
        {
            print("Error,There no levels chosen")
        }
        
        currentuser?.saveInBackgroundWithBlock({ (succeed, error) -> Void in
            
          
            if ((error) != nil) {
                let alertz = UIAlertController(title: "Oops!", message:"\(error)", preferredStyle: .Alert)
                alertz.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
                self.presentViewController(alertz, animated: true){}
                
            } else {
                let alert = UIAlertController(title: "Yay!", message:"Edited the Data!", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in
                    self.dismissViewControllerAnimated(true, completion: nil)})
                self.presentViewController(alert, animated: true){}
            }
        })

       
        
        
        
    }
}
