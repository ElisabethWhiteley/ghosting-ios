//
//  Main.swift
//  Shared
//
//  Created by Elisabeth Whiteley on 29/08/2020.
//

import SwiftUI


struct Main: View {
    
   // @Binding var showMenu: Bool
    @State private var searchText = ""
    @EnvironmentObject var data: Data
    var body: some View {
        HStack() {
            VStack(alignment: .leading) {
               
                HStack {
                    Spacer()
                
                    NavigationLink(destination: AddFood()) {
                        Text("I've tasted something new!")
                            .fontWeight(.bold)
                            .padding(.horizontal, 25)
                            .padding(.vertical, 15)
                            .background(Color.green)
                            .cornerRadius(40)
                            .foregroundColor(.black)
                            
                    }.padding(.vertical, 10)
                   
                    
                   
                    Spacer()
                }
               
                SearchBar(text: $searchText)
                    .padding(.top, 10)
                FoodList(searchText: searchText).padding(-30)
            }
        }.navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                HStack {
                    Image("icon-greeneggs")
                        .resizable()
                        .frame(width: 42.0, height: 42.0)
                     
                    Text("Green Eggs").font(.largeTitle)
                }
            }
        }
        .navigationBarItems(trailing:
                                NavigationLink(destination: Users()) {
                                    Image(systemName: "person.crop.circle.fill").foregroundColor(.blue).font(.system(size: 42))
                                      
                                }
                    )
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
