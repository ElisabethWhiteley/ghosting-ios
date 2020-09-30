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
    @Environment(\.presentationMode) var presentationMode
    @State private var showingDeleteAlert = false
    @State var dataState: Data?
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image(systemName: "person.circle").foregroundColor(.blue)
                    .font(.system(size: 100)).padding(.top, 20)
                    .padding(.bottom, 10)
                Spacer()
            }
            
            if let currentUser = data.users.first(where: {$0.id == UserDefaults.standard.object(forKey: "CurrentUser") as? String ?? "" }) {
                let currentUserName = currentUser.name
                Text(currentUserName)
                    .font(.largeTitle)
                    .bold()
               
            } else {
                Text("No current user").font(.largeTitle).bold()
            }
            
            HStack() {
                Spacer()
                NavigationLink(destination: AddUser()) {
                    VStack {
                        Image(systemName: "person.crop.circle.fill.badge.plus").foregroundColor(.green).font(.system(size: 53))
                        Text("Add user")
                            .padding(.top, 5)
                            .foregroundColor(.black)
                    }.frame(width: 100.0, height: 100.0)
                    
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
                    }.frame(width: 100.0, height: 100.0)
                    
                }
                Spacer()
                
                Button(action: {
                    self.showingDeleteAlert = true
                }) {
                    VStack {
                        Image(systemName: "person.crop.circle.fill.badge.xmark").foregroundColor(.red).font(.system(size: 53))
                        Text("Delete user")
                            .padding(.top, 5)
                            .foregroundColor(.black)
                    }.frame(width: 100.0, height: 100.0)
                    
                }
                
                
                Spacer()
                
            }.padding(.top, 35)
            
            
            Spacer()
        }.navigationBarTitle("User", displayMode: .inline)
        .onReceive(data.objectWillChange, perform: { _ in
            dataState = data
         })
        .alert(isPresented: $showingDeleteAlert) {
            Alert(title: Text("Delete food"), message: Text("Are you sure?"), primaryButton: .destructive(Text("Delete")) {
                    self.deleteUser()
                }, secondaryButton: .cancel()
            )
        }
    }
    
    func deleteUser() {
        if let userId =  UserDefaults.standard.object(forKey: "CurrentUser") as? String ?? "" {
            GreenEggsClient.deleteUser(userId: userId, success: {
                DispatchQueue.main.async {
                    var users = data.users
                    users.removeAll(where: {$0.id == userId})
                    data.users = users
                    presentationMode.wrappedValue.dismiss()
                }
                
            }, failure: { (error, _) in
                DispatchQueue.main.async {
                   
                }
            })
        }
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
