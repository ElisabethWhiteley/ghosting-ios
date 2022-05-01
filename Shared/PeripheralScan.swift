//
//  PeripheralScan.swift
//  Ghosting
//
//  Created by Elisabeth Whiteley on 16/03/2022.
//

import SwiftUI
 
struct PeripheralScan: View {
    @State private var isPoweredOn = false
  
    @ObservedObject var bleManager = BLEManager()
    
    var body: some View {
        Color.black
               .ignoresSafeArea()
            .overlay(
        VStack {
            VStack {
              
                HStack {
                    Spacer()

                    
                    VStack {
                        Spacer()
                        Button(action: {
                            if isPoweredOn {
                                isPoweredOn = false
                                self.bleManager.stopScanning()
                            }
                           else {
                                isPoweredOn = true
                            self.bleManager.startScanning()
                            
                            }
                        }) {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(isPoweredOn ? Color.green : Color.red)
                                .frame(width: 50, height: 22)
                        }
                       
                        Text("POWER").fontWeight(.semibold).font(.system(size: 12)).frame(width: 60, height: 30).padding(.top, -6)
                    }
                   
                  Spacer()
                }.padding(.top, -12)
               Spacer()
                List(bleManager.peripherals) { peripheral in
                               HStack {
                                Text(peripheral.identifier)
                                   Spacer()
                                Text(peripheral.name)
                                   Spacer()
                                   Text(String(peripheral.rssi))
                               }
                           }.frame(height: 300)
              
                
            }.background(
                LinearGradient(gradient: Gradient(colors: [Color("color-spiritbox-greyLight"), Color("color-spiritbox-greyDark")]), startPoint: .leading, endPoint: .trailing)
            )
            .cornerRadius(12)
            .padding(.horizontal, 20)
            .frame(maxHeight: 400)
            
            Spacer()
        }.background(Color.black)
    )}
    
}

struct PeripheralScan_Previews: PreviewProvider {
    static var previews: some View {
        PeripheralScan()
    }
}
