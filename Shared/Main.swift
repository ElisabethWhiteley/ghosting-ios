//
//  Main.swift
//  Shared
//
//  Created by Elisabeth Whiteley on 29/08/2020.
//

import SwiftUI


struct Main: View {
    
    @Binding var showMenu: Bool
    @State private var searchText = ""
    @EnvironmentObject var data: Data
    var body: some View {
        HStack() {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    NavigationLink(destination: AddFood()) {
                    Image(systemName: "plus.circle.fill").foregroundColor(.green)
                        .font(.system(size: 50)).padding(.top, 10)
                    }
                    Spacer()
                }
               
                SearchBar(text: $searchText)
                    .padding(.top, 10)
                FoodList(searchText: searchText).padding(-30)
            }
        }        
    }
}
