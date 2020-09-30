//
//  Rating.swift
//  GreenEggs
//
//  Created by Elisabeth Whiteley on 02/09/2020.
//

import SwiftUI
 
struct Rating: View {
    var food: Food?
    
    var body: some View {
        HStack {
            ForEach(0..<5) { starNumber in
                let image = starNumber < (food?.rating ?? 100) ? "star.fill" : "star"
                
                Image(systemName: image).foregroundColor(.yellow)
                    .frame(width: 12, height: 10, alignment: .leading)
            }
        }
    }
    
   
}

struct Rating_Previews: PreviewProvider {
    static var previews: some View {
        Rating(food: nil)
    }
}
