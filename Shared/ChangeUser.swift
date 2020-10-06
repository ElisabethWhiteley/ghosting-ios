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
    @Binding var currentUserId: String
    
    var body: some View {
        VStack {
            Form {
                Section {
                    Picker(selection: $userId, label: Text("Current user:")) {
                        ForEach(0..<data.users.count) { index in
                            Text(data.users[index].name).tag(data.users[index].id)
                        }
                    }.pickerStyle(WheelPickerStyle())
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
      currentUserId = userId
    }
}
