//
//  Users.swift
//  GreenEggs
//
//  Created by Elisabeth Whiteley on 30/08/2020.
//

import SwiftUI
 
struct Users: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: User.entity(), sortDescriptors: []) private var user: FetchedResults<User>
    @FetchRequest(entity: CurrentUser.entity(), sortDescriptors: []) private var currentUser: FetchedResults<CurrentUser>
    var name: String?
    var theme: String?
    @State private var value = 0
    var body: some View {
        VStack {
            if currentUser.first?.userId != nil {
                let currentUserId = user.first(where: {
                    let bla = $0
                   return $0.name == currentUser.first?.userId ?? ""
                    
                })
                Text(user.first?.name ?? "Blurb").font(.largeTitle).bold().padding(.bottom, 1)
            } else {
                Text("No current user").font(.largeTitle).bold().padding(.bottom, 1)
            }
            
            Button(action: {
                addUser(name: "wefse", theme: "Testy")
            }) {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.green)
                    .padding(.trailing, 8)
            }
           
            Picker(selection: $value, label: Text("Choose user")) {
                ForEach(user, id: \.id)
                               { user in
                    Text(user.name ?? "Unknown").tag(user.id)
                               }
               
            }
            Spacer()
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
      let newUser = User(context: managedObjectContext)
       
      // 2
        newUser.name = name
        newUser.theme = theme

      // 3
      saveContext()
        
        if user.count == 1 {
            if let id = user.first?.objectID.description {
                changeCurrentUser(id: id)
            }
        }
    }
    
    func changeCurrentUser(id: String) {
            if currentUser.first != nil {
                currentUser.first?.setValue(id, forKey: "userId")
            } else {
                let newCurrentUser = CurrentUser(context: managedObjectContext)
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
