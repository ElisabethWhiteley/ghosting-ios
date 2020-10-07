//
//  Achievement.swift
//  GreenEggs
//
//  Created by Elisabeth Whiteley on 07/10/2020.
//

import SwiftUI
 
struct Achievement: View {
    var isInProgress: Bool = true
    @State var progressValue: Float = 6
    var body: some View {
        
   
     
            
            VStack {
                VStack {
                    HStack(alignment: .top) {
                        Text("Vegetable Lover")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.vertical, 10)
                            .padding(.leading, 8)
                        Spacer()

                        ZStack {
                            Image(systemName: "star.fill").foregroundColor(.yellow) .font(.system(size: 50))
                            Text("25").bold().padding(.top, 4)                        }
                       
                    }
                    HStack {
                        
                        Text("You've tasted 10 vegetables. Good job!").padding(.leading, 12).padding(.bottom, 6).padding(.top, -16).padding(.trailing, 40).fixedSize(horizontal: false, vertical: true)
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        if isInProgress {
                            
                            SegmentedProgressView().padding(.trailing,6)
                                .padding(.bottom,6)
                                
                        } else {
                            Text("03/10/2020").padding(.trailing, 6).padding(.bottom, 6)
                        }
                    }
                }.padding(6).background(Color("color-light-yellow"))
               
            }.cornerRadius(12)
           
            
   
       
    }
  
   
}

struct Achievement_Previews: PreviewProvider {
    static var previews: some View {
        Achievement()
    }
}

