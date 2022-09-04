//
//  ContentView.swift
//  Shared
//
//  Created by Elisabeth Whiteley on 29/08/2020.
//

import SwiftUI

struct ContentView: View {
   init(){
    UITableView.appearance().backgroundColor = UIColor(Color.clear)
    UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        
        NavigationView {
            Main()
          
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
