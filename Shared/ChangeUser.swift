//
//  ChangeUser.swift
//  GreenEggs
//
//  Created by Elisabeth Whiteley on 22/09/2020.
//

import SwiftUI

struct ChangeUser: View {
    @EnvironmentObject var data: Data
    @State private var userId: String = ""
    
    var body: some View {
        VStack {
            Form {
                Section {
                    Picker(selection: $userId, label: Text("Current user:")) {
                        ForEach(0..<data.users.count) { index in
                            Text(data.users[index].name).tag(data.users[index].id)
                        }
                }
                }
            }.frame(height: 200)
            
            Button(action: {
                changeCurrentUser()
            }) { HStack {
                Image(systemName: "plus.circle.fill")
                    .font(.title)
                Text("Change user")
                    .fontWeight(.semibold)
                    .font(.title)
            }
            .frame(width: 200)
            .padding()
            .foregroundColor(.black)
            .background(
                Color.green
                  
            )
            .cornerRadius(40)
        }
            
  Spacer()
            
        }.navigationBarTitle("Change User", displayMode: .inline)
    }
    
    func changeCurrentUser() {
        UserDefaults.standard.set(userId, forKey: "CurrentUser")
        let blerg = data.currentUser
        data.currentUser = data.users.first(where: { $0.id == userId })
        let bla = data.currentUser
        let dwad = 2
    }
}