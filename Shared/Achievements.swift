//
//  Achievements.swift
//  GreenEggs
//
//  Created by Elisabeth Whiteley on 30/08/2020.
//

import SwiftUI
 
struct Achievements: View {
    @State private var tab = 0
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image(systemName: "star.circle").foregroundColor(.yellow)
                    .font(.system(size: 100)).padding(.top, 20)
                    .padding(.bottom, 10)
                Spacer()
            }

            Text("950").font(.largeTitle).bold().padding(.bottom, 30)
           
            
            Picker(selection: $tab, label: Text("")) {
                           Text("NEW").tag(0)
                           Text("ALL").tag(1)
                           Text("IN PROGRESS").tag(2)
                       }.pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal, 10)
            
            ScrollView {
                LazyVStack {
                    Achievement().padding()
                }
            }
           Spacer()
        
        }.navigationBarTitle("Achievements", displayMode: .inline)
    }
    
}

struct Achievements_Previews: PreviewProvider {
    static var previews: some View {
        Achievements()
    }
}
