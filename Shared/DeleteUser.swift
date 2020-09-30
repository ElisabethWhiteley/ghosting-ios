//
//  DeleteUser.swift
//  GreenEggs
//
//  Created by Elisabeth Whiteley on 22/09/2020.
//

import SwiftUI

struct DeleteUser: View {
    @Binding var showModal: Bool
    @State var userHasBeenDeleted: Bool = false
    var userId: String
    @State var deletionText: String = "User has been deleted"
    
    var body: some View {
        if userHasBeenDeleted {
            VStack {
                Text(deletionText)
                    .padding()
                HStack {
                    Spacer()
                    Button("Ok") {
                        self.showModal.toggle()
                    }
                    Spacer()
                }
            }
        } else {
            VStack {
                Text("Are you sure you want to delete this user?")
                    .padding()
                HStack {
                    Spacer()
                    Button(action: {
                        deleteUser()
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
    
    func deleteUser() {
        GreenEggsClient.deleteUser(userId: self.userId, success: {
            DispatchQueue.main.async {
                self.deletionText = "User has been deleted "
                self.userHasBeenDeleted = true
            }
            
        }, failure: { (error, _) in
            DispatchQueue.main.async {
                self.deletionText = "Failed to delete user. Try again later."
                self.userHasBeenDeleted = true
            }
        })
    }
    
}

