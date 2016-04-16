//
//  TutorTableViewController.swift
//  iTutor
//
//  Created by Sharifah Nazreen Ashraff ali on 06/03/2016.
//  Copyright © 2016 Syed Mohamed Ariff. All rights reserved.
//

import UIKit
import Parse
import Material
class TutorTableViewController: UITableViewController
{
    var Email : String?
    var State : String?
    var Subject : String?
    var Level : String?
    var Gender : String?
    var tutorobject : [PFObject] = []
    let cellIdentifier = "tutorcell"
    var objectidtopass : String?
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Tutors Available"
        CheckInternet.checkInternet(false, completionHandler:
            {(internet:Bool) -> Void in
                
                if (internet)
                {
                    let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
                    spinner.startAnimating()
                    if(self.Email != nil)
                    {
                      
                        if(self.State == nil && self.Level == nil && self.Subject == nil && self.Gender == nil)
                        {
                                    let query = PFUser.query()
                                    query?.whereKey("username", equalTo: self.Email!)
                                    query?.limit = 100
                                    query?.findObjectsInBackgroundWithBlock {
                                        (let tutors: [PFObject]?, error: NSError?) -> Void in
                                        
                                        if error == nil {
                                            // The find succeeded.
                                            
                                            print("Successfully retrieved\(tutors!.count) tutors.")
                                            if(tutors!.count>0)
                                            {
                                                if let tutors = tutors
                                                {
                                                    
                                                    for tutor in tutors
                                                    {
                                                        
                                                        self.tutorobject.append(tutor)
                                                    }
                                                }
                                                self.tableView.reloadData()
                                            }
                                            else
                                            {
                                                let alert = UIAlertController(title: "Oops!", message:"There are no available tutors right now that suit your preference.", preferredStyle: .Alert)
                                                alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
                                                self.presentViewController(alert, animated: true){}
                                            }
                                        }
                            }
                        }
                    }
                        if(self.State != nil && self.Subject != nil)
                        {
                            let query = PFUser.query()
                            query?.whereKey("username", equalTo: self.Email!)
                            query?.whereKey("State", equalTo: self.State!)
                            query?.whereKey("Subject", equalTo: self.Subject!)
                            query?.limit = 100
                            query?.findObjectsInBackgroundWithBlock {
                                (let tutors: [PFObject]?, error: NSError?) -> Void in
                                
                                if error == nil {
                                    // The find succeeded.
                                    
                                    print("Successfully retrieved \(tutors!.count) tutors.")
                                    if(tutors!.count>0)
                                    {
                                        if let tutors = tutors
                                        {
                                            
                                            for tutor in tutors
                                            {
                                                
                                                self.tutorobject.append(tutor)
                                            }
                                        }
                                        self.tableView.reloadData()
                                    }
                                    else
                                    {
                                        let alert = UIAlertController(title: "Oops!", message:"There are no available tutors right now that suit your preference.", preferredStyle: .Alert)
                                        alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
                                        self.presentViewController(alert, animated: true){}
                                    }
                                }
                            }
                    }
                        if(self.Level != nil && self.Gender != nil)
                        {
                            let query = PFUser.query()
                            query?.whereKey("username", equalTo: self.Email!)
                            query?.whereKey("Levels", equalTo: self.Level!)
                            query?.whereKey("Gender", equalTo: self.Gender!)
                            query?.limit = 100
                            query?.findObjectsInBackgroundWithBlock {
                                (let tutors: [PFObject]?, error: NSError?) -> Void in
                                
                                if error == nil {
                                    // The find succeeded.
                                    
                                    print("Successfully retrieved \(tutors!.count) tutors.")
                                    if(tutors!.count>0)
                                    {
                                        if let tutors = tutors
                                        {
                                            
                                            for tutor in tutors
                                            {
                                                
                                                self.tutorobject.append(tutor)
                                            }
                                        }
                                        self.tableView.reloadData()
                                    }
                                    else
                                    {
                                        let alert = UIAlertController(title: "Oops!", message:"There are no available tutors right now that suit your preference.", preferredStyle: .Alert)
                                        alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
                                        self.presentViewController(alert, animated: true){}
                                    }
                                }
                            }
                    }
                
                    if(self.Level != nil)
                    {
                        if(self.State == nil && self.Email == nil && self.Subject == nil && self.Gender == nil)
                        {
                            let query = PFUser.query()
                            query?.whereKey("Levels", equalTo: self.Level!)
                            query?.limit = 100
                            query?.findObjectsInBackgroundWithBlock {
                                (let tutors: [PFObject]?, error: NSError?) -> Void in
                                
                                if error == nil {
                                    // The find succeeded.
                                    
                                    print("Successfully retrieved\(tutors!.count) tutors.")
                                    if(tutors!.count>0)
                                    {
                                        if let tutors = tutors
                                        {
                                            
                                            for tutor in tutors
                                            {
                                                
                                                self.tutorobject.append(tutor)
                                            }
                                        }
                                        self.tableView.reloadData()
                                    }
                                    else
                                    {
                                        let alert = UIAlertController(title: "Oops!", message:"There are no available tutors right now that suit your preference.", preferredStyle: .Alert)
                                        alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
                                        self.presentViewController(alert, animated: true){}
                                    }
                                }
                            }
                        }
                       else if(self.Subject == nil && self.Gender == nil)
                        {
                            let query = PFUser.query()
                            query?.whereKey("username", equalTo: self.Email!)
                            query?.whereKey("Levels", equalTo: self.Level!)
                            query?.whereKey("State", equalTo: self.State!)
                            query?.limit = 100
                            query?.findObjectsInBackgroundWithBlock {
                                (let tutors: [PFObject]?, error: NSError?) -> Void in
                                
                                if error == nil {
                                    // The find succeeded.
                                    
                                    print("Successfully retrieved \(tutors!.count) tutors.")
                                    if(tutors!.count>0)
                                    {
                                        if let tutors = tutors
                                        {
                                            
                                            for tutor in tutors
                                            {
                                                
                                                self.tutorobject.append(tutor)
                                            }
                                        }
                                        self.tableView.reloadData()
                                    }
                                    else
                                    {
                                        let alert = UIAlertController(title: "Oops!", message:"There are no available tutors right now that suit your preference.", preferredStyle: .Alert)
                                        alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
                                        self.presentViewController(alert, animated: true){}
                                    }
                                }
                            }

                        }
                    }
                    if(self.Gender != nil)
                    {
                            if(self.State == nil && self.Level == nil && self.Subject == nil && self.Email == nil)
                        {
                            let query = PFUser.query()
                            query?.whereKey("Gender", equalTo: self.Gender!)
                            query?.limit = 100
                            query?.findObjectsInBackgroundWithBlock {
                                (let tutors: [PFObject]?, error: NSError?) -> Void in
                                
                                if error == nil {
                                    // The find succeeded.
                                    
                                    print("Successfully retrieved\(tutors!.count) tutors.")
                                    if(tutors!.count>0)
                                    {
                                        if let tutors = tutors
                                        {
                                            
                                            for tutor in tutors
                                            {
                                                
                                                self.tutorobject.append(tutor)
                                            }
                                        }
                                        self.tableView.reloadData()
                                    }
                                    else
                                    {
                                        let alert = UIAlertController(title: "Oops!", message:"There are no available tutors right now that suit your preference.", preferredStyle: .Alert)
                                        alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
                                        self.presentViewController(alert, animated: true){}
                                    }
                                }
                            }
                        }
                    }
                
                
                    if(self.Subject != nil)
                    {
                        if(self.State == nil && self.Level == nil && self.Gender == nil && self.Email == nil)
                        {
                            let query = PFUser.query()
                            query?.whereKey("Subjects", equalTo: self.Subject!)
                            query?.limit = 100
                            query?.findObjectsInBackgroundWithBlock {
                                (let tutors: [PFObject]?, error: NSError?) -> Void in
                                
                                if error == nil {
                                    // The find succeeded.
                                    
                                    print("Successfully retrieved \(tutors!.count) tutors.")
                                    if(tutors!.count>0)
                                    {
                                        if let tutors = tutors
                                        {
                                            
                                            for tutor in tutors
                                            {
                                                
                                                self.tutorobject.append(tutor)
                                            }
                                        }
                                        self.tableView.reloadData()
                                    }
                                    else
                                    {
                                        let alert = UIAlertController(title: "Oops!", message:"There are no available tutors right now that suit your preference.", preferredStyle: .Alert)
                                        alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
                                        self.presentViewController(alert, animated: true){}
                                    }
                                }
                            }
                        }
                    }
                    
                
                    if(self.State != nil)
                    {
                        let query = PFUser.query()
                        query?.whereKey("State", equalTo: self.State!)
                        query?.limit = 100
                        query?.findObjectsInBackgroundWithBlock {
                            (let tutors: [PFObject]?, error: NSError?) -> Void in
                            
                            if error == nil {
                                // The find succeeded.
                                
                                print("Successfully retrieved \(tutors!.count) tutors.")
                                if(tutors!.count>0)
                                {
                                    if let tutors = tutors
                                    {
                                        
                                        for tutor in tutors
                                        {
                                            
                                            self.tutorobject.append(tutor)
                                        }
                                    }
                                    self.tableView.reloadData()
                                }
                                else
                                {
                                    let alert = UIAlertController(title: "Oops!", message:"There are no available tutors right now that suit your preference.", preferredStyle: .Alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
                                    self.presentViewController(alert, animated: true){}
                                }
                                
                            }
                        }
                    }
                    if let subject = self.Subject
                    {
                        if let email = self.Email
                        {
                        if let level = self.Level
                        {
                            
                            if let state = self.State
                            {
                            if let gender = self.Gender
                            {
                                let query = PFUser.query()
                                 query?.whereKey("State", equalTo: state)
                                 query?.whereKey("username", equalTo: email)
                                query?.whereKey("Subjects", equalTo: subject)
                                query?.whereKey("Levels", equalTo: level)
                                query?.whereKey("Gender", equalTo: gender)
                                query?.limit = 100
                                query?.findObjectsInBackgroundWithBlock {
                                    (let tutors: [PFObject]?, error: NSError?) -> Void in
                                    
                                    if error == nil {
                                        // The find succeeded.
                                        
                                        print("Successfully retrieved \(tutors!.count)  tutors.")
                                        if(tutors!.count>0)
                                        {
                                            if let tutors = tutors
                                            {
                                                
                                                for tutor in tutors
                                                {
                                                    
                                                    self.tutorobject.append(tutor)
                                                }
                                            }
                                            self.tableView.reloadData()
                                        }
                                        else
                                        {
                                            let alert = UIAlertController(title: "Oops!", message:"There are no available tutors right now that suit your preference.", preferredStyle: .Alert)
                                            alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
                                            self.presentViewController(alert, animated: true){}
                                        }
                                        
                                    }
                                    else {
                                        // Log details of the failure
                                        print("Error: \(error!) \(error!.userInfo)")
                                        
                                    }
                                }
                            }
                        }
                            }
                    }
                        }
                }
                else
                {
                    print("Internet does not exist")
                    let alertz = UIAlertController(title: "Oops!", message:"No internet connection", preferredStyle: .Alert)
                    alertz.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
                    self.presentViewController(alertz, animated: true){}
                    
                }
        })
    }
                

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return tutorobject.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as? TutorTableViewCell
        let tutorcell = tutorobject[indexPath.row]
        cell?.tutorName.text = tutorcell["Name"] as? String
        cell!.tutorName.font = RobotoFont.regular
        cell!.backgroundColor = MaterialColor.clear
        if let tutorPic = tutorcell.valueForKey("ProfPhoto") as! PFFile!
        {
            tutorPic.getDataInBackgroundWithBlock({(imageData:NSData?,error:NSError?)->Void in
                if(error == nil)
                {
                    let image = UIImage(data: imageData!)
                    cell?.tutorimage.image = image
                    cell?.tutorimage.tintColor = MaterialColor.grey.lighten2
                    cell?.tutorimage!.layer.cornerRadius = (cell?.tutorimage.frame.size.height)!/2
                    cell?.tutorimage.layer.borderWidth = 0
                    cell?.tutorimage.clipsToBounds = true
                  
                }
            })
        }
        
        cell?.tutorDesc.text = tutorcell["Desc"] as? String
        cell!.tutorDesc.textColor = MaterialColor.grey.darken1
        cell!.tutorDesc.font = RobotoFont.regular
        cell?.tutorPriceRange.text = tutorcell["PricingRange"] as? String
        cell!.tutorPriceRange.textColor = MaterialColor.grey.darken2
        cell!.tutorPriceRange.font = RobotoFont.regular
        cell?.tutorlocation.text = tutorcell["State"] as? String
        cell!.tutorlocation.textColor = MaterialColor.grey.darken2
        cell!.tutorlocation.font = RobotoFont.regular
        return cell!
    }
    



    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "tutordetail"
        {
            if let tutordetail = segue.destinationViewController as? TutorProfileViewController
            {
                if let index = tableView.indexPathForSelectedRow?.row
                {
                    
                    let tutore = tutorobject[index] 
                    // set object id to the property in destination
                    tutordetail.objectid = tutore.objectId
                }
            }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        }
    }



}
