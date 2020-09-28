//
//  UserResponse.swift
//  GreenEggs
//
//  Created by Elisabeth Whiteley on 12/09/2020.
//

import Foundation

struct User: Codable {
    var food: [Food] = []
    var id: String = ""
    var name: String = ""
    var theme: String?
}

class Food: Codable {
    var id: String = ""
    var name: String = ""
    var rating: Int = 0
    var attempts: Int = 0
    var totalAttempts: Int = 0
    var categoryId: String = ""
}



struct FoodCategory: Codable {
    let id: String
    let name: String

    
    var icon: String {
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
