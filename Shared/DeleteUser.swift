//
//  DeleteUser.swift
//  GreenEggs
//
//  Created by Elisabeth Whiteley on 22/09/2020.
//

import SwiftUI

struct DeleteUser: View {
    @Binding var showModal: Bool
       
       var body: some View {
           VStack {
               Text("Are you sure you want to delete this taster?")
                   .padding()
               // 2.
               Button("Nope") {
                   self.showModal.toggle()
               }
            
            Button("Yes") {
                self.showModal.toggle()
            }
           }
       }
   }

