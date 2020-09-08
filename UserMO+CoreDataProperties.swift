//
//  UserMO+CoreDataProperties.swift
//  GreenEggs (iOS)
//
//  Created by Elisabeth Whiteley on 08/09/2020.
//
//

import Foundation
import CoreData


extension UserMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserMO> {
        return NSFetchRequest<UserMO>(entityName: "UserData")
    }

    @NSManaged public var name: String?
    @NSManaged public var theme: String?

}

extension UserMO : Identifiable {

}
