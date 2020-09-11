//
//  Users.swift
//  GreenEggs
//
//  Created by Elisabeth Whiteley on 30/08/2020.
//

import SwiftUI
 
struct Users: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: UserData.entity(), sortDescriptors: []) private var users: FetchedResults<UserData>
    @FetchRequest(entity: CurrentUserData.entity(), sortDescriptors: []) private var currentUser: FetchedResults<CurrentUserData>
    @State private var name: String = ""
    @State private var theme: String = ""
    @State private var value = 0
    var body: some View {
        VStack {
            if currentUser.first?.userId != nil {
                let currentUserId = users.first(where: {
                  
                   return $0.userId == (currentUser.first?.userId ?? 0)
                    
                })?.userId ?? 0
               
                let currentUserName = users.filter({ $0.userId == currentUserId }).first?.name
                Image(systemName: "person.circle").foregroundColor(.green)
                    .font(.system(size: 80)).padding(.top, 10)
                
                Spacer()
                Text(currentUserName ?? "").font(.largeTitle).bold().padding(.bottom, 1)
               
            } else {
                Text("No current user").font(.largeTitle).bold().padding(.bottom, 1)
            }
           
            Picker(selection: $theme, label: Text("Change theme")) {
                Text("Green").tag("green")
                Text("Black").tag("black")
                Text("Blue").tag("blue")
            }
            
            
            Picker(selection: $value, label: Text("Choose user")) {
                ForEach(0..<users.count)
                               {
                    Text(users[$0].name ?? "").tag(users[$0].userId)
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
    }
    
   
    
    func saveContext() {
      do {
        try managedObjectContext.save()
      } catch {
        print("Error saving managed object context: \(error)")
      }
    }
    
    func addUser(name: String, theme: String) {
  
       // managedObjectContext.delete(user.first!)
   // saveContext()
       
      // 1
      let newUser = UserData(context: managedObjectContext)
       
      // 2
        newUser.name = name
        newUser.theme = theme

      // 3
      saveContext()
        
        if users.count == 1 {
            if let id = users.first?.userId {
                changeCurrentUser(id: id)
            }
        }
    }
    
    func changeCurrentUser(id: Int16) {
            if currentUser.first != nil {
                currentUser.first?.setValue(id, forKey: "userId")
            } else {
                let newCurrentUser = CurrentUserData(context: managedObjectContext)
                newCurrentUser.userId = id
            }
        
        saveContext()
           
        
       
    }
}
/*
struct Users_Previews: PreviewProvider {
    static var previews: some View {
        Users()
    }
}
*/
