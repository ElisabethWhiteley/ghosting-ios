//
//  AddFood.swift
//  GreenEggs
//
//  Created by Elisabeth Whiteley on 02/09/2020.
//


import SwiftUI

struct AddFood: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: FoodData.entity(), sortDescriptors: []) private var foodList: FetchedResults<FoodData>
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
    @State private var rating: Int16 = 0
    
    var body: some View {
        VStack {
            Form {
                Section {
                    HStack {
                        Text("Name: ")
                        TextField("E.g. Apple", text: $foodName)
                        Spacer()
                        Spacer()
                        Spacer()
                    }
                    Picker(selection: $selectedCategory, label: Text("Choose category")) {
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
                addFood(name: foodName, category: category, selectedCategory: selectedCategory, attempted: triedFood, rating: rating)
                
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
    
    func saveContext() {
        do {
            try managedObjectContext.save()
        } catch {
            print("Error saving managed object context: \(error)")
        }
    }
    
    func addFood(name: String, category: String, selectedCategory: Int, attempted: Bool, rating: Int16) {
        
        // managedObjectContext.delete(user.first!)
        // saveContext()
        if !foodList.contains(where: { $0.name == name }) {
            let newFood = FoodData(context: managedObjectContext)
            
            newFood.name = name
            let bla =  categories[selectedCategory]
            newFood.category = categories[selectedCategory]
            newFood.attempts = attempted ? 1 : 0
            newFood.rating = rating
            
            saveContext()
        } 
    }
    
   
    func getCategories() -> Array<String> {
        var categoriesList = defaultCategories
        
        foodList.forEach {
            if !categoriesList.contains($0.category ?? "") {
                categoriesList.append($0.category ?? "")
            }
        }
        return categoriesList
    }
}



struct AddFood_Previews: PreviewProvider {
    static var previews: some View {
        AddFood()
    }
}
