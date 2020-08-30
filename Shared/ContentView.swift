//
//  ContentView.swift
//  Shared
//
//  Created by Elisabeth Whiteley on 29/08/2020.
//

import SwiftUI


struct Food: Identifiable {
    var id = UUID()
    var name: String
    var category: String
    var attempts: Int
    var rating: Int
}

struct ContentView: View {
    init(){
           UITableView.appearance().backgroundColor = .clear
     
       }
    @State private var searchText = ""
    
    var body: some View {
        HStack() {
            VStack(alignment: .leading) {
                SearchBar(text: $searchText)
                    .padding(.top, 10)
                FoodList(searchText: searchText).padding(-10)
            
             
            }
            
        }
        
    }
    
   
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
