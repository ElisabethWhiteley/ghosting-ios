//
//  UserModel+CoreDataProperties.swift
//  GreenEggs
//
//  Created by Elisabeth Whiteley on 08/09/2020.
//
//

import Foundation
import CoreData


extension UserModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserModel> {
        return NSFetchRequest<UserModel>(entityName: "User")
    }

    @NSManaged public var name: String?
    @NSManaged public var theme: String?

}

extension UserModel : Identifiable {

}
