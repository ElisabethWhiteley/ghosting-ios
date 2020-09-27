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
    @State private var showDeleteUserModal = false
    
    var body: some View {
        VStack {
                HStack {
                    Spacer()
                    Image(systemName: "person.circle").foregroundColor(.blue)
                        .font(.system(size: 100)).padding(.top, 20)
                        .padding(.bottom, 10)
                   Spacer()
                }
            
           
           
            
            if (data.currentUser == nil) {
                Text("No current user").font(.largeTitle).bold()
            } else {
                let currentUserName = data.currentUser!.name
                Text(currentUserName)
                    .font(.largeTitle)
                    .bold()
                   
            }
            

            HStack() {
               Spacer()
                NavigationLink(destination: AddUser()) {
                    VStack {
                        Image(systemName: "person.crop.circle.fill.badge.plus").foregroundColor(.green).font(.system(size: 53))
                        Text("Add user")
                            .padding(.top, 5)
                            .foregroundColor(.black)
                    }
                    
                }
                Spacer()
                NavigationLink(destination: ChangeUser()) {
                    VStack {
                        Image(systemName: "person.2.fill").foregroundColor(.white).font(.system(size: 30)).padding(.horizontal, 10)
                            .padding(.vertical, 16)
                            .background(Color.blue)
                            .cornerRadius(50)
                            .foregroundColor(.black)
                        Text("Change user").foregroundColor(.black)
                    }
                   
                }
                Spacer()
                
                Button(action: {
                    self.showDeleteUserModal.toggle()
                    
                }) {
                    VStack {
                        Image(systemName: "person.crop.circle.fill.badge.xmark").foregroundColor(.red).font(.system(size: 53))
                        Text("Delete user")
                            .padding(.top, 5)
                            .foregroundColor(.black)
                    }
                    
                }.sheet(isPresented: $showDeleteUserModal) {
                    DeleteUser(showModal: self.$showDeleteUserModal, userId: data.currentUser!.id)
                }
               
               
                Spacer()
               
            }.padding(.top, 35)
            
           
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
