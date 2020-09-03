//
//  AddFood.swift
//  GreenEggs
//
//  Created by Elisabeth Whiteley on 02/09/2020.
//


import SwiftUI

struct AddFood: View {
    var categories = ["Fruit", "Vegetable", "Meat", "Dairy", "Snacks", "Fish", "Dish"]
    @State private var selectedCategoryIndex = 0
    @State private var food: String = ""
    @State private var category: String = ""
    @State private var triedFood: Bool = false
    @State private var rating: Int = 0
    
    var body: some View {
        VStack {
            Form {
                Section {
                    HStack {
                        Text("Name: ")
                        TextField("E.g. Apple", text: $food)
                        Spacer()
                        Spacer()
                        Spacer()
                    }
                    Picker(selection: $selectedCategoryIndex, label: Text("Choose category")) {
                        TextField("New category", text: $category).tag(-1)
                            .background(
                                Color.gray
                                    .brightness(0.4)
                            )
                            .cornerRadius(6.0)
                            .padding(.trailing, 100)
                       
                        ForEach(0 ..< categories.count) {
                            let bla = $0
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
}
struct AddFood_Previews: PreviewProvider {
    static var previews: some View {
        AddFood()
    }
}
