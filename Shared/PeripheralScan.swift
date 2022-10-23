//
//  PeripheralScan.swift
//  Ghosting
//
//  Created by Elisabeth Whiteley on 16/03/2022.
//

import SwiftUI
 
struct PeripheralScan: View {
    @State private var isPoweredOn = false
    @State private var ghostObject: String = ""
    @State private var latitude: String = ""
    @State private var longitude: String = ""
    @State private var password = ""
    @ObservedObject var bleManager = BLEManager()
    @EnvironmentObject private var ghostSettings: GhostSettings
    
    var body: some View {
        Color.black
               .ignoresSafeArea()
            .overlay(
                VStack {
                if (password == "Lazy" || password == "lazy") {
                
                    TextField("Ghost object", text: $ghostObject)
                                  .textFieldStyle(.roundedBorder)
                                  .padding(6).padding(.top, 0)
                    TextField("Latitude", text: $latitude)
                                  .textFieldStyle(.roundedBorder)
                                  .padding(6)
                    TextField("Longitude", text: $longitude)
                                  .textFieldStyle(.roundedBorder)
                                  .padding(6)
                  
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
                                       self.bleManager.ghostObject = ghostSettings.ghostBluetoothObject
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
                      
                        
                    }.padding(.top, -36).background(
                        LinearGradient(gradient: Gradient(colors: [Color("color-spiritbox-greyLight"), Color("color-spiritbox-greyDark")]), startPoint: .leading, endPoint: .trailing)
                    )
                    .cornerRadius(12)
                    .padding(.horizontal, 20)
                    .frame(maxHeight: 400)
                    
                    Spacer()
                } else {
                    TextField("Password", text: $password)
                                  .textFieldStyle(.roundedBorder)
                                  .padding(6).padding(.top, 0)
                }
     
 
        }.background(Color.black).onDisappear {
            password = ""
            if (ghostObject != "") {
                ghostSettings.ghostBluetoothObject = ghostObject
            }
            
            if (latitude != "") {
                ghostSettings.latitude = Double(latitude) ?? 0
            }
            
            if (longitude != "") {
                ghostSettings.longitude = Double(longitude) ?? 0
            }
        }
            )}
    
}

struct PeripheralScan_Previews: PreviewProvider {
    static var previews: some View {
        PeripheralScan()
    }
}
