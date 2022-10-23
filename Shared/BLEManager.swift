import Foundation
import CoreBluetooth

struct Peripheral: Identifiable {
    let id: Int
    let identifier: String
    let name: String
    let rssi: Int
}

class BLEManager: NSObject, ObservableObject, CBCentralManagerDelegate {

    var myCentral: CBCentralManager!
    @Published var macPeripheral = Peripheral(id: 1, identifier: "String", name: "Unknown", rssi: 1)
    @Published var peripherals: [Peripheral]
    @Published var isSwitchedOn = false
    @Published var isGhostInRange = false
    var ghostObject = "Elisabeths MacBook Pro"
    
    override init() {
        self.peripherals = []
        super.init()
       
        myCentral = CBCentralManager(delegate: self, queue: nil)
        myCentral.delegate = self
    }

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            isSwitchedOn = true
        }
        else {
            isSwitchedOn = false
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
      
     //   print("PERIPHEEAL DATA" ,peripheral)
      //  print("adv data: ", advertisementData)
      //  print("peripheral.name: ", peripheral.name)
      //  print("peripheral.identifier: ", peripheral.identifier)
      //  print("advertisementdata: ", advertisementData)
       
        let newPeripheral = Peripheral(id: peripherals.count+1, identifier: peripheral.identifier.uuidString, name: peripheral.name ?? "Unknown", rssi: RSSI.intValue)
             
              
        peripherals.append(newPeripheral)
       
      //  print(self.peripherals)
        if peripheral.name == ghostObject {
            macPeripheral = newPeripheral
          //  print(RSSI.intValue)
            
            if RSSI.intValue > -60 && RSSI.intValue < 0 {
                    // print("is in range")
                    
                     self.isGhostInRange = true
                 } else {
                   //  print("not in range")
                     self.isGhostInRange = false
                 }
             
        }
    }
    
    func scanForGhost() {
        
        if isSwitchedOn {
           // print("startScanning")
            myCentral.scanForPeripherals(withServices: nil, options: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [self] in
          
           self.myCentral.stopScan()
           // print(self.peripherals)
         
            
         
            self.scanForGhost()
        }
        } else {
            self.myCentral.stopScan()
        }
           
        }
    
    func startScanning() {
     //   print("start scanning")
        isSwitchedOn = true
        scanForGhost()
    }

    func stopScanning() {
     //   print("stop scannign")
            myCentral.stopScan()
            isGhostInRange = false
        isSwitchedOn = false
        }
}
