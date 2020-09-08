//
//  User+CoreDataProperties.swift
//  GreenEggs
//
//  Created by Elisabeth Whiteley on 08/09/2020.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String?
    @NSManaged public var theme: String?
    @NSManaged public var userId: Int16

}

extension User : Identifiable {

}
