//
//  Users.swift
//  GreenEggs
//
//  Created by Elisabeth Whiteley on 30/08/2020.
//

import SwiftUI

struct Users: View {
    @EnvironmentObject var data: Data
    @State private var name: String = ""
    @State private var theme: String = ""
    @State private var value = 0
    
    var body: some View {
        VStack {
            ZStack {
                HStack(alignment: .top) {
                   
                    Spacer()
                    Spacer()
                    Spacer()
                    NavigationLink(destination: AddUser()) {
                        Image(systemName: "person.crop.circle.fill.badge.plus").foregroundColor(.green).font(.system(size: 30))

                    }
                }
                
                HStack {
                    Spacer()
                    Image(systemName: "person.circle").foregroundColor(.blue)
                        .font(.system(size: 80)).padding(.top, 20)
                   Spacer()
                }
            }
            
           
            
            if (data.currentUser == nil) {
                Text("No current user").font(.largeTitle).bold()
            } else {
                let currentUserName = data.currentUser!.name
                Text(currentUserName)
                    .font(.largeTitle)
                    .bold()
                   
            }
            
            /*
             Picker(selection: $theme, label: Text("Change theme")) {
             Text("Green").tag("green")
             Text("Black").tag("black")
             Text("Blue").tag("blue")
             } */
            
          
            
            Picker(selection: $value, label: Text("Choose user")) {
                ForEach(0..<data.users.count)
                {
                    Text(data.users[$0].name).tag(data.users[$0].id)
                }
            }
            Button(action: {
                changeCurrentUser(id: data.users[value].id)
                
            }) {
                Text("Change current user")
            }
            Spacer()
        }.navigationBarTitle("User", displayMode: .inline)
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
    
    func changeCurrentUser(id: String) {
        UserDefaults.standard.set(id, forKey: "CurrentUser")
    }
}

/*
 struct Users_Previews: PreviewProvider {
 static var previews: some View {
 Users()
 }
 }
 */

struct Users_Previews: PreviewProvider {
    static var previews: some View {
        Users().environmentObject(Data())
    }
}
