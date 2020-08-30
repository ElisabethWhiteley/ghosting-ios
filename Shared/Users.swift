//
//  Users.swift
//  GreenEggs
//
//  Created by Elisabeth Whiteley on 30/08/2020.
//

import SwiftUI
 
struct Users: View {
    
    var body: some View {
        VStack {
            Text(modelData.first!.name).font(.largeTitle).bold().padding(.bottom, 1)
          
            Image(systemName: "plus.circle.fill").foregroundColor(.green)
                .font(.system(size: 30))
            Spacer()
        }.navigationBarTitle("User", displayMode: .inline)
    }
    
    let modelData: [User] = [
        User(name: "Alex"),
        User(name: "Amelia")
    ]
}

struct Users_Previews: PreviewProvider {
    static var previews: some View {
        Users()
    }
}
