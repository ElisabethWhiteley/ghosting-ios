//
//  ARVideoCameraView.swift
//  Ghosting
//
//  Created by Elisabeth Teigland Whiteley on 10/07/2022.
//

import SwiftUI
import Combine
import ARKit
import RealityKit


struct RealityKitView: UIViewRepresentable {
    @State var filterBackgroundNoise: CGFloat = 0.1
    @State var filterinputSpacing: CGFloat = 50
    @EnvironmentObject private var ghostSettings: GhostSettings

  
    @State var time: TimeInterval = 0
    @State var ghostTime: Int = 0
    @State var timeUntilGhost: Int = 0
    @State var ghostIsVisible: Bool = false
    @State var timeGhostBecameVisible: TimeInterval = 0
    @State var timeGhostDisappeared: TimeInterval = 0

    @State private var ciContext: CIContext?
    @State var hasFloorAnchor: Bool = false
    @State var hasPlacedGhostAnchor: Bool = false
    @State var ghostInRange: Bool = false
    @State var pauseMe: Bool = false
    var bluetoothManager: BLEManager
    var bla: Bool
    @State var ghostOrbFilter = GhostOrbFilter()
    
    func session(_ session: ARSession, didFailWithError error: Error) {
    session.configuration?.worldAlignment = .gravity
        session.pause()
        if (session.configuration != nil) {
            session.run(session.configuration!, options: [
                
                .resetTracking,

                .removeExistingAnchors])
        }
    }
    
    func setupCoreImage(device: MTLDevice) {
        print("SETUPCOREIMAGE")

        // Create a CIContext and store it in a property.
        self.ciContext = CIContext(mtlDevice: device)
   
        ghostTime = Int.random(in: 4...9)
        timeUntilGhost = Int.random(in: 13...21)
        print("setting up core image ghosttime", ghostTime)
        print("setting up core image timeuntilghost", timeUntilGhost)
        // Do other expensive tasks, like loading images, here.
    }
    
    

    @available(iOS 15.0, *)
    func postProcessWithCoreImage(context: ARView.PostProcessContext) {
        
  //    print("variablename: ", variableName)
    /*
  
        if (Int(time) > ghostTime) {
            ghostTime = 0
            variableName = true
        }
        */
        ghostInRange = self.bluetoothManager.isGhostInRange
       // print("ghost in range: ", ghostInRange)
            guard let input = CIImage(mtlTexture: context.sourceColorTexture) else {
                fatalError("Unable to create a CIImage from sourceColorTexture.")
            }
        
        var output: CIImage?
        
        ghostOrbFilter.ghostInRange = ghostInRange
        ghostOrbFilter.inputImage = input
         output = ghostOrbFilter.outputImage
        
        
        time = context.time
 // print("orbsize: ", ghostSettings.ghostOrbSize)
    //    print("inrange: ", ghostInRange)
        if (ghostSettings.ghostOrbSize == "Small" && ghostInRange) {
            if (ghostIsVisible) {
                let vhs = VHSTrackingLines();

                    vhs.inputBackgroundNoise = vhs.inputBackgroundNoise + CGFloat(Float.random(in: -0.8...0.12))
                    vhs.inputSpacing = 50 + CGFloat(Float.random(in: -15...15))

          
              //  vhs.inputStripeHeight = vhs.inputStripeHeight + CGFloat(iteration) * CGFloat(Float.random(in: -0.8...0.2))
                vhs.inputImage = input
                 output = vhs.outputImage
                
                if (Double(ghostTime) < (context.time - Double(timeGhostBecameVisible))) {
                    ghostIsVisible = false
                    hasPlacedGhostAnchor = false
                  //   hasFloorAnchor = false
                    timeGhostBecameVisible = 0
                    timeGhostDisappeared = context.time
                    ghostTime = Int.random(in: 4...9)
                    timeUntilGhost = Int.random(in: 13...21)
                }
            } else {
                /*
                print("timeuntilghost: ", timeUntilGhost)
                print("timeGhostDisappeared: ", timeGhostDisappeared)
                print("context.time: ", context.time)
                print("(context.time - Double(timeGhostDisappeared)): ",context.time - Double(timeGhostDisappeared))
                 */
                if (Double(timeUntilGhost) < (context.time - Double(timeGhostDisappeared))) {
                    print("timeuntilghost: ", timeUntilGhost)
                    print("timeGhostDisappeared: ", timeGhostDisappeared)
                    print("context.time: ", context.time)
                    print("(context.time - Double(timeGhostDisappeared)): ",context.time - Double(timeGhostDisappeared))
                    ghostIsVisible = true
                    timeGhostBecameVisible = context.time
                    timeGhostDisappeared = 0
                }
            }
        } else {
          //  print("not in range and not orbs chosen")
            timeGhostDisappeared = context.time
        }
            let destination = CIRenderDestination(mtlTexture: context.targetColorTexture,
                                                     commandBuffer: context.commandBuffer)
            destination.isFlipped = false

    _ = try? self.ciContext?.startTask(toRender: output ?? CIImage(), to: destination)
    }
    
 

