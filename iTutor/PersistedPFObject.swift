//
//  PersistedPFObject.swift
//  iTutor
//
//  Created by Sharifah Nazreen Ashraff ali on 27/03/2016.
//  Copyright © 2016 Syed Mohamed Ariff. All rights reserved.
//

import Foundation
class PersistedPFObject:NSObject, NSCoding {
    
    var name = ""
    var objectID = ""
    var  phoneNo = ""
    var  state = ""
    var town = ""
    var gender = ""
    
    struct Keys {
        static let objectID = "objectID"
        static let name = "name"
        static let phoneNo = "phoneNo"
        static let state = "state"
        static let town = "town"
        static let gender = "gender"
    }
    init(objectID: String, name: String, phoneNo: String, state: String,town:String,gender:String) {
        self.name = name
        self.objectID = objectID
        self.phoneNo = phoneNo
        self.state = state
        self.town = town
        self.gender = gender
    }
    func encodeWithCoder(archiver: NSCoder) {
        
        
        archiver.encodeObject(name, forKey: Keys.name)
        archiver.encodeObject(objectID, forKey: Keys.objectID)
        archiver.encodeObject(phoneNo, forKey: Keys.phoneNo)
        archiver.encodeObject(state, forKey: Keys.state)
        archiver.encodeObject(town, forKey: Keys.town)
        archiver.encodeObject(gender, forKey: Keys.gender)
    }
    required init(coder unarchiver: NSCoder) {
        super.init()
        
        // Unarchive the data, one property at a time
        name = unarchiver.decodeObjectForKey(Keys.name) as! String
        objectID = unarchiver.decodeObjectForKey(Keys.objectID) as! String
        phoneNo = unarchiver.decodeObjectForKey(Keys.phoneNo) as! String
        state = unarchiver.decodeObjectForKey(Keys.state) as! String
        town = unarchiver.decodeObjectForKey(Keys.town) as! String
        gender = unarchiver.decodeObjectForKey(Keys.gender) as! String
        
    }
}