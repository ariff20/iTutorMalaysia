//
//  SignUpViewController.swift
//  iTutor
//
//  Created by Sharifah Nazreen Ashraff ali on 12/02/2016.
//  Copyright © 2016 Syed Mohamed Ariff. All rights reserved.
//

import UIKit
import Eureka
class SignUpViewController: FormViewController ,UINavigationBarDelegate{

   
    override func viewDidLoad() {
        super.viewDidLoad()
       /* let navigationBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        navigationBar.backgroundColor = UIColor.whiteColor()
        navigationBar.delegate = self;
        navigationBar.sizeToFit()
        
        // Create a navigation item with a title
        let navigationItem = UINavigationItem()
        navigationItem.title = "Sign Up Tutor"*/

         let logButton : UIBarButtonItem = UIBarButtonItem(title: "RightButtonTitle", style: UIBarButtonItemStyle.Done, target: self, action: "multipleSelectorDone")
       
        self.navigationController?.navigationBar.hidden = false
        
        self.navigationItem.rightBarButtonItem = logButton
       // navigationBar.items = [navigationItem]
       // self.view.addSubview(navigationBar)
         form +++ Section("Your Basic Details")
            <<< NameRow()
                {
                    $0.placeholder = "Your Name"
                }
            <<< EmailRow()
                {
                    $0.placeholder = "Email"
                }
            <<< PasswordRow()
                {
                    $0.placeholder = "Password"
                }
            <<< PhoneRow()
                {
                    $0.placeholder = "Your phone no,Customers will see this"
                }
            
            +++ Section("Select your Expertise")
            <<< MultipleSelectorRow<String>
                {
                    $0.title = "Choose your Subjects"
                    $0.options = ["English","Mandarin","Maths","Science","Bahasa Malaysia"]
                    
                }
                .onPresent { from, to in
                    to.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: from, action: "multipleSelectorDone:")
            }
            <<< MultipleSelectorRow<String>
                {
                    $0.title = "Choose your levels"
                    $0.options = ["Standard 1-3","Standard 4-6","Form 1-3","Form 4-5"]
                    
                }
                .onPresent { from, to in
                    to.navigationItem.rightBarButtonItem = logButton}
        
            <<< MultipleSelectorRow<String>
                {
                    $0.title = "Choose your pricing range"
                    $0.options = ["RM30-RM40","RM40-RM60","RM60-RM80","RM80-RM100"]
                }
                .onPresent { from, to in
                    to.navigationItem.rightBarButtonItem = logButton}
            +++ Section("Where can you teach?")
            <<< TextRow()
                {
                    $0.placeholder = "State"
                }
            <<< TextRow()
                {
                    $0.placeholder = "Town,ex:Near Shah Alam"
                }
        
        
        }
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(true)
        self.navigationController?.navigationBarHidden=false
        
    }
    
    func multipleSelectorDone(item:UIBarButtonItem)
    {
        print("YOLO")
        navigationController?.popViewControllerAnimated(true)
       //navigationController?.popToRootViewControllerAnimated(true)
    }
    
        // Do any additional setup after loading the view.
    }


    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