    func makeUIView(context: Context) -> ARView {
       let arView = ARView()
        if #available(iOS 15.0, *) {
            arView.renderCallbacks.prepareWithDevice = setupCoreImage
            arView.renderCallbacks.postProcess = postProcessWithCoreImage
            
  
            
        print("making ui view, ghosttime: ", ghostTime)
            
        } else {
            // Fallback on earlier versions
        }
        
     
        // Start AR session
        let session = arView.session
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        session.run(config)
      
        // Add coaching overlay
       /* let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.session = session
        coachingOverlay.goal = .horizontalPlane
        view.addSubview(coachingOverlay)
        */
        // Set debug options
       // #if DEBUG
       // view.debugOptions = [.showFeaturePoints, .showAnchorOrigins, .showAnchorGeometry]
      //  #endif
     
        // Handle ARSession events via delegate
        context.coordinator.view = arView
        session.delegate = context.coordinator
         
        
        // Handle taps
       /* view.addGestureRecognizer(
            UITapGestureRecognizer(
                target: context.coordinator,
                action: #selector(Coordinator.handleTap)
            )
        )
        */
        return arView
    }
    
    
 
    func makeCoordinator() -> Coordinator {
        Coordinator(hasPlacedGhostAnchor: self.$hasPlacedGhostAnchor, shouldShowGhost: self.$ghostIsVisible, hasFloorAnchor: self.$hasFloorAnchor)
    }
    
    
    
    class Coordinator: NSObject, ARSessionDelegate {
        weak var view: ARView?
        @Binding var hasPlacedGhostAnchor: Bool
        @Binding var shouldShowGhost: Bool
        @Binding var hasFloorAnchor: Bool
      
        init(hasPlacedGhostAnchor: Binding<Bool>, shouldShowGhost: Binding<Bool>, hasFloorAnchor: Binding<Bool>) {
                  _hasPlacedGhostAnchor = hasPlacedGhostAnchor
                  _shouldShowGhost = shouldShowGhost
            _hasFloorAnchor = hasFloorAnchor
               }

        func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
            guard let view = self.view else { return }
         //   print("pauseme: ", pauseMe)
    
                // debugPrint("Anchors added to the scene: ", anchors)
                // print("did update coordinator", variableName)
               //  print("isghostinrange", ghostInRange)
            print("has flooranchor: ", hasFloorAnchor)
            print("shouldShowGhost: ", shouldShowGhost)
            print("hasPlacedGhostAnchor", hasPlacedGhostAnchor )
                 if (!hasPlacedGhostAnchor && hasFloorAnchor && shouldShowGhost) {
                     hasPlacedGhostAnchor = true
                     print("adding ghost")
                     guard let modelScene = try? Entity.loadAnchor(named: "tulipscolored") else { return; }
                       view.scene.anchors.append(modelScene)
                     }
        }
        
        
        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
            guard let view = self.view else { return }
          //  print("vari: ", variableName)
      
            
            
            if (!anchors.isEmpty) {
               let anchor = anchors[0] as? ARPlaneAnchor
                if #available(iOS 16.0, *) {
                    if (anchor?.classification == .floor) {
                        hasFloorAnchor = true
                        print("has floor anchor")
                    }
                } else {
                    // Fallback on earlier versions
                }
            }
        }
        
        /*
        @objc func handleTap() {
            print("TAPPED THAT APP")
            guard let view = self.view else { return }

            // Create a new anchor to add content to
           // let anchor = AnchorEntity()
         //   guard let modelScene =  try? Entity.loadAnchor(named: "tulipscolored") else { return; }
        
        //    view.scene.anchors.append(modelScene)
            print("IT EXISTS")
            // Add a Box entity with a blue material
           /*  let box = MeshResource.generateBox(size: 0.5, cornerRadius: 0.05)
            let material = SimpleMaterial(color: .blue, isMetallic: true)
            let diceEntity = ModelEntity(mesh: box, materials: [material])
            print("i am being set")
            diceEntity.position = SIMD3(9.0870006e-10, -1.1317643, -1.9889111)
             
*/
           //  anchor.addChild(diceEntity)
        } */
    }
    
  

    func updateUIView(_ view: ARView, context: Context) {
      //  print("updateuiview")
        
        if (!ghostIsVisible) {
         //   print("removing ghost")
            view.scene.anchors.removeAll()
      
          //  print("removed ghost")
        }
       
     //   var hasFloorAnchor = false
   
      //  let anchors = view.scene.anchors
    /*
        print("ANCHORS: ", anchors)
        if (!anchors.isEmpty) {
            let bla = anchors[0] as? ARPlaneAnchor
            print("Anchor: ", bla)
            if #available(iOS 16.0, *) {
                if (bla.classification == .floor) {
                    print("Anchor floor: ", bla)
                    hasFloorAnchor = true
                }
            } else {
                // Fallback on earlier versions
            }
        }
        */
        /*
        if (ghostIsVisible && hasFloorAnchor) {
            print("removed", ghostTime)
            view.scene.anchors.removeAll()
       
        }
        */
   
       
    }
}


