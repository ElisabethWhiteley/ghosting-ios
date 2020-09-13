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

struct Food: Codable {
    var name: String = ""
    var rating: Int = 0
    var maxRating: Int = 0
    var attempts: Int = 0
    var totalAttempts: Int = 0
}
