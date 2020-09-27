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
            let awd = users
            objectWillChange.send()
        }
    }
    @Published var currentUser: User? = nil {
        didSet {
            objectWillChange.send()
        }
    }
    @Published var categories: [Category] = [] {
        didSet {
            objectWillChange.send()
        }
    }
    
    let objectWillChange = PassthroughSubject<(), Never>()

}
