//
//  GreenEggsApp.swift
//  Shared
//
//  Created by Elisabeth Whiteley on 29/08/2020.
//

import SwiftUI

@main
struct GreenEggsApp: App {
    let persistenceManager = PersistenceManager()

    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, persistenceManager.persistentContainer.viewContext)
        }
    }
}

struct GreenEggsApp_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
