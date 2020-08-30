//
//  GreenEggsApp.swift
//  Shared
//
//  Created by Elisabeth Whiteley on 29/08/2020.
//

import SwiftUI

@main
struct GreenEggsApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .navigationTitle("Green Eggs")
                    .navigationBarItems(
                                        trailing:
                                            NavigationLink(destination: Users()) {
                                                Image(systemName: "person.crop.circle.fill").foregroundColor(.blue).font(.system(size: 40))
                                            }
                                            
                                    )
            }
            
        }
    }
}

struct GreenEggsApp_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
