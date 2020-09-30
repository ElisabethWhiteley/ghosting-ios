//
//  Data.swift
//  GreenEggs
//
//  Created by Elisabeth Whiteley on 13/09/2020.
//

import Foundation
import SwiftUI
import Combine

class Data: ObservableObject {
    @Published var users: [User] = [] {
        didSet {
            objectWillChange.send()
        }
    }

    @Published var categories: [FoodCategory] = [] {
        didSet {
            objectWillChange.send()
        }
    }
    
    let objectWillChange = PassthroughSubject<(), Never>()

}
