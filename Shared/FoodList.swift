//
//  FoodList.swift
//  GreenEggs
//
//  Created by Elisabeth Whiteley on 30/08/2020.
//

import SwiftUI

struct FoodList: View {
    @Binding var users: [User]
    var searchText: String
    
    var body: some View {
        if let filteredFood = users.first?.food.filter({ searchText.isEmpty ? true : $0.name.lowercased().contains(searchText.lowercased()) }) {
            List(filteredFood) { food in
        
                    NavigationLink(destination: FoodDetails(food: food)) {
                        HStack {
                            HStack() {
                                Image("category-icon-meat")
                                .resizable()
                                .frame(width: 36.0, height: 36.0)
                                VStack {
                                    Text(food.name)
                                        .font(.title)
                                    Spacer()
                                    HStack {
                                        ForEach(0..<5) { starNumber in
                                            let image = starNumber < food.rating ? "star.fill" : "star"
                                            
                                            Image(systemName: image).foregroundColor(.yellow)
                                                .frame(width: 12, height: 10, alignment: .leading)
                                        }
                                    }
                                   
                                }
                              
                            Spacer()
                                   // Text(String(food.attempts) + "/15")
                            }
                        }
                    }
                

            }
        }

    }
}

