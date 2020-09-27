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
    let strings = ["1234", "5678"]
    var body: some View {
      
        VStack {
            Image(getCategory()?.icon ?? "category-icon-various")
            .resizable()
            .frame(width: 64.0, height: 64.0)
            .padding(24)
            Text(food.name).font(.largeTitle).bold().padding(.bottom, 36)
            HStack {
                Text("Attempts:")
                    .padding(.leading, 12)
                Spacer()
                Text(String(food.attempts) + "/15")
                    .padding(.trailing, 24)
            }.padding(.vertical, 10)
            .background(Color.gray)
            
            HStack {
                Text("Rating:")
                    .padding(.leading, 12)
                Spacer()
                HStack {
                    ForEach(0..<5) { starNumber in
                        let image = starNumber < food.rating ? "star.fill" : "star"
                        
                        Image(systemName: image).foregroundColor(.yellow)
                            .frame(width: 12, height: 10, alignment: .leading)
                    }
                } .padding(.trailing, 24)
            }.padding(.vertical, 10)
           
            HStack {
                Text("Category:")
                    .padding(.leading, 12)
                Spacer()
                Text(String(getCategory()?.name ?? "Various"))
                    .padding(.trailing, 24)
            }.padding(.vertical, 10)
            .background(Color.gray)
            
            
            Button(action: {
                updateAttempts()
            }) {
                Text("Add attempt: ")
                Image(systemName: "plus.circle.fill").foregroundColor(.green)
                    .font(.system(size: 30))
            }
           
            Spacer()
        }.navigationBarTitle("Food Details", displayMode: .inline)
    }
    
    func getCategory() -> Category? {
        if let category = data.categories.first(where: { $0.id == food.categoryId } ) {
            return category
        }
        return nil
    }
    func updateAttempts() {
        let updatedFood = food
        updatedFood.attempts = food.attempts + 1
        
        if let currentUser = data.currentUser {
            GreenEggsClient.updateFood(food: updatedFood, userId: currentUser.id, success: { food in
                DispatchQueue.main.async {
                    var users = data.users
                    let index = users.firstIndex(where: {$0.id == currentUser.id})
                    let foodIndex = users[index!].food.firstIndex(where: {$0.id == food.id})
                    
                    users[index!].food[foodIndex!] = food
                    data.users = users
                }
               
            }, failure: { (error, _) in
            
            })
        }
    }
}
