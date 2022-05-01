//
//  JournalView.swift
//  Ghosting
//
//  Created by Elisabeth Teigland Whiteley on 01/05/2022.
//

import SwiftUI
 
struct JournalView: View {
    @State private var page = 1
      
    var body: some View {
        Image("background-journal").resizable()
               .ignoresSafeArea()
            .overlay(
        VStack {
            Text("HI")
           
            Spacer()
        }.frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
          )
       
    )}
    
}

struct JournalView_Previews: PreviewProvider {
    static var previews: some View {
        JournalView()
    }
}
