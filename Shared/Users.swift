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
    var currentUser: String = ""
    
    var body: some View {
        VStack {
            
            if currentUser == "" {
                
            }
      
            let currentUserName = data.users.filter({ $0.id == currentUser }).first?.name
                Image(systemName: "person.circle").foregroundColor(.green)
                    .font(.system(size: 80)).padding(.top, 10)
                
                Spacer()
                Text(currentUserName ?? "").font(.largeTitle).bold().padding(.bottom, 1)
               
      
                Text("No current user").font(.largeTitle).bold().padding(.bottom, 1)
            
           
            Picker(selection: $theme, label: Text("Change theme")) {
                Text("Green").tag("green")
                Text("Black").tag("black")
                Text("Blue").tag("blue")
            }
            
            
            Picker(selection: $value, label: Text("Choose user")) {
                ForEach(0..<data.users.count)
                               {
                    Text(data.users[$0].name ?? "").tag(data.users[$0].id)
                               }
               
            }
            
            
            VStack {
                Form {
                    Section {
                        HStack {
                            Text("Name: ")
                            TextField("E.g. The Dude", text: $name)
                            Spacer()
                            Spacer()
                            Spacer()
                        }
                        Picker(selection: $theme, label: Text("Choose theme")) {
                            Text("Green").tag("green")
                            Text("Black").tag("black")
                            Text("Blue").tag("blue")
                        }
                
                        }
                    }
                }
                Button(action: {
                    addUser(name: name, theme: theme)

                }) {
                    Text("Add user")
                        .fontWeight(.bold)
                        .font(.title)
                        .padding(.horizontal, 25)
                        .padding(.vertical, 10)
                        .background(Color.green)
                        .cornerRadius(40)
                        .foregroundColor(.black)
                        
                }
     
            

        }.navigationBarTitle("User", displayMode: .inline)
        .onAppear(perform: getCurrentUser)
    
    }
    func getCurrentUser() {
        UserDefaults.standard.object(forKey:"CurrentUser") as? String ?? ""
    }
    
    func addUser(name: String, theme: String) {
  
     
        var newUser = User()
       
     
        newUser.name = name
        newUser.theme = theme
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
