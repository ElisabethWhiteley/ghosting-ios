//
//  SpiritBoxDisplayView.swift
//  Ghosting
//
//  Created by Elisabeth Whiteley on 16/03/2022.
//

import SwiftUI

struct SpiritBoxDisplayView: View {
    var isRecording: Bool
    var showX: Bool
    var showGhost: Bool

    @State var progressValue: Float = 6
    @State var leadingRadioText = "0"
    @State var seconds = 68
    @State var milliseconds = 4
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            VStack {
                HStack(alignment: .top) {
                    Image("microphone")
                        .resizable()
                        .frame(width: 15.0, height: 15.0)
                        .padding(.leading, 6)
                        .padding(.top, 4)
                    Text("FM")
                        .font(.title3)
                        .padding(.leading, -4)
                    Spacer()
                    Text("100")
                   .font(Font.custom("digital-7", size: 24))
                        .padding(.top, 4)
                    Text("ms")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                        .padding(.top, 2)
                        .padding(.leading, -8)
                       
                   
                    Spacer()
                    Image("charge")
                        .resizable()
                        .frame(width: 30.0, height: 20.0)
                        .padding(.top, 2)
                }.padding(.bottom, 10)
                HStack {
                    Text("\(leadingRadioText)\(seconds).\(milliseconds)0")
                        .onReceive(timer) { _ in
                            if isRecording {
                                if milliseconds < 9 {
                                    milliseconds += 1
                                } else {
                                    milliseconds = 0
                                    if seconds < 999 {
                                        if seconds == 99 {
                                            leadingRadioText = ""
                                        }
                                        seconds += 1
                                    } else {
                                        seconds = 0
                                    }
                                }
                            }
                        }.fixedSize().frame(width: 250, height: 100, alignment: .leading).font(Font.custom("digital-7", size: 94)).padding(.leading, 0).padding(.bottom, -4).padding(.top, -14).padding(.trailing, 0).fixedSize(horizontal: true, vertical: true)
                
                    VStack {
                
                        Text("MHz").padding(.trailing, 8)
                           Spacer()
                    }
                    
                }
            }.padding(10).background(Color("color-spiritbox-screen"))
            
        }.border(Color.black, width: 6).cornerRadius(12).foregroundColor(isRecording ? Color.black : Color("color-spiritbox-screen"))
    }
}

struct SpiritBoxDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        SpiritBoxDisplayView(isRecording: true, showX: false, showGhost: false)
    }
}

