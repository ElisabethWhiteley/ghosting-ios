//
//  AddFood.swift
//  GreenEggs
//
//  Created by Elisabeth Whiteley on 02/09/2020.
//


import SwiftUI

struct AddFood: View {
    @EnvironmentObject var data: Data
    
    var defaultCategories = ["Dairy", "Dessert", "Dish", "Drinks", "Fish", "Fruit", "Meat", "Snacks", "Vegetables"]
     var categories: Array<String> {
        get {
            return getCategories()
        }
       }
    @State private var selectedCategory = 0
    @State private var foodName: String = ""
    @State private var category: String = ""
    @State private var triedFood: Bool = false
    @State private var rating: Int = 0
    
    var body: some View {
        VStack {
            Form {
                Section {
                    HStack {
                        Text("Name:")
                        TextField("E.g. Apple", text: $foodName)
                        Spacer()
                        Spacer()
                        Spacer()
                    }
                    Picker(selection: $selectedCategory, label: Text("Category:")) {
                        TextField("New category", text: $category).tag(-1)
                            .background(
                                Color.gray
                                    .brightness(0.4)
                            )
                            .cornerRadius(6.0)
                            .padding(.trailing, 100)
                        
                        
                        
                        ForEach(0 ..< categories.count) {
                            
                            Text(self.categories[$0]).tag($0)
                            
                        }
                    }
                    // TextField("Or create new category", text: $category)
                    Toggle(isOn: $triedFood) {
                        Text("I have already tried this")
                    }
                    if triedFood {
                        HStack {
                            Text("Rate it:")
                            Spacer()
                            Rating(rating: $rating)
                        }
                    }
                }
            }
            Button(action: {
                addFood(name: foodName, selectedCategory: selectedCategory, attempted: triedFood, rating: rating)
                
            }) {
                Text("Add")
                    .fontWeight(.bold)
                    .font(.title)
                    .padding(.horizontal, 25)
                    .padding(.vertical, 10)
                    .background(Color.green)
                    .cornerRadius(40)
                    .foregroundColor(.black)
                
            }
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
        }.navigationBarTitle("Add food", displayMode: .inline)
    }
   
    func addFood(name: String, selectedCategory: Int, attempted: Bool, rating: Int) {
        let currentUser = UserDefaults.standard.object(forKey: "CurrentUser") as? String ?? ""
        let index = data.users.firstIndex(where: {$0.id == currentUser})
        
        if !(data.users[index!].food.contains(where: { $0.name == name })) {
        var newFood = Food()
            
            newFood.name = name
           // newFood.category = categories[selectedCategory]
            newFood.attempts = attempted ? 1 : 0
            newFood.rating = rating
            
            GreenEggsClient.addFood(food: newFood, userId: currentUser, success: { food in
                DispatchQueue.main.async {
                    
                    var users = data.users
                    let foodIndex = users[index!].food.firstIndex(where: {$0.id == food.id})
                    users[index!].food[foodIndex!] = food
                    data.users = users
                }
                
                  }, failure: { (error, _) in
                  
                     // do nothing like a putz
                  })
        }
    }
    
   
    func getCategories() -> Array<String> {
        var categoriesList = defaultCategories
        /*
        foodList.forEach {
            if !categoriesList.contains($0.category ?? "") {
                categoriesList.append($0.category ?? "")
            }
        }*/
        return categoriesList
    }
}



struct AddFood_Previews: PreviewProvider {
    static var previews: some View {
        AddFood()
    }
}
