//
//  CashView.swift
//  GreenEggs
//
//  Created by Elisabeth Whiteley on 02/10/2020.
//

import SwiftUI

struct CashView: View {
    @EnvironmentObject var data: Data
    @Binding var currentUserId: String
    
    @State  var amount: String
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image(systemName: "coloncurrencysign.circle").foregroundColor(.green)
                    .font(.system(size: 100)).padding(.top, 20)
                    .padding(.bottom, 10)
                Spacer()
            }
            
         
            Text("560").font(.largeTitle).bold().padding(.bottom, 30)
           
            HStack {
                TextField("Cash out ...", text: $amount)
                    .padding(10)
                    .padding(.leading, 30)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                            Image(systemName: "coloncurrencysign.circle")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 8)
                     
                       
                    )
                    .padding(.horizontal, 10)
                    
                Spacer()
                Button(action: {
                   
                }) {
                    HStack {
                        Text("OK").fontWeight(.bold)
                    }
                    .padding(10)
                    .padding(.horizontal, 16)
                    .foregroundColor(.black)
                    .background(Color.green)
                    .cornerRadius(12)
                }.padding(.trailing, 12)
                
            }
          
            Spacer()
        
        }.navigationBarTitle("Cash", displayMode: .inline)
    
       
    }
   
    func addFood(name: String, selectedCategory: String, attempted: Bool, rating: Int) {
    
        let index = data.users.firstIndex(where: {$0.id == currentUserId})
        
        if !(data.users[index!].food.contains(where: { $0.name == name })) {
            let newFood = Food()
            
            newFood.name = name
            newFood.categoryId = selectedCategory
            newFood.attempts = attempted ? 1 : 0
            newFood.rating = rating
            
            GreenEggsClient.addFood(food: newFood, userId: currentUserId, success: { food in
                DispatchQueue.main.async {
                    
                    var user = data.users[index!]
                    user.food.append(food)
                    data.users[index!] = user
                }
                
                  }, failure: { (error, _) in
                     // do nothing like a putz
                  })
        }
    }
}
