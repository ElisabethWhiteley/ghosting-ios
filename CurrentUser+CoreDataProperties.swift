//
//  CurrentUser+CoreDataProperties.swift
//  GreenEggs
//
//  Created by Elisabeth Whiteley on 08/09/2020.
//
//

import Foundation
import CoreData


extension CurrentUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrentUser> {
        return NSFetchRequest<CurrentUser>(entityName: "CurrentUser")
    }

    @NSManaged public var userId: String?

}

extension CurrentUser : Identifiable {

}
