//
//  Menu.swift
//  GreenEggs
//
//  Created by Elisabeth Whiteley on 30/08/2020.
//

import SwiftUI

struct Menu: View {
    
    var body: some View {
        VStack(alignment: .leading) {
                    HStack {
                        Text("All")
                            .foregroundColor(.gray)
                            .font(.headline)
                    }
                    .padding(.top, 60)
            HStack {
                Text("Recent")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
            HStack {
                Text("New")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
            .padding(.top, 12)
            HStack {
                Text("Most liked")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
            .padding(.top, 12)
                    HStack {
                        Text("Categories")
                            .foregroundColor(.gray)
                            .font(.headline)
                        Spacer()
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.gray)
                            .imageScale(.large)
                    }
                    .padding(.top, 12)
            
            ForEach(categories) { category in
                           Text(category.name)
                            .padding(.top, 2)
                            .foregroundColor(.gray)
                            .font(.subheadline)
                              
                       }
                     
        Spacer()
        }.padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 32/255, green: 32/255, blue: 32/255))
                    .edgesIgnoringSafeArea(.all)

        }
    
    let categories: [Category] = [
        Category(name: "Fruit"),
        Category(name: "Vegetable"),
        Category(name: "Meat"),
        Category(name: "Fish"),
        Category(name: "Dish")
    ]
    }

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}

