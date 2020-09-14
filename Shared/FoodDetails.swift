//
//  FoodDetails.swift
//  GreenEggs
//
//  Created by Elisabeth Whiteley on 30/08/2020.
//

import SwiftUI

struct FoodDetails: View {
    @EnvironmentObject var data: Data
    var food: Food
    
    var body: some View {
        VStack {
            Image("category-icon-meat")
            .resizable()
            .frame(width: 64.0, height: 64.0)
            .padding(24)
            Text(food.name).font(.largeTitle).bold().padding(.bottom, 1)
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
        
        if let currentUser = data.currentUser {
            GreenEggsClient.addFood(food: updatedFood, userId: currentUser.id, success: { food in
                DispatchQueue.main.async {
                    var users = data.users
                    let index = users.firstIndex(where: {$0.id == currentUser.id})
                    users[index!].food = food!
                    data.users = users
                }
               
            }, failure: { (error, _) in
            
            })
        }
    }
}
