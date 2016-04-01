//
//  TutorFavoritesViewController.swift
//  iTutor
//
//  Created by Sharifah Nazreen Ashraff ali on 23/03/2016.
//  Copyright © 2016 Syed Mohamed Ariff. All rights reserved.
//

import Foundation
import UIKit
import Parse
import Material
class TutorFavoritesViewController:UITableViewController
{
    var pftutorarray : [PersistedPFObject] = []
    var cellidentifier = "favorite"
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if let array = NSKeyedUnarchiver.unarchiveObjectWithFile(self.appDelegate.tutorsFilePath) as? [PersistedPFObject] {
            pftutorarray = array
        
            print(pftutorarray)
        }
        else{
            print("array is nil")
        }
    
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return self.pftutorarray.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
       let cell = tableView.dequeueReusableCellWithIdentifier(cellidentifier, forIndexPath: indexPath) as? TutorFavoriteTableViewCell
        let favoritecell = pftutorarray[indexPath.row]
        cell?.tutorname.text = favoritecell.name
        cell?.tutorname.font = RobotoFont.regular
        cell!.backgroundColor = MaterialColor.clear
        cell?.tutorstate.numberOfLines = 2
        cell?.tutorprice.numberOfLines = 2
        cell?.tutorphoneno.text = favoritecell.phoneNo
        cell!.tutorphoneno.textColor = MaterialColor.grey.darken1
        cell!.tutorphoneno.font = RobotoFont.regular
        cell?.tutorprice.text = favoritecell.town 
        cell!.tutorprice.textColor = MaterialColor.grey.darken2
        cell!.tutorprice.font = RobotoFont.regular
        cell?.tutorstate.text = favoritecell.state
        cell!.tutorstate.textColor = MaterialColor.grey.darken2
        cell!.tutorstate.font = RobotoFont.regular
        cell?.tutorgender.text = favoritecell.gender
        cell!.tutorgender.textColor = MaterialColor.grey.darken2
        cell!.tutorgender.font = RobotoFont.regular
        return cell!
        
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
      self.performSegueWithIdentifier("favoritedetail", sender: self)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "favoritedetail"
        {
            if let tutordetail = segue.destinationViewController as? TutorProfileViewController
            {
                if let index = tableView.indexPathForSelectedRow?.row
                {
                    
                    let tutore = pftutorarray[index]
                    // set object id to the property in destination
                    tutordetail.objectid = tutore.objectID
                }
            }
            // Get the new view controller using segue.destinationViewController.
            // Pass the selected object to the new view controller.
        }
    }
   
}