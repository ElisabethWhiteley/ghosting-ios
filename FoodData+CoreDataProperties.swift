//
//  FoodData+CoreDataProperties.swift
//  GreenEggs
//
//  Created by Elisabeth Whiteley on 10/09/2020.
//
//

import Foundation
import CoreData


extension FoodData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodData> {
        return NSFetchRequest<FoodData>(entityName: "FoodData")
    }

    @NSManaged public var name: String?
    @NSManaged public var category: String?
    @NSManaged public var attempts: Int16
    @NSManaged public var rating: Int16

    
    public var categoryIcon: String {
        get {
            getIconName(category: category ?? "")
        }
    }
    
    func getIconName(category: String) -> String {
        switch category {
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

extension FoodData : Identifiable {

}
