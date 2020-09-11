//
//  Categories+CoreDataProperties.swift
//  GreenEggs
//
//  Created by Elisabeth Whiteley on 11/09/2020.
//
//

import Foundation
import CoreData


extension Categories {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Categories> {
        return NSFetchRequest<Categories>(entityName: "Categories")
    }
    
    @NSManaged public var name: String?
    
    public var icon: String {
        get {
            getIconName(name: name ?? "")
        }
    }
    
    func getIconName(name: String) -> String {
        switch name {
        case "Dairy":
            return "category-icon-dairy"
        case "Dessert":
            return "category-icon-dessert"
        case "Dish":
            return "category-icon-dish"
        case "Drinks":
            return "category-icon-drink"
        case "Fish":
            return "category-icon-fish"
        case "Fruit":
            return "category-icon-fruit"
        case "Meat":
            return "category-icon-meat"
        case "Snacks":
            return "category-icon-snack"
        case "Vegetables":
            return "category-icon-vegetable"
        default:
            return "category-icon-various"
        }
    }
}

extension Categories : Identifiable {
    
}
