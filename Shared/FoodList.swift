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
        if let filteredFood = data.currentUser?.food.filter({ searchText.isEmpty ? true : $0.name.lowercased().contains(searchText.lowercased()) }) {
          
            List(0..<filteredFood.count, id: \.self) { index in
                NavigationLink(destination: FoodDetails(food: filteredFood[index])) {
               
                        HStack() {
                            Image(getCategoryIcon(categoryId: filteredFood[index].categoryId)
                                  )
                                .resizable()
                                .frame(width: 42.0, height: 42.0)
                            .padding(.leading, 10)
                            .padding(.vertical, 6)
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
                                
                            }.padding(.vertical, 6)
                            
                            Spacer()
                            Text(String(filteredFood[index].attempts) + "/15").padding(.trailing, 6)
                        }
                    
                }
            }
            .onReceive(data.objectWillChange, perform: { _ in
                let dat = data
                dataState = data
            let bla = dataState?.currentUser
            let dwad = 123
             })
            
        }
    }
    
    func getCategoryIcon(categoryId: String) -> String {
        if let category = data.categories.first(where: { $0.id == categoryId } ) {
            return category.icon
        }
        return "category-icon-various"
    }
}


struct FoodList_Previews: PreviewProvider {
    static var previews: some View {
FoodList(searchText: "")
    }
}
