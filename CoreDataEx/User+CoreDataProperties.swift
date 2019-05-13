//
//  User+CoreDataProperties.swift
//  CoreDataEx
//
//  Created by William Biondi on 13/05/2019.
//  Copyright © 2019 William Biondi. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String?
    @NSManaged public var surname: String?
    @NSManaged public var datebirth: String?
    @NSManaged public var phone: String?

}
