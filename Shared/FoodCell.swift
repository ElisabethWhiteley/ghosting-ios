//
//  FoodCell.swift
//  GreenEggs
//
//  Created by Elisabeth Whiteley on 30/09/2020.
//

import SwiftUI
 
struct FoodCell: View {
    @EnvironmentObject var data: Data
    var food: Food?
    
    var body: some View {
        HStack() {
            Image(getCategoryIcon(categoryId: food?.categoryId ?? "")
            )
            .resizable()
            .frame(width: 42.0, height: 42.0)
            .padding(.leading, 10)
            .padding(.vertical, 6)
            VStack(alignment: .leading) {
                Text(food?.name ?? "")
                    .font(.title)
                Spacer()
                Rating(food: food)
            }.padding(.top, 6).padding(.bottom, 20)
            
            Spacer()
            Text(String(food?.attempts ?? 0) + "/15").padding(.trailing, 6)
        }.padding(10)
    }
    func getCategoryIcon(categoryId: String) -> String {
        if let category = data.categories.first(where: { $0.id == categoryId } ) {
            return category.icon
        }
        return "category-icon-various"
    }
   
}

struct FoodCell_Previews: PreviewProvider {
    static var previews: some View {
        FoodCell(food: nil)
    }
}
