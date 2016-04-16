//
//  TutorProfileViewController.swift
//  iTutor
//
//  Created by Sharifah Nazreen Ashraff ali on 11/03/2016.
//  Copyright © 2016 Syed Mohamed Ariff. All rights reserved.
//

import UIKit
import Parse
import MessageUI
import Material
import Cosmos
class TutorProfileViewController: UIViewController,MFMailComposeViewControllerDelegate {
    
    @IBOutlet var tutsubjects: UILabel!

    @IBOutlet var tutname: UILabel!
    @IBOutlet var tutimage: UIImageView!
    @IBOutlet var tutgender: UILabel!
    @IBOutlet var tutpricingrange: UILabel!
    @IBOutlet var tuttown: UILabel!
    @IBOutlet var tutstate: UILabel!
    @IBOutlet var tutdesc: UILabel!
    @IBOutlet var tutdays: UILabel!
    @IBOutlet var tutlevels: UILabel!
    @IBOutlet var scrollView: UIScrollView!
    //The variable for input
    @IBOutlet var ratinginput: CosmosView!
    //The variable for displaying the rating
    @IBOutlet var rating: CosmosView!
    //MenuView button
    private lazy var menuView: MenuView = MenuView()
    
    //The base size of the button
    private let baseViewSize: CGSize = CGSizeMake(56, 56)
    
    /// MenuView inset.
    private let menuViewInset: CGFloat = 16
    /// Default spacing size
    let spacing: CGFloat = 16
    /// Diameter for FabButtons.
    let diameter: CGFloat = 56
    /// Height for FlatButtons.
    let height: CGFloat = 36
    //The tutor's ObjectID
    var objectid : String?
    var tutor : PFObject?
    //Get the UUID of the device so that it would not be rating a tutor twice
    var uuidz = NSUUID().UUIDString
    //An array to save the tutors that have been rated by the student(device)
    var studenttutors : [String] = []
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    //Array of persisted pfobjects
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.toolbar.hidden = true
        prepareMenuViewExample()
        ratinginput.hidden = true
        ratinginput.didFinishTouchingCosmos = didFinishTouchingCosmos
    