struct ARVideoCameraView: View {

    private let cameraController = CameraController()
    private let filterController: FilterController
    @State var progressValue: Float = 6
    @State var leadingMillisecondZero = "0"
    @State var leadingSecondZero = "0"
    @State var leadingMinuteZero = "0"
    @State var minutes = 0
    @State var seconds = 0
    @State var milliseconds = 0
    @State var iteration = 0
    @ObservedObject var bluetoothManager: BLEManager
    @State var bla = false
    @EnvironmentObject private var ghostSettings: GhostSettings

    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    init() {
        // the `filterController` will transform camera frames into filtered images
        self.filterController = FilterController(pixelBufferPublisher: self.cameraController.previewPixelBufferProvider.$previewPixelBuffer.eraseToAnyPublisher())
        let bleManager = BLEManager()
        self.bluetoothManager = bleManager
     
    }


    var body: some View {
        ZStack {
            Color.black
                       .edgesIgnoringSafeArea(.all)
            RealityKitView(bluetoothManager: bluetoothManager, bla: bla).onDisappear {
                bluetoothManager.stopScanning()
                bla = true
                print("disappear")
            }.onAppear{
                print("bla in view: ", bla)
                bla = false
                bluetoothManager.ghostObject = ghostSettings.ghostBluetoothObject
                bluetoothManager.startScanning()
            }
            VStack {
                HStack {
                    Text("REC").foregroundColor(Color.red).bold().padding(.leading, 30)
                    Spacer()
                    Text("W ----------- T").foregroundColor(Color.white).bold()
                    Spacer()
                    
                    Text("00:\(leadingMinuteZero)\(minutes):\(leadingSecondZero)\(seconds):\(milliseconds)0").foregroundColor(Color.white).bold()
                        .onReceive(timer) { _ in
                            
                                if milliseconds < 9 {
                                    milliseconds += 1
                                } else {
                                    milliseconds = 0
                                    if seconds < 59 {
                                        seconds += 1
                                        iteration += 1
                                        if seconds > 9 {
                                            iteration += 1
                                            leadingSecondZero = ""
                                        }
                                    } else {
                                            seconds = 0
                                        leadingSecondZero = "0"
                                        minutes += 1
                                        if minutes > 9 {
                                            leadingMinuteZero = ""
                                        }
                                    }
                                }
                            
                        }.fixedSize().frame(width: 100, height: 40, alignment: .leading).padding(.trailing, 30)
                
                    
                  
                }.padding(.top, 10)
                Spacer()
                HStack {
                    VStack {
                        Text("AUTO").foregroundColor(Color.white).bold()
                        Text("F4").foregroundColor(Color.white).bold()
                    }.padding(.leading, 30)
                    Spacer()
                    VStack {
                        Text("1080p").foregroundColor(Color.white).bold()
                  
                        Text("24.5").foregroundColor(Color.white).bold()
                    }.padding(.trailing, 30)
                }.padding(.bottom, 10)
               
            
            }
           
           
        }
       
            .onAppear {
                AppDelegate.orientationLock = UIInterfaceOrientationMask.landscapeRight
             
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                if #available(iOS 16.0, *) {
                    windowScene?.requestGeometryUpdate(.iOS(interfaceOrientations: .landscapeRight))
                } else {
                    // Fallback on earlier versions
                }
             
                UIViewController.attemptRotationToDeviceOrientation()
                self.cameraController.startCapturing()

              
            }
            .onDisappear {
                self.cameraController.stopCapturing()
                AppDelegate.orientationLock = .all
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                if #available(iOS 16.0, *) {
                    windowScene?.requestGeometryUpdate(.iOS(interfaceOrientations: .portrait))
                } else {
                    // Fallback on earlier versions
                }
             
                UIViewController.attemptRotationToDeviceOrientation()
               
            }
    }
}

struct ARVideoCameraView_Previews: PreviewProvider {
    static var previews: some View {
        ARVideoCameraView()
    }
}
