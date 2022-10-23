//
//  SpiritBoxView.swift
//  Ghosting
//
//  Created by Elisabeth Whiteley on 16/03/2022.
//

import SwiftUI
 
struct SpiritBoxView: View {
    @State private var isPoweredOn = false
    @EnvironmentObject private var ghostSettings: GhostSettings

    @ObservedObject var soundManager = SoundManager()
    
    var body: some View {
        Color.black
               .ignoresSafeArea()
            .overlay(
        VStack {
            VStack {
                HStack {
                    Spacer()
                    Text("P-SB7T   Spirit Box").font(.title2).bold().padding(.top, 10)
                  Spacer()
                }
                SpiritBoxDisplayView(isRecording: soundManager.isRecording, showX: soundManager.responseState == .recognized, showGhost: soundManager.responseState == .responding).padding(.horizontal, 6)
                
                HStack {
                    Spacer()
                    HStack {
                        Circle()
                            .fill(soundManager.isRecording ? Color( "color-spiritbox-screen") : Color.black)
                            .frame(width: 8, height: 8)
                            .overlay(Circle().stroke(LinearGradient(gradient: Gradient(colors: [.black, .white]), startPoint: .top, endPoint: .bottom), lineWidth: 2))
                        Text("POWER").bold()
                    }
                  Spacer()
                    HStack {
                        Circle()
                        .fill(Color.black)
                        .frame(width: 8, height: 8)
                            .overlay(Circle().stroke(LinearGradient(gradient: Gradient(colors: [.black, .white]), startPoint: .top, endPoint: .bottom), lineWidth: 2))
                        Text("TEMP").bold()
                    }
                  Spacer()
                }.padding(.vertical, 10)
                HStack {
                    Spacer()
                    VStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.black)
                            .frame(width: 50, height: 22)
                            .shadow(color: .black, radius: 1, x: -1, y: 1)
                        Text("SWEEP RATE").fontWeight(.semibold).font(.system(size: 12)).frame(width: 60, height: 30).padding(.top, -6)
                    }
                   
                  Spacer()
                    VStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.black)
                            .frame(width: 50, height: 22)
                            .shadow(color: .black, radius: 1, x: -1, y: 1)
                        Text("SWEEP FWD").fontWeight(.semibold).font(.system(size: 12)).frame(width: 60, height: 30).padding(.top, -6)
                    }
                   Spacer()
                    VStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.black)
                            .frame(width: 50, height: 22)
                            .shadow(color: .black, radius: 1, x: -1, y: 1)
                        Text("VOL +").fontWeight(.semibold).font(.system(size: 12)).frame(width: 60, height: 30).padding(.top, -6)
                    }
                   Spacer()
                    VStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.black)
                            .frame(width: 50, height: 22)
                            .shadow(color: .black, radius: 1, x: -1, y: 1)
                        Text("TEMP AM/FM").fontWeight(.semibold).font(.system(size: 12)).frame(width: 60, height: 30).padding(.top, -6)
                    }
                   
                  Spacer()
                }.padding(.top, 0)
                
                HStack {
                    Spacer()
                    VStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.black)
                            .frame(width: 50, height: 22)
                            .padding(.top, 20)
                            .shadow(color: .black, radius: 1, x: -1, y: 1)
                        Text("BACK LIGHT LAMP").fontWeight(.semibold).font(.system(size: 12)).frame(width: 60, height: 50).padding(.top, -6)
                    }
                   
                  Spacer()
                    VStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.black)
                            .frame(width: 50, height: 22)
                            .shadow(color: .black, radius: 1, x: -1, y: 1)
                        Text("SWEEP REV").fontWeight(.semibold).font(.system(size: 12)).frame(width: 60, height: 30).padding(.top, -6)
                    }
                   Spacer()
                    VStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.black)
                            .frame(width: 50, height: 22)
                            .shadow(color: .black, radius: 1, x: -1, y: 1)
                        Text("VOL -").fontWeight(.semibold).font(.system(size: 12)).frame(width: 60, height: 30).padding(.top, -6)
                    }
                   Spacer()
                    
                    VStack {
                        Button(action: {
                            if isPoweredOn {
                                isPoweredOn = false
                                soundManager.stopSpiritBox()
                            }
                           else {
                                isPoweredOn = true
                               self.soundManager.startSpiritBox(ghostObject: ghostSettings.ghostBluetoothObject)
                            
                            }
                        }) {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color.black)
                                .frame(width: 50, height: 22)
                                .shadow(color: .black, radius: 1, x: -1, y: 1)
                        }
                       
                        Text("POWER").fontWeight(.semibold).font(.system(size: 12)).frame(width: 60, height: 30).padding(.top, -6)
                    }
                   
                  Spacer()
                }.padding(.top, -12)
               Spacer()
               
              
                
            }.background(
                LinearGradient(gradient: Gradient(colors: [Color("color-spiritbox-greyLight"), Color("color-spiritbox-greyDark")]), startPoint: .leading, endPoint: .trailing)
            )
            .cornerRadius(12)
            .padding(.horizontal, 20)
            .frame(maxHeight: 400)
            
            Spacer()
        }.background(Color.black)
            .onDisappear {
                isPoweredOn = false
                soundManager.stopSpiritBox()
               
            }
    )}
       
        
    
}

struct SpiritBoxView_Previews: PreviewProvider {
    static var previews: some View {
        SpiritBoxView()
    }
}
