//
//  PersistedPFObject.swift
//  iTutor
//
//  Created by Sharifah Nazreen Ashraff ali on 27/03/2016.
//  Copyright © 2016 Syed Mohamed Ariff. All rights reserved.
//

import Foundation
import CoreData
class PersistedPFObject:NSManagedObject {
    
    @NSManaged var name : String
    @NSManaged var  objectid : String
    @NSManaged var  phoneNo : String
    @NSManaged var  state : String
    @NSManaged var town : String
    @NSManaged var gender : String
  
}