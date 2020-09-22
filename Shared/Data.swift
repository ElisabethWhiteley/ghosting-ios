//
//  Data.swift
//  GreenEggs
//
//  Created by Elisabeth Whiteley on 13/09/2020.
//

import Foundation

class Data: ObservableObject {
    @Published var users: [User] = []
    @Published var currentUser: User? = nil
    @Published var categories: [Category] = []
}
