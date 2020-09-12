//
//  UserResponse.swift
//  GreenEggs
//
//  Created by Elisabeth Whiteley on 12/09/2020.
//

import Foundation

struct User: Codable {
    var food: [Food]
    var id: String
    var name: String
}

struct Food: Codable, Identifiable {
    var id: Int
    
    var name: String
    var rating: Int
    var attempts: Int
    var totalAttempts: Int
}