        self.navigationController?.toolbarHidden = true
        CheckInternet.checkInternet(false, completionHandler:
            {(internet:Bool) -> Void in
                
                if (internet)
                {
                    let query = PFUser.query()
                    if let objectID = self.objectid {
                        
                        query!.getObjectInBackgroundWithId(objectID) {
                            (tutorobject: PFObject?, error: NSError?) -> Void in
                            if error == nil && tutorobject != nil
                            {
                                
                                let subjects : NSArray = tutorobject?.valueForKey("Subjects")   as! NSArray
                                let levels : NSArray = tutorobject?.valueForKey("Levels") as! NSArray
                                let days : NSArray = tutorobject?.valueForKey("Days") as! NSArray
                                self.tutsubjects.text = subjects.componentsJoinedByString(",")
                                self.tutlevels.text = levels.componentsJoinedByString(",")
                                self.tutdays.text = days.componentsJoinedByString(",")
                                self.tutpricingrange.text = tutorobject?.valueForKey("PricingRange") as? String
                                self.tutname.text = tutorobject?.valueForKey("Name") as? String
                                self.tuttown.text = tutorobject?.valueForKey("Town") as? String
                                self.tutstate.text = tutorobject?.valueForKey("State") as? String
                                self.tutgender.text = tutorobject?.valueForKey("Gender") as? String
                                if let desc = tutorobject?.valueForKey("Desc") as? String
                                {
                                  self.tutdesc.text = desc
                                }
                                self.tutor = tutorobject
                                if let ratingzz = tutorobject?.valueForKey("Rating") as? Double
                                {
                                    self.rating.rating = ratingzz
                                }
                                
                                
                                if let tutorPic = tutorobject?.valueForKey("ProfPhoto") as! PFFile!
                                {
                                    tutorPic.getDataInBackgroundWithBlock({(imageData:NSData?,error:NSError?)->Void in
                                        if(error == nil)
                                        {
                                            let image = UIImage(data: imageData!)
                                            self.tutimage.image = image
                                            self.tutimage.layer.cornerRadius = self.tutimage.frame.size.height/2
                                            self.tutimage.layer.borderWidth = 1
                                            self.tutimage.layer.borderColor = UIColor.blueColor().CGColor
                                            self.tutimage.clipsToBounds = true
                                            
                                        }
                                    })
                                }
                            } else {
                                print(error)
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
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func ratinginputTapped(sender: AnyObject)
    {
        if(ratinginput.hidden == true)
        {
            let query = PFQuery(className:"Student")
            query.findObjectsInBackgroundWithBlock {
                (studentobjects: [PFObject]?, error: NSError?) -> Void in
                
                if error == nil {
                    if let objects = studentobjects {
                        for object in objects {
                            let tutsratedunderonestudent : NSArray = object.valueForKey("Tutors") as! NSArray
                            print(self.uuidz)
                            if(tutsratedunderonestudent.containsObject((self.tutor?.objectId)!))
                            {
                                let alertz = UIAlertController(title: "Oops!", message:"You have already rated this tutor!", preferredStyle: .Alert)
                                alertz.addAction(UIAlertAction(title: "OK", style: .Default) { _ in
                                    self.ratinginput.hidden = true})
                                self.presentViewController(alertz, animated: true){}
                            }
                                // }
                            else
                            {
                                let animation: CATransition = CATransition()
                                animation.type = kCATransitionFade
                                animation.duration = 0.4
                                self.ratinginput.layer.addAnimation(animation, forKey: nil)
                                self.ratinginput.hidden = false
                            }
                            
                        }
                    }
                } else {
                    // Log details of the failure
                    print("Error: \(error!) \(error!.userInfo)")
                }
            }
        }
        else
        {
            let animation: CATransition = CATransition()
            animation.type = kCATransitionFade
            animation.duration = 0.4
            self.ratinginput.layer.addAnimation(animation, forKey: nil)
            self.ratinginput.hidden = true
        }
        
       
        
    }
   func callbutton(sender: AnyObject)
    {
        let phonenumber = self.tutor?.valueForKey("PhoneNo")
        print(self.tutor?.valueForKey("PhoneNo"))
        if let phonez = phonenumber
        {
            if let url = NSURL(string:"tel://\(phonez)")
            {
                 UIApplication.sharedApplication().openURL(url)
            }
            
        }
      
    }
    
     func emailbutton(sender: AnyObject)
    {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            let email = self.tutor?.valueForKey("username") as! String
            mail.setToRecipients([email])
            mail.setMessageBody("<p>Hey!Would like to contact you regarding tuition</p>", isHTML: true)
            
            presentViewController(mail, animated: true, completion: nil)
        } else {
            // show failure alert
        }
    }
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
    controller.dismissViewControllerAnimated(true, completion: nil)
    }
    internal func handleMenu() {
        if menuView.menu.opened {
            menuView.menu.close()
            (menuView.menu.views?.first as? MaterialButton)?.animate(MaterialAnimation.rotate(rotation: 0))
        } else {
            menuView.menu.open() { (v: UIView) in
                (v as? MaterialButton)?.pulse()
            }
            (menuView.menu.views?.first as? MaterialButton)?.animate(MaterialAnimation.rotate(rotation: 0.125))
        }
    }
    private func prepareMenuViewExample() {
        var image: UIImage? = UIImage(named: "plus")
        print(image)
        let btn1: FabButton = FabButton()
        btn1.setImage(image, forState: .Normal)
        btn1.setImage(image, forState: .Highlighted)
        btn1.addTarget(self, action: #selector(handleMenu), forControlEvents: .TouchUpInside)
        menuView.addSubview(btn1)
        
        image = UIImage(named: "phone")
        print(image)
        let btn2: FabButton = FabButton()
        btn2.setImage(image, forState: .Normal)
        btn2.setImage(image, forState: .Highlighted)
        btn2.addTarget(self, action: #selector(callbutton), forControlEvents: .TouchUpInside)
        menuView.addSubview(btn2)
        
        image = UIImage(named: "email")
        let btn3: FabButton = FabButton()
        btn3.setImage(image, forState: .Normal)
        btn3.setImage(image, forState: .Highlighted)
        btn3.addTarget(self, action: #selector(emailbutton), forControlEvents: .TouchUpInside)
        menuView.addSubview(btn3)
        
        image = UIImage(named: "favorite")
        let btn4: FabButton = FabButton()
        btn4.setImage(image, forState: .Normal)
        btn4.setImage(image, forState: .Highlighted)
        btn4.addTarget(self, action: #selector(addtoFavorites), forControlEvents: .TouchUpInside)
        menuView.addSubview(btn4)
        
        // Initialize the menu and setup the configuration options.
        menuView.menu.direction = .Up
        menuView.menu.baseViewSize = baseViewSize
        menuView.menu.views = [btn1, btn2, btn3, btn4]
        
        view.addSubview(menuView)
        menuView.translatesAutoresizingMaskIntoConstraints = false
        MaterialLayout.size(view, child: menuView, width: diameter, height: diameter)
    MaterialLayout.alignFromBottomRight(view, child: menuView, bottom: menuViewInset, right: menuViewInset)
    }
    private func didFinishTouchingCosmos(rating: Double)
    {
       let quary = PFUser.query()
        if let objectaidi = self.tutor?.objectId
        {
              quary?.getObjectInBackgroundWithId(objectaidi, block: { (tutorobject, errar) in
                if let input = self.ratinginput
                {
                    
                    self.studenttutors.append(objectaidi)
                    let student = PFObject(className: "Student")
                    student["UUID"] = self.uuidz
                    student["Tutors"] = self.studenttutors as AnyObject
                    student.saveEventually()
                    tutorobject?.incrementKey("NumberofRatings")
                    let noofrat = tutorobject!["NumberofRatings"] as! Double
                 
                    if let tots = tutorobject!["TotalRatings"]
                    {
                        
                        let total = tots as! Double
    
                        let totalratings = input.rating + total
                        PFCloud.callFunctionInBackground("totalUser", withParameters: ["userId": objectaidi, "numberofrating": tutorobject!["NumberofRatings"],"totalrating":totalratings]) {
                            (response: AnyObject?, error: NSError?) -> Void in
                            let averagerating = (totalratings/noofrat)
                            PFCloud.callFunctionInBackground("editUser", withParameters: ["userId": objectaidi, "rating": averagerating]) {
                                (response: AnyObject?, error: NSError?) -> Void in
                                let alert = UIAlertController(title: "Great!", message:"Rated this tutor succesfully!", preferredStyle: .Alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
                                self.presentViewController(alert, animated: true){}
                            }
                            
                        }
                        
                        print("There is total ratings")
                        
                    }
                    else
                    {
                         print("No total ratings")
                        PFCloud.callFunctionInBackground("totalUser", withParameters: ["userId": objectaidi, "numberofrating": tutorobject!["NumberofRatings"],"totalrating":input.rating]) {
                            (response: AnyObject?, error: NSError?) -> Void in
                            let averageratingz = (input.rating/noofrat)
                            PFCloud.callFunctionInBackground("editUser", withParameters: ["userId": objectaidi, "rating": averageratingz]) {
                                (response: AnyObject?, error: NSError?) -> Void in
                                let alerta = UIAlertController(title: "Great!", message:"Rated this tutor succesfully!", preferredStyle: .Alert)
                                alerta.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
                                self.presentViewController(alerta, animated: true){}
                            }
                            
                        }
                    }
                    

                }
               
              })
        }
      
        
        
    }
    

    func addtoFavorites(sender: AnyObject)
    {
           //Unwrap the objectID
            if let objectfavorite = self.tutor?.objectId
            {
                let queri = PFUser.query()
                queri!.getObjectInBackgroundWithId(objectfavorite) {
                    (tutorobject: PFObject?, error: NSError?) -> Void in
                    if error == nil && tutorobject != nil
                    {
                        //Create PersistedPFObject instance
                        let persist = PersistedPFObject(objectID: objectfavorite, name: tutorobject!["Name"] as! String, phoneNo: tutorobject!["PhoneNo"] as! String
                            , state: tutorobject!["State"] as! String
, town: tutorobject!["Town"] as! String, gender: tutorobject!["Gender"] as! String)
                       
                        //Append it to the array
                        
                        self.appDelegate.tutors.append(persist)
                        
                        let qualityOfServiceClass = QOS_CLASS_BACKGROUND
                        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
                        dispatch_async(backgroundQueue, {
                            
                            print("This is running on the background queue")
                            
                            NSKeyedArchiver.archiveRootObject(self.appDelegate.tutors, toFile:self.appDelegate.tutorsFilePath)
                            let alertz = UIAlertController(title: "Great!", message:"Added to favorites!", preferredStyle: .Alert)
                            alertz.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
                            self.presentViewController(alertz, animated: true){}
                            
                        })
                        
                    }
                    else
                    {
                        print("Error with PFQuery ")
                    }
                    
                }
                
        }
    }

}
