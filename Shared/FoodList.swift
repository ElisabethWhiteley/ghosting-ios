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
    
    var body: some View {
        VStack {
            if let filteredFood = data.users.first(where: {$0.id == UserDefaults.standard.object(forKey: "CurrentUser") as? String ?? "" })?.food.filter({ searchText.isEmpty ? true : $0.name.lowercased().contains(searchText.lowercased()) }) {
                
                List(0..<filteredFood.count, id: \.self) { index in
                    NavigationLink(destination: FoodDetails(food: filteredFood[index])) {
                        
                        FoodCell(food: filteredFood[index])
                    }
                }
                
            }
        }.onReceive(data.objectWillChange, perform: { _ in
            dataState = data
        })
        
    }
}


struct FoodList_Previews: PreviewProvider {
    static var previews: some View {
        FoodList(searchText: "")
    }
}
