//
//  CurrentUserData+CoreDataProperties.swift
//  GreenEggs
//
//  Created by Elisabeth Whiteley on 10/09/2020.
//
//

import Foundation
import CoreData


extension CurrentUserData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrentUserData> {
        return NSFetchRequest<CurrentUserData>(entityName: "CurrentUserData")
    }

    @NSManaged public var userId: Int16

}

extension CurrentUserData : Identifiable {

}
