//
//  NotesView.swift
//  Ghosting
//
//  Created by Elisabeth Teigland Whiteley on 01/05/2022.
//

import SwiftUI
 
struct NotesView: View {
    @State private var page = 1
      
    var body: some View {
        Color.black
               .ignoresSafeArea()
            .overlay(
                VStack(alignment: .leading) {
                    Text("Suspect #1").font(Font.custom("Mousedrawn", size: 24)).padding(.bottom, 0.5)
                    Text(" Name: Trevor Bartlet \n Year of death: 1974 \n Age: 47 \n - Was at a bar, stepped into road and got hit by a car. Dead instantly. Friends say drunk at time of death, left bar in good mood. \n - Wife says nice, but quick to anger. Had issues with his boss. \n - Not religious says wife \n - 3 kids: Dorothy (10), Patty (15) and Michael (17).").lineSpacing(8)
            Spacer()
                }.font(Font.custom("Mousedrawn", size: 16)).padding(20).padding(.top, 24).foregroundColor(Color(red: 92/255, green: 98/255, blue: 116/255, opacity: 1.0))
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
          )
        .background(Image("background-notes").resizable())
            )}
    
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        JournalView()
    }
}
