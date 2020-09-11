//
//  FoodDetails.swift
//  GreenEggs
//
//  Created by Elisabeth Whiteley on 30/08/2020.
//

import SwiftUI
 
struct FoodDetails: View {
    var food: FoodData
    
    var body: some View {
        VStack {
            Text(food.name ?? "").font(.largeTitle).bold().padding(.bottom, 1)
            HStack {
                ForEach(0..<5) { starNumber in
                    let image = starNumber < food.rating ? "star.fill" : "star"
                    
                    Image(systemName: image).foregroundColor(.yellow)
                        .frame(width: 12, height: 10, alignment: .leading)
                   
                }
               
            }
            Text("Attempts: " + String(food.attempts) + "/15")
            Image(systemName: "plus.circle.fill").foregroundColor(.green)
                .font(.system(size: 30))
            Spacer()
        }.navigationBarTitle("Food Details", displayMode: .inline)
    }
}
