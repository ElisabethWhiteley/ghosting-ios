//
//  Achievements.swift
//  GreenEggs
//
//  Created by Elisabeth Whiteley on 30/08/2020.
//

import SwiftUI
 
struct Achievements: View {
    
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
           
            ScrollView {
                LazyVStack {
                    
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
