//
//  FoodDetails.swift
//  GreenEggs
//
//  Created by Elisabeth Whiteley on 30/08/2020.
//

import SwiftUI

struct FoodDetails: View {
    @EnvironmentObject var data: Data
    var food: Food?
    @State private var showNewAttemptModal = false
    var body: some View {
      
        VStack {
            Image(getCategory()?.icon ?? "category-icon-various")
            .resizable()
            .frame(width: 100.0, height: 100.0)
                .padding(.top, 20)
                .padding(.bottom, 10)
            Text(food?.name ?? "Apple").font(.largeTitle).bold()
            
            HStack {
                Spacer()
                Button(action: {
                    self.showNewAttemptModal.toggle()
                    
                }) {
                    VStack {
                        Image(systemName: "plus.circle.fill").foregroundColor(.green).font(.system(size: 53))
                        Text("Add attempt")
                            .padding(.top, 5)
                            .foregroundColor(.black)
                        
                    }.frame(width: 100.0, height: 100.0)
                    
                }.sheet(isPresented: $showNewAttemptModal) {
                    if let food = food {
                        AddAttempt(showModal: self.$showNewAttemptModal, food: food)
                    }
                }
               
                Spacer()
                
                Button(action: {
                    self.showNewAttemptModal.toggle()
                    
                }) {
                    VStack {
                        Image(systemName: "trash.circle.fill").foregroundColor(.red).font(.system(size: 53))
                        Text("Delete food")
                            .padding(.top, 5)
                            .foregroundColor(.black)
                    }.frame(width: 100.0, height: 100.0)
                    
                }.sheet(isPresented: $showNewAttemptModal) {
                    if let food = food {
                        AddAttempt(showModal: self.$showNewAttemptModal, food: food)
                    }
                }
                Spacer()
            }.padding(.bottom, 35)
            .padding(.top, 35)
            HStack {
                Text("Attempts:")
                    .padding(.leading, 12)
                    .padding(.vertical, 16)
                Spacer()
                Text(String(food?.attempts ?? 0) + "/15")
                    .padding(.trailing, 24)
            }
            .background(Color("color-light-green"))
            
            HStack {
                Text("Rating:")
                    .padding(.leading, 12)
                    .padding(.vertical, 16)
                Spacer()
                HStack {
                    ForEach(0..<5) { starNumber in
                        let image = starNumber < food?.rating ?? 0 ? "star.fill" : "star"
                        
                        Image(systemName: image).foregroundColor(.yellow)
                            .frame(width: 12, height: 10, alignment: .leading)
                    }
                } .padding(.trailing, 24)
            }
           
            HStack {
                Text("Category:")
                    .padding(.leading, 12)
                    .padding(.vertical, 16)
                Spacer()
                Text(String(getCategory()?.name ?? "Various"))
                    .padding(.trailing, 24)
            }
            .background(Color("color-light-green"))
          Spacer()
        }.navigationBarTitle("Food Details", displayMode: .inline)
    }
    
    func getCategory() -> FoodCategory? {
        if let food = food {
            if let category = data.categories.first(where: { $0.id == food.categoryId } ) {
                return category
            }
        }
        return nil
    }
    func updateAttempts() {
        if let food = food {
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
}


struct FoodDetails_Previews: PreviewProvider {
    static var previews: some View {
        FoodDetails(food: nil)
    }
}
