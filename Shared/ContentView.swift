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
            Main()
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
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
