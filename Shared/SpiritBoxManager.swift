//
//  SpiritBoxManager.swift
//  Ghosting
//
//  Created by Elisabeth Teigland Whiteley on 22/01/2022.
//

import Foundation

class SpiritBoxManager: NSObject, ObservableObject {
    enum SpiritBoxResponseState {
      case notRecognized, recognized, responding
    }
    
    private var soundManager = SoundManager()
    private var bluetoothManager = BLEManager()
    @Published var isSpiritBoxOn = false
    @Published var responseState: SpiritBoxResponseState = .notRecognized

    
    func togglePowerButton(ghostObject: String) {
        if isSpiritBoxOn {
            isSpiritBoxOn = false
            bluetoothManager.stopScanning()
            soundManager.stopSpiritBox()
        } else {
            isSpiritBoxOn = true
            bluetoothManager.ghostObject = ghostObject
            bluetoothManager.startScanning()
            soundManager.startSpiritBox(ghostObject: ghostObject)
        }
    }
}
