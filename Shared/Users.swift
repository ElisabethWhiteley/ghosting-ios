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
    @Binding var currentUserId: String
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image(systemName: "person.circle").foregroundColor(.blue)
                    .font(.system(size: 100)).padding(.top, 20)
                    .padding(.bottom, 10)
                Spacer()
            }
            
            if let currentUser = data.users.first(where: {$0.id == currentUserId }) {
                let currentUserName = currentUser.name
                Text(currentUserName)
                    .font(.largeTitle)
                    .bold()
               
            } else {
                Text("No current user").font(.largeTitle).bold()
            }
            
            HStack() {
                Spacer()
                NavigationLink(destination: AddUser(currentUserId: $currentUserId)) {
                    VStack {
                        Image(systemName: "person.crop.circle.fill.badge.plus").foregroundColor(.green).font(.system(size: 53))
                        Text("Add user")
                            .padding(.top, 5)
                            .foregroundColor(.black)
                    }.frame(width: 100.0, height: 100.0)
                    
                }
                Spacer()
                NavigationLink(destination: ChangeUser(currentUserId: $currentUserId)) {
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
            Alert(title: Text("Delete user"), message: Text("Are you sure?"), primaryButton: .destructive(Text("Delete")) {
                    self.deleteUser()
                }, secondaryButton: .cancel()
            )
        }
    }
    
    func deleteUser() {
            GreenEggsClient.deleteUser(userId: currentUserId, success: {
                DispatchQueue.main.async {
                    var users = data.users
                    users.removeAll(where: {$0.id == currentUserId})
                    data.users = users
                    presentationMode.wrappedValue.dismiss()
                }
                
            }, failure: { (error, _) in
                DispatchQueue.main.async {
                   
                }
            })
        
    }
}
