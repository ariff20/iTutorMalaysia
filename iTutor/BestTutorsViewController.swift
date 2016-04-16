//
//  BestTutorsViewController.swift
//  iTutor
//
//  Created by Sharifah Nazreen Ashraff ali on 03/04/2016.
//  Copyright © 2016 Syed Mohamed Ariff. All rights reserved.
//

import UIKit
import Parse
import CoreLocation
import Material
class BestTutorsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate  {

    @IBOutlet var myTableView: UITableView!
    @IBOutlet var mySegmentedControl: UISegmentedControl!
    let manager = CLLocationManager()
     var refreshControl: UIRefreshControl!
    //The ratings powered tutor array
    var tutorbyratingObjects : [PFObject] = []
    //The location powered tutor array
    var tutorbystateObjects : [PFObject] = []
    var userloc : CLLocation?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tutors Available"
        self.navigationController?.setToolbarHidden(false, animated: true)
        var items: Array<UIBarButtonItem> = []
       
        let favorite = UIBarButtonItem(title: "Favorites", style: .Plain, target: self, action: #selector(touchPickImage))
        items.append(favorite)
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: #selector(refresh), forControlEvents: UIControlEvents.ValueChanged)
        self.myTableView.addSubview(self.refreshControl)
        self.setToolbarItems(items, animated: false)
        CheckInternet.checkInternet(false, completionHandler:
            {(internet:Bool) -> Void in
                
                if (internet)
                {
                    
                    let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
                    spinner.startAnimating()
                    let query = PFUser.query()
                    query?.limit = 100
                    query?.orderByDescending("Rating")
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
                                                    
                                                    self.tutorbyratingObjects.append(tutor)
                                                }
                                            }
                                            self.myTableView.reloadData()
                                        }
                                        else
                                        {
                                            let alert = UIAlertController(title: "Oops!", message:"There are no available tutors right now.", preferredStyle: .Alert)
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
                else
                {
                    print("Internet does not exist")
                    let alertz = UIAlertController(title: "Oops!", message:"No internet connection", preferredStyle: .Alert)
                    alertz.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
                    self.presentViewController(alertz, animated: true){}
                    
                }
        })


        
    }
    
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnValue = 0
        switch(mySegmentedControl.selectedSegmentIndex)
        {
        case 0:
            returnValue = self.tutorbyratingObjects.count
            break
        case 1:
            returnValue = self.tutorbystateObjects.count
            break
            
        default:
            break
        }
        return returnValue
    }
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let myCell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath) as? BestTutorsTableViewCell
        switch(mySegmentedControl.selectedSegmentIndex)
        {
        case 0:
            let tutorcell = tutorbyratingObjects[indexPath.row]
            myCell?.tutorname.text = tutorcell["Name"] as? String
            myCell?.tutorname.font = RobotoFont.regular
            myCell?.backgroundColor = MaterialColor.clear
            if let tutorPic = tutorcell.valueForKey("ProfPhoto") as! PFFile!
            {
                tutorPic.getDataInBackgroundWithBlock({(imageData:NSData?,error:NSError?)->Void in
                    if(error == nil)
                    {
                        let image = UIImage(data: imageData!)
                        myCell?.tutorimage.image = image
                        myCell?.tutorimage.tintColor = MaterialColor.grey.lighten2
                        myCell?.tutorimage!.layer.cornerRadius = (myCell?.tutorimage.frame.size.height)!/2
                        myCell?.tutorimage.layer.borderWidth = 0
                        myCell?.tutorimage.clipsToBounds = true
                        
                    }
                })
                
            }
            myCell?.tutordescription.text = tutorcell["Desc"] as? String
            myCell!.tutordescription.textColor = MaterialColor.grey.darken1
            myCell!.tutordescription.font = RobotoFont.regular
            myCell?.tutordescription.adjustsFontSizeToFitWidth = true
            myCell?.tutorpricerange.text = tutorcell["PricingRange"] as? String
            myCell!.tutorpricerange.textColor = MaterialColor.grey.darken1
            myCell!.tutorpricerange.font = RobotoFont.regular
            myCell?.tutorstate.text = tutorcell["State"] as? String
            myCell!.tutorstate.textColor = MaterialColor.grey.darken1
            myCell!.tutorstate.font = RobotoFont.regular
            if let rating = tutorcell["Rating"] as? Double
            {
                myCell!.tutorrating.rating = rating
            }
            
            

            break
        case 1:
            let tutorcell = tutorbyratingObjects[indexPath.row]
            myCell?.tutorname.text = tutorcell["Name"] as? String
            myCell?.tutorname.font = RobotoFont.regular
            myCell?.backgroundColor = MaterialColor.clear
            if let tutorPic = tutorcell.valueForKey("ProfPhoto") as! PFFile!
            {
                tutorPic.getDataInBackgroundWithBlock({(imageData:NSData?,error:NSError?)->Void in
                    if(error == nil)
                    {
                        let image = UIImage(data: imageData!)
                        myCell?.tutorimage.image = image
                        myCell?.tutorimage.tintColor = MaterialColor.grey.lighten2
                        myCell?.tutorimage!.layer.cornerRadius = (myCell?.tutorimage.frame.size.height)!/2
                        myCell?.tutorimage.layer.borderWidth = 0
                        myCell?.tutorimage.clipsToBounds = true
                        
                    }
                })
                
            }
            myCell?.tutordescription.text = tutorcell["Desc"] as? String
            myCell!.tutordescription.textColor = MaterialColor.grey.darken1
            myCell!.tutordescription.font = RobotoFont.regular
            myCell?.tutordescription.text = tutorcell["Desc"] as? String
            myCell!.tutordescription.textColor = MaterialColor.grey.darken1
            myCell!.tutordescription.font = RobotoFont.regular
            myCell?.tutorpricerange.text = tutorcell["PricingRange"] as? String
            myCell!.tutorpricerange.textColor = MaterialColor.grey.darken1
            myCell!.tutorpricerange.font = RobotoFont.regular
            myCell?.tutorstate.text = tutorcell["State"] as? String
            myCell!.tutorstate.textColor = MaterialColor.grey.darken1
            myCell!.tutorstate.font = RobotoFont.regular
            if let ratingz = tutorcell["Rating"] as? Double
            {
                myCell!.tutorrating.rating = ratingz
            }
            
            break
            
        default:
            break
        }
        return myCell!
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    func refresh(sender:AnyObject)
    {
        self.myTableView.reloadData()
        self.refreshControl.endRefreshing()
    }

 
    @IBAction func segmentedcontrolChanged(sender: AnyObject)
    {
        if(mySegmentedControl.selectedSegmentIndex == 0)
        {
            self.myTableView.reloadData()
        }
        else if(mySegmentedControl.selectedSegmentIndex == 1)
        {
            //Get the user's current location
            
            PFGeoPoint.geoPointForCurrentLocationInBackground {
                (geoPoint: PFGeoPoint?, error: NSError?) -> Void in
                if error == nil {
                    // do something with the new geoPoint
                    let query2 = PFUser.query()
                    if let geopoint = geoPoint
                    {
                        
                        query2?.whereKey("StateGeopoint", nearGeoPoint: geopoint, withinKilometers: 5000.00)
                        query2!.limit = 20
                        query2!.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
                            if let error = error
                            {
                                print(error)
                            }
                            else{
                                for object in objects!
                                {
                                    
                                    self.tutorbystateObjects.append(object)
                                }
                            }
                        }
                    }
                    
                }
            }
        }
    }
   

    @IBAction func cancelbuttonTapped(sender: AnyObject)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func touchPickImage()
    {
        self.performSegueWithIdentifier("tutorfavoritesz", sender: self)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "besttutordetail"
        {
            if let tutordetail = segue.destinationViewController as? TutorProfileViewController
            {
                if let index = myTableView.indexPathForSelectedRow?.row
                {
                    switch(mySegmentedControl.selectedSegmentIndex)
                    {
                    case 0:
                         let tutore = tutorbyratingObjects[index]
                          tutordetail.objectid = tutore.objectId
                        break
                    case 1:
                         let tutor = tutorbystateObjects[index]
                        tutordetail.objectid = tutor.objectId
                        break
                    default:
                        break
                        
                    }
                    
                    
                }
            }
            // Get the new view controller using segue.destinationViewController.
            // Pass the selected object to the new view controller.
        }
    }
    

}
