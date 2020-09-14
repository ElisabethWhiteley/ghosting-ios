//
//  ContentView.swift
//  Shared
//
//  Created by Elisabeth Whiteley on 29/08/2020.
//

import SwiftUI

struct ContentView: View {
   init(){
        UITableView.appearance().backgroundColor = .clear
    }
    @State var showMenu = false
    //var greenEggsClient: GreenEggsClient!
    @EnvironmentObject var data: Data
    var body: some View {
    /*
        let drag = DragGesture()
            .onEnded {
                if $0.translation.width < -100 {
                    withAnimation {
                        showMenu = false
                    }
                }
            } */
        NavigationView {
            Main(showMenu: $showMenu)
            /*
            return GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Main(showMenu: $showMenu)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(x: showMenu ? geometry.size.width/3 : 0)
                        .disabled(showMenu ? true : false)
                    
                    if self.showMenu {
                        Menu()
                            .frame(width: (geometry.size.width/3)*2)
                            .transition(.move(edge: .leading))
                    }
                }.gesture(drag)
                .navigationTitle("Green Eggs")
                .navigationBarItems(leading: Button(action: {
                    withAnimation {
                        showMenu.toggle()
                    }
                }) {
                    Image(systemName: "line.horizontal.3").foregroundColor(.blue).font(.system(size: 20))
                },
                trailing:
                    NavigationLink(destination: Users()) {
                        Image(systemName: "person.crop.circle.fill").foregroundColor(.blue).font(.system(size: 30))
                    }
                
                )*/
          //  } .navigationBarTitle("Side Menu", displayMode: .inline)
           
        }.onAppear(perform: getUserData)
        .navigationBarTitle("Side Menu", displayMode: .inline)
        
        
        
        
        
    }
    
    func getUserData() {
        GreenEggsClient.getUsers(success: { users in
                 // self.systemStatus = systemStatus
                //  self.buildSystemStatusSection()@
            DispatchQueue.main.async {
                  data.users = users ?? []
                let bla = data.users
                data.currentUser = getCurrentUser()
                let blo = data.currentUser
            }
              }, failure: { (error, _) in
                 // do nothing like a putz
              })
        
    }
    
    func getCurrentUser() -> User? {
       let currentUserId = UserDefaults.standard.object(forKey:"CurrentUser") as? String ?? data.users.first?.id ?? ""
        if let index = data.users.firstIndex(where: {$0.id == currentUserId}) {
            return data.users[index]
        }
        return data.users.first ?? nil
    }
   
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Data())
    }
}
