//
//  UserData+CoreDataProperties.swift
//  GreenEggs
//
//  Created by Elisabeth Whiteley on 10/09/2020.
//
//

import Foundation
import CoreData


extension UserData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserData> {
        return NSFetchRequest<UserData>(entityName: "UserData")
    }

    @NSManaged public var name: String?
    @NSManaged public var theme: String?
    @NSManaged public var userId: Int16

}

extension UserData : Identifiable {

}
