//
//  FoodList.swift
//  GreenEggs
//
//  Created by Elisabeth Whiteley on 30/08/2020.
//

import SwiftUI

struct FoodList: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: FoodData.entity(), sortDescriptors: []) private var foodList: FetchedResults<FoodData>
    var searchText: String
    
    var body: some View {
        let filteredFood = foodList.filter({ searchText.isEmpty ? true : $0.name!.lowercased().contains(searchText.lowercased()) })
        List(filteredFood) { food in
            let bla = food.name
            let ameliaPoop = food.category
            let ALExisCool = food.categoryIcon
            if bla != "Apple" {
                NavigationLink(destination: FoodDetails(food: food)) {
                    HStack {
                        HStack() {
                            Image(food.categoryIcon)
                            .resizable()
                            .frame(width: 36.0, height: 36.0)
                            VStack {
                                Text(food.name!)
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

struct FoodList_Previews: PreviewProvider {
    static var previews: some View {
        FoodList(searchText: "")
    }
}
