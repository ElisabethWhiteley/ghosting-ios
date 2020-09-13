//
//  FoodList.swift
//  GreenEggs
//
//  Created by Elisabeth Whiteley on 30/08/2020.
//

import SwiftUI

struct FoodList: View {
    @EnvironmentObject var data: Data
    var searchText: String
    
    var body: some View {
        if let filteredFood = data.users.first?.food.filter({ searchText.isEmpty ? true : $0.name.lowercased().contains(searchText.lowercased()) }) {
            List(0..<filteredFood.count) { index in
        
                NavigationLink(destination: FoodDetails(food: filteredFood[index], userId: data.users.first?.id ?? "")) {
                        HStack {
                            HStack() {
                                Image("category-icon-meat")
                                .resizable()
                                .frame(width: 36.0, height: 36.0)
                                VStack(alignment: .leading) {
                                    Text(filteredFood[index].name)
                                        .font(.title)
                                    Spacer()
                                    HStack {
                                        ForEach(0..<5) { starNumber in
                                            let image = starNumber < filteredFood[index].rating ? "star.fill" : "star"
                                            
                                            Image(systemName: image).foregroundColor(.yellow)
                                                .frame(width: 12, height: 10, alignment: .leading)
                                        }
                                    }
                                   
                                }
                              
                            Spacer()
                                Text(String(filteredFood[index].attempts) + "/15")
                            }
                        }
                    }
                

            }
        }

    }
}

