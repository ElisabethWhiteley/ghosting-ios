//
//  DowsingRodView.swift
//  Ghosting (iOS)
//
//  Created by Elisabeth Teigland Whiteley on 07/05/2022.
//

import SwiftUI
 
struct DowsingRodView: View {
    
    @ObservedObject var locationManager = LocationManager()
    
    var body: some View {
                VStack(alignment: .leading) {
                  
                    ZStack() {
                        Image("dowsing-rod")
                            .resizable()
                            .frame(width: 100.0, height: 700.0)
                            .foregroundColor(Color("color-divingrod"))
                            .rotationEffect(.degrees(Double(9 + (locationManager.isInGhostLocation ? 16.0 : (locationManager.angleToGhost == 0.0 ? -8.0 : locationManager.angleToGhost)))))
                            .animation(.easeIn)
                            .padding(.trailing, CGFloat(locationManager.isInGhostLocation ? 600.0 : locationManager.angleToGhost == 0.0 ? -4.0 : locationManager.angleToGhost)*(-10))
                            .offset(x: -100)
                        Image("dowsing-rod")
                            .resizable()
                            .frame(width: 100.0, height: 700.0)
                            .foregroundColor(Color("color-divingrod"))
                            .rotationEffect(.degrees(Double(9 + (locationManager.isInGhostLocation ? -16.0 : (locationManager.angleToGhost == 0.0 ? 8.0 : locationManager.angleToGhost)))))
                            .animation(.easeIn)
                            .padding(.trailing, CGFloat(locationManager.isInGhostLocation ? -14.0 : locationManager.angleToGhost == 0.0 ? 8.0 : locationManager.angleToGhost)*(-10))
                            .offset(x: 100)
                          
                    }.padding(.bottom, -90)
                
                }.onAppear {
                    self.locationManager.start()
                }
                .onDisappear {
                    self.locationManager.stop()
                }
    }
    
}

struct DowsingRodView_Previews: PreviewProvider {
    static var previews: some View {
        DowsingRodView()
    }
}

