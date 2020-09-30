//
//  DeleteFoodModalView.swift
//  GreenEggs
//
//  Created by Elisabeth Whiteley on 29/09/2020.
//

import SwiftUI

struct DeleteFood: View {
    @Binding var showModal: Bool
    @State var foodHasBeenDeleted: Bool = false
    @EnvironmentObject var data: Data
    var food: Food
    @State var deletionText: String = "Food has been deleted."
    @Environment(\.presentationMode) var presentationMode
    @State private var showingDeleteAlert = false
    
    var body: some View {
        if foodHasBeenDeleted {
            VStack {
                Text(deletionText)
                    .padding()
                HStack {
                    Spacer()
                    Button(action: {
                        self.showModal.toggle()
                    }) {
                        Text("Ok")
                            .fontWeight(.bold)
                            .padding(.horizontal, 25)
                            .padding(.vertical, 15)
                            .background(Color.green)
                            .cornerRadius(40)
                            .foregroundColor(.black)
                    }
                    Spacer()
                }
            }
        } else {
            VStack {
                Text("Are you sure you want to delete this food?")
                    .padding()
                HStack {
                    Spacer()
                    Button(action: {
                        deleteFood()
                    }) {
                        Text("Yes, I'm sure")
                            .fontWeight(.bold)
                            .padding(.horizontal, 25)
                            .padding(.vertical, 15)
                            .background(Color.green)
                            .cornerRadius(40)
                            .foregroundColor(.black)
                    }
                    Spacer()
                    Button(action: {
                        self.showModal.toggle()
                    }) {
                        Text("Go back")
                            .fontWeight(.bold)
                            .padding(.horizontal, 25)
                            .padding(.vertical, 15)
                            .background(Color.green)
                            .cornerRadius(40)
                            .foregroundColor(.black)
                    }
                    Spacer()
                }
            }
        }
    }
    
    func deleteFood() {
        if let currentUser = data.users.first(where: {$0.id == UserDefaults.standard.object(forKey: "CurrentUser") as? String ?? "" }) {
            GreenEggsClient.deleteFood(food: food, userId: currentUser.id, success: {
            DispatchQueue.main.async {
                self.deletionText = "Food has been deleted."
                self.foodHasBeenDeleted = true
            }
            
        }, failure: { (error, _) in
            DispatchQueue.main.async {
                self.deletionText = "Failed to delete food. Try again later."
                self.foodHasBeenDeleted = true
            }
        })
        }
        
        presentationMode.wrappedValue.dismiss()
    }
}

