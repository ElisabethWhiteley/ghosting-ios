//
//  AddAttempt.swift
//  GreenEggs
//
//  Created by Elisabeth Whiteley on 27/09/2020.
//

import SwiftUI

struct AddAttempt: View {
    @Binding var showModal: Bool
    @State var attemptRegistered: Bool = false
    @State var attemptResponseText: String = "Attempt recorded!"
    var food: Food
    @EnvironmentObject var data: Data
    @State private var rating: Int = 0
    
    var body: some View {
        if attemptRegistered {
            VStack {
                Text(attemptResponseText)
                    .padding()
                HStack {
                    Spacer()
                    Button("OK") {
                        self.showModal.toggle()
                    }
                    Spacer()
                }
            }
        } else {
            VStack {
                Text("New attempt")
                    .padding()
                Form {
                    Section {
                        HStack {
                            Text("Rate it:")
                            Spacer()
                            Rating(rating: $rating)
                        }
                       
                        
                    }
                }.frame(height: 200)
                HStack {
                    Spacer()
                    Button("Register new attempt") {
                        updateAttempts()
                    }
                    Spacer()
                    Button("Go back") {
                        self.showModal.toggle()
                    }
                    Spacer()
                }
            }
        }
    }
    
    func updateAttempts() {
        let updatedFood = food
        updatedFood.attempts = food.attempts + 1
        updatedFood.rating = rating
        
        if let currentUser = data.currentUser {
            GreenEggsClient.updateFood(food: updatedFood, userId: currentUser.id, success: { food in
                DispatchQueue.main.async {
                    var users = data.users
                    let index = users.firstIndex(where: {$0.id == currentUser.id})
                    let foodIndex = users[index!].food.firstIndex(where: {$0.id == food.id})
                    
                    users[index!].food[foodIndex!] = food
                    data.users = users
                    
                    DispatchQueue.main.async {
                        self.attemptResponseText = "Attempt recorded!"
                        self.attemptRegistered = true
                    }
                }
               
            }, failure: { (error, _) in
                DispatchQueue.main.async {
                    self.attemptResponseText = "Failed to register attempt. Try again later."
                    self.attemptRegistered = true
                }
            })
        }
    }
    
}

