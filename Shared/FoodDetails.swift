//
//  FoodDetails.swift
//  GreenEggs
//
//  Created by Elisabeth Whiteley on 30/08/2020.
//

import SwiftUI

struct FoodDetails: View {
    var food: Food
    var userId: String
    
    var body: some View {
        VStack {
            Image("category-icon-meat")
            .resizable()
            .frame(width: 64.0, height: 64.0)
            .padding(24)
            Text(food.name ?? "").font(.largeTitle).bold().padding(.bottom, 1)
            HStack {
                ForEach(0..<5) { starNumber in
                    let image = starNumber < food.rating ? "star.fill" : "star"
                    
                    Image(systemName: image).foregroundColor(.yellow)
                        .frame(width: 12, height: 10, alignment: .leading)
                    
                }
                
            }
            Text("Attempts: " + String(food.attempts) + "/15").padding(.vertical, 10)
            Button(action: {
                updateAttempts()
            }) {
                Image(systemName: "plus.circle.fill").foregroundColor(.green)
                    .font(.system(size: 30))
            }
           
            Spacer()
        }.navigationBarTitle("Food Details", displayMode: .inline)
    }
    
    
    func updateAttempts() {
        var updatedFood = food
        updatedFood.attempts = food.attempts + 1
        
        GreenEggsClient.addFood(food: updatedFood, userId: userId, success: { users in
          
            
        }, failure: { (error, _) in
        
        })
    }
}
