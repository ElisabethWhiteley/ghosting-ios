//
//  FoodList.swift
//  GreenEggs
//
//  Created by Elisabeth Whiteley on 30/08/2020.
//

import SwiftUI

struct FoodList: View {
    var searchText: String
    
    var body: some View {
        let filteredFood = modelData.filter({ searchText.isEmpty ? true : $0.name.lowercased().contains(searchText.lowercased()) })
        List(filteredFood) { food in
            NavigationLink(destination: FoodDetails(food: food)) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(food.name)
                            .font(.title)
                        HStack() {
                            Text(String(food.attempts) + "/15")
                            Spacer()
                            
                            ForEach(0..<5) { starNumber in
                                let image = starNumber < food.rating ? "star.fill" : "star"
                                
                                Image(systemName: image).foregroundColor(.yellow)
                                    .frame(width: 12, height: 10, alignment: .leading)
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    let modelData: [Food] = [
        Food(name: "Mango", category: "Fruit", attempts: 4, rating: 1),
        Food(name: "Pineapple", category: "Fruit", attempts: 2, rating: 2),
        Food(name: "Lasagna", category: "Dinner", attempts: 1, rating: 3),
        Food(name: "Carrot", category: "Vegetable", attempts: 5, rating: 4),
        Food(name: "Pumpkin", category: "Fruit", attempts: 2, rating: 5),
        Food(name: "Broccoli", category: "Fruit", attempts: 3, rating: 1),
    ]
    
}

struct FoodList_Previews: PreviewProvider {
    static var previews: some View {
        FoodList(searchText: "")
    }
}
