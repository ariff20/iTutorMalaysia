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
import CoreData
class TutorFavoritesViewController:UITableViewController
{
    
    var favoritetutors : [AnyObject] = []
    var cellidentifier = "favorite"
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Your Favorite Tutors"
        self.refreshControl?.addTarget(self, action: #selector(handlerefresh), forControlEvents: UIControlEvents.ValueChanged)
        let managedContext = appDelegate.managedObjectContext
        let request = NSFetchRequest(entityName: "PFObjectEntity")
        request.returnsObjectsAsFaults = false
        do
        {
           let results = try managedContext.executeFetchRequest(request)
            if(results.count > 0)
            {
               print("\(results.count) found!")
               favoritetutors = results
            }
            else
            {
                print("No results found")
            }
        }
        catch
        {
            print("Error with fetching the favorites.")
        }
    
    }
    func handlerefresh(refreshControl: UIRefreshControl)
    {
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return self.favoritetutors.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
       let cell = tableView.dequeueReusableCellWithIdentifier(cellidentifier, forIndexPath: indexPath) as? TutorFavoriteTableViewCell
        let favoritecell = favoritetutors[indexPath.row]
        
        cell?.tutorname.text = favoritecell.valueForKey("name") as? String
        cell?.tutorname.font = RobotoFont.regular
        cell!.backgroundColor = MaterialColor.clear
        cell?.tutorstate.numberOfLines = 2
        cell?.tutorprice.numberOfLines = 2
        cell?.tutorphoneno.text = favoritecell.valueForKey("phoneNo") as? String
        cell!.tutorphoneno.textColor = MaterialColor.grey.darken1
        cell!.tutorphoneno.font = RobotoFont.regular
        cell?.tutorprice.text = favoritecell.valueForKey("town") as? String
        cell!.tutorprice.textColor = MaterialColor.grey.darken2
        cell!.tutorprice.font = RobotoFont.regular
        cell?.tutorstate.text = favoritecell.valueForKey("state") as? String
        cell!.tutorstate.textColor = MaterialColor.grey.darken2
        cell!.tutorstate.font = RobotoFont.regular
        cell?.tutorgender.text = favoritecell.valueForKey("gender") as? String
        cell!.tutorgender.textColor = MaterialColor.grey.darken2
        cell!.tutorgender.font = RobotoFont.regular
        return cell!
        
    }
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let managedContextz = appDelegate.managedObjectContext
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            managedContextz.deleteObject(favoritetutors[indexPath.row] as! NSManagedObject)
            favoritetutors.removeAtIndex(indexPath.row)
            do
            {
                try managedContextz.save()
            }
            catch
            {
                print("Error with the saving the context..")
            }
            self.tableView.reloadData()
        }
    }
    override func viewWillAppear(animated: Bool) {
        let managedContext = appDelegate.managedObjectContext
         let fetchrequest = NSFetchRequest(entityName: "PFObjectEntity")
        do
        {
            let results = try managedContext.executeFetchRequest(fetchrequest)
            favoritetutors = results as! [NSManagedObject]
        }
        catch
        {
            print("Error with the fetch request..")
        }
    }
  
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        //segue to the profile screen
      self.performSegueWithIdentifier("favoritedetail", sender: self)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "favoritedetail"
        {
            CheckInternet.checkInternet(false, completionHandler:
                {(internet:Bool) -> Void in
                    
                    if(internet)
                    {
                        if let tutordetail = segue.destinationViewController as? TutorProfileViewController
                        {
                            if let index = self.tableView.indexPathForSelectedRow?.row
                            {
                                
                                let tutore = self.favoritetutors[index]
                                // set object id to the property in destination
                                tutordetail.objectid = tutore.valueForKey("objectid") as? String
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
    }
   
}