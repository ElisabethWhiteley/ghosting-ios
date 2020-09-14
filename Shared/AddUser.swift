//
//  AddUser.swift
//  GreenEggs
//
//  Created by Elisabeth Whiteley on 14/09/2020.
//

import SwiftUI

struct AddUser: View {
    @EnvironmentObject var data: Data
    @State private var name: String = ""
    @State private var theme: String = ""
    @State private var makeCurrentUser: Bool = true
    
    var body: some View {
        VStack {
            Form {
                Section {
                    HStack {
                        Text("Name: ")
                        TextField("E.g. The Dude", text: $name)
                    }
                    Picker(selection: $theme, label: Text("Choose theme")) {
                        Text("Green").tag("green")
                        Text("Black").tag("black")
                        Text("Blue").tag("blue")
                    }
                    Toggle(isOn: $makeCurrentUser) {
                        Text("Switch to new user")
                    }
                    
                }
            }.frame(height: 200)
            
            Button(action: {
                addUser(name: name, theme: theme)
            }) { HStack {
                Image(systemName: "plus.circle.fill")
                    .font(.title)
                Text("Create user")
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
            
        }.navigationBarTitle("Add User", displayMode: .inline)
    }
    
    func addUser(name: String, theme: String) {
        var newUser = User()
        newUser.name = name
        newUser.theme = theme
        
        GreenEggsClient.addUser(user: newUser, success: { users in
            DispatchQueue.main.async {
                data.users = users ?? []
            }
            
        }, failure: { (error, _) in
            
            // do nothing like a putz
        })
    }
}

struct AddUser_Previews: PreviewProvider {
    static var previews: some View {
        AddUser()
    }
}
