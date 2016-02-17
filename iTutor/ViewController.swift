//
//  ViewController.swift
//  iTutor
//
//  Created by Sharifah Nazreen Ashraff ali on 09/02/2016.
//  Copyright © 2016 Syed Mohamed Ariff. All rights reserved.
//

import UIKit
import Material
import Parse
class ViewController: UIViewController {

    
    @IBOutlet var studentbutton: FlatButton!

    @IBOutlet var tutorbutton: FlatButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        tutorbutton.setTitle("Tutor", forState: .Normal)
        studentbutton.setTitle("Student", forState: .Normal)
        
        // Add button to UIViewController.
       
    
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func tutortapped(sender: AnyObject)
    {
        performSegueWithIdentifier("Tutor", sender: self)
    }
    @IBAction func studenttapped(sender: FlatButton) {
    }
    
}

