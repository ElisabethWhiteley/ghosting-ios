//
//  Achievement.swift
//  GreenEggs
//
//  Created by Elisabeth Whiteley on 07/10/2020.
//

import SwiftUI

struct AchievementView: View {
    var isInProgress: Bool
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
                        Image(systemName: isInProgress ? "star" : "star.fill").foregroundColor(.yellow) .font(.system(size: 50))
                        Text("25").bold().padding(.top, 4)                        }
                    
                }
                HStack {
                    
                    Text("Taste 10 different vegetables.").padding(.leading, 10).padding(.bottom, 6).padding(.top, -16).padding(.trailing, 40).fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }
                HStack {
                    Spacer()
                    if isInProgress {
                        SegmentedProgressView().padding(.trailing,6)
                            .padding(.bottom,6)
                    } else {
                        Text("Achieved 03/10/2020").padding(.trailing, 6).padding(.bottom, 4)
                    }
                }
            }.padding(6).background(Color(isInProgress ? "yellow-light" : "color-light-yellow"))
            
        }.cornerRadius(12)
    }
}

struct Achievement_Previews: PreviewProvider {
    static var previews: some View {
        AchievementView(isInProgress: true)
    }
}

