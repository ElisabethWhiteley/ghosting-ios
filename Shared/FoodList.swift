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
    @State var dataState: Data?
    @Binding var currentUserId: String
    
    var body: some View {
        VStack {
            if let filteredFood = data.users.first(where: {$0.id == currentUserId })?.food.filter({ searchText.isEmpty ? true : $0.name.lowercased().contains(searchText.lowercased()) }) {
                
                ScrollView {
                    LazyVStack {
                        ForEach(0..<filteredFood.count, id: \.self) { index in
                            NavigationLink(destination: FoodDetails(food: filteredFood[index], currentUserId: $currentUserId)) {
                                
                                FoodCell(food: filteredFood[index])
                            }.background(Color(index % 2 == 0 ? "color-lightest-green" : "white"))
                            
                        }
                    }
                }
               //
                /*
                List(0..<filteredFood.count, id: \.self) { index in
                    NavigationLink(destination: FoodDetails(food: filteredFood[index], currentUserId: $currentUserId)) {
                        
                        FoodCell(food: filteredFood[index])
                    }
                }*/
                
            }
        }.onReceive(data.objectWillChange, perform: { _ in
            dataState = data
        })
        
    }
}
