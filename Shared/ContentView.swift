//
//  ContentView.swift
//  Shared
//
//  Created by Elisabeth Whiteley on 29/08/2020.
//

import SwiftUI

struct ContentView: View {
   init(){
    UITableView.appearance().backgroundColor = UIColor(Color.clear)
    UITableView.appearance().separatorStyle = .none
    }
    @State var showMenu = false
    @EnvironmentObject var data: Data
    @State var dataState: Data?
    @AppStorage("currentuserid") var currentUserId: String = ""
    
    
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
            Main(currentUserId: $currentUserId)
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
           
        }
        .onAppear(perform: getUserData)
        .onAppear(perform: getCategories)
        .onReceive(data.objectWillChange, perform: { _ in
                  dataState = data
            if currentUserId == "" {
                currentUserId = data.users.first?.id ?? ""
            }
               })
        .navigationBarTitle("Side Menu")
    }
    
    func getUserData() {
        GreenEggsClient.getUsers(success: { users in
            DispatchQueue.main.async {
                data.users = users ?? []
                dataState = data
                if currentUserId == "" {
                    currentUserId = data.users.first?.id ?? ""
                }
            }
              }, failure: { (error, _) in
                 // do nothing like a putz
              })
        
    }
    
    func getCategories() {
        GreenEggsClient.getCategories(success: { categories in
            DispatchQueue.main.async {
                data.categories = categories
                dataState?.categories = categories
            }
              }, failure: { (error, _) in
                 // do nothing like a putz
              })
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Data())
    }
}
