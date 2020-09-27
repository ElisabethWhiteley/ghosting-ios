//
//  AddAttempt.swift
//  GreenEggs
//
//  Created by Elisabeth Whiteley on 27/09/2020.
//

import SwiftUI

struct AddAttempt: View {
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
                    Button("Yes, I'm sure") {
                        deleteUser()
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
    
    func deleteUser() {
        GreenEggsClient.deleteUser(userId: self.userId, success: {
            DispatchQueue.main.async {
                self.deletionText = "User has been deleted woo"
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

