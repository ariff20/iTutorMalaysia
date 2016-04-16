//
//  StudentQueryViewController.swift
//  iTutor
//
//  Created by Sharifah Nazreen Ashraff ali on 04/03/2016.
//  Copyright © 2016 Syed Mohamed Ariff. All rights reserved.
//

import UIKit
import Eureka
import Parse
class StudentQueryViewController: FormViewController
{
    
    @IBOutlet var tableview: UITableView!
    var Subject : String?
    var Level : String?
    var Gender : String?
    var Email : String?
    
    var State : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.toolbarHidden = false
        self.navigationController?.navigationBar.translucent = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .Done, target: self, action: #selector(doneTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: #selector(cancelTapped))
        var items: Array<UIBarButtonItem> = []
        let favorite = UIBarButtonItem(title: "Favorites", style: .Plain, target: self, action: #selector(touchPickImage))
        let reset =  UIBarButtonItem(title: "Reset", style: .Plain, target: self, action: #selector(resetValues))
        items.append(favorite)
        items.append(flexibleSpace)
        items.append(reset)
        self.setToolbarItems(items, animated: false)
        form +++ Section("Search a tutor with a specific field!")
            
            <<< AlertRow<String>()
                {
                    $0.tag = "Subject"
                    $0.title = "Subject"
                    $0.selectorTitle = "Choose"
                    $0.options = ["English","Mandarin","Maths","Science","Bahasa Malaysia"]
                }.onChange { row in
                    print(row.value)
                }
                .onPresent{ _, to in
                    to.view.tintColor = .purpleColor()
        }
            <<< AlertRow<String>()
                {
                    $0.tag = "Level"
                    $0.title = "Level"
                    $0.selectorTitle = "Choose"
                    $0.options = ["Standard 1-3","Standard 4-6","Form 1-3","Form 4-5"]
                }.onChange { row in
                    print(row.value)
                }
                .onPresent{ _, to in
                    to.view.tintColor = .purpleColor()
        }
            <<< EmailRow("Emaillol")
            {
                
                $0.placeholder = "Email"
                
            }
            
            <<< AlertRow<String>()
                {
                    $0.tag = "Gender"
                    $0.title = "Gender"
                    $0.selectorTitle = "Choose"
                    $0.options = ["Male","Female"]
                }.onChange { row in
                    print(row.value)
                }
                .onPresent{ _, to in
                    to.view.tintColor = .purpleColor()
        }
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
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func doneTapped()
    {
        self.performSegueWithIdentifier("Tutortable", sender: self)
        
    }
    

    func cancelTapped()
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func touchPickImage()
    {
        self.performSegueWithIdentifier("tutorfavorites", sender: self)
    }
    func resetValues()
    {
       form.rowByTag("Emaillol")?.baseValue = nil
       form.rowByTag("State")?.baseValue = nil
        form.rowByTag("Subject")?.baseValue = nil
       form.rowByTag("Level")?.baseValue = nil
        form.rowByTag("Gender")?.baseValue = nil
        
        form.rowByTag("State")?.reload()
        form.rowByTag("Emaillol")?.reload()
        form.rowByTag("Level")?.reload()
         form.rowByTag("Gender")?.reload()
        form.rowByTag("Subject")?.reload()
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "Tutortable"
        {
            if let tutorTable = segue.destinationViewController as? TutorTableViewController
            {
                self.Email = form.rowByTag("Emaillol")?.baseValue as? String
                self.State = form.rowByTag("State")?.baseValue as? String
                self.Subject = form.rowByTag("Subject")?.baseValue as? String
                self.Level = form.rowByTag("Level")?.baseValue as? String
                self.Gender = form.rowByTag("Gender")?.baseValue as? String
                
                tutorTable.Subject = Subject
                tutorTable.Level = Level
                tutorTable.Gender = Gender
                tutorTable.Email = Email
                tutorTable.State = State
                
            }
            else
            {
                print("Data is not passed.destination vc is not tutortablevc")
            }
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
