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
       
    @State var time: TimeInterval = 0
    @State var ghostTime: Int = 0
    @State var ghostIsVisible: Bool = false
        
    @State private var ciContext: CIContext?
    
    @State var variableName: Bool = false
    @State var ghostInRange: Bool = false
    
    var bluetoothManager: BLEManager
    
    func setupCoreImage(device: MTLDevice) {
        // Create a CIContext and store it in a property.
        self.ciContext = CIContext(mtlDevice: device)
   
        ghostTime = Int.random(in: 4...9)
        print("setting up core image", ghostTime)
      
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
            guard let input = CIImage(mtlTexture: context.sourceColorTexture) else {
                fatalError("Unable to create a CIImage from sourceColorTexture.")
            }
     
            
            let vhs = VHSTrackingLines();
           
                vhs.inputBackgroundNoise = vhs.inputBackgroundNoise + CGFloat(Float.random(in: -0.8...0.12))
                vhs.inputSpacing = 50 + CGFloat(Float.random(in: -15...15))

         
            
          
            
          
            time = context.time
          //  vhs.inputStripeHeight = vhs.inputStripeHeight + CGFloat(iteration) * CGFloat(Float.random(in: -0.8...0.2))
            vhs.inputImage = input
            let output = vhs.outputImage
     
            let destination = CIRenderDestination(mtlTexture: context.targetColorTexture,
                                                     commandBuffer: context.commandBuffer)
            destination.isFlipped = false

    _ = try? self.ciContext?.startTask(toRender: variableName ? (output ?? CIImage()) : input, to: destination)
    
       
    }
    
 

    func makeUIView(context: Context) -> ARView {
       let view = ARView()
        if #available(iOS 15.0, *) {
            view.renderCallbacks.prepareWithDevice = setupCoreImage
            view.renderCallbacks.postProcess = postProcessWithCoreImage
            
  
            
        print("making ui view, ghosttime: ", ghostTime)
            
        } else {
            // Fallback on earlier versions
        }
        
     
        // Start AR session
        let session = view.session
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
        context.coordinator.view = view
        session.delegate = context.coordinator
         
        
        // Handle taps
        view.addGestureRecognizer(
            UITapGestureRecognizer(
                target: context.coordinator,
                action: #selector(Coordinator.handleTap)
            )
        )
        
       return view
    }
    
    
 
    func makeCoordinator() -> Coordinator {
        Coordinator(variableName: self.$variableName, ghostInRange: self.$ghostInRange)
    }
    
    
    
    class Coordinator: NSObject, ARSessionDelegate {
        weak var view: ARView?
        @Binding var variableName: Bool
        @Binding var ghostInRange: Bool
        var isGhostVis: Bool = false
        var hasFloorAnchor: Bool = false
      
        init(variableName: Binding<Bool>, ghostInRange: Binding<Bool>) {
                  _variableName = variableName
                  _ghostInRange = ghostInRange
               }

        func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
            guard let view = self.view else { return }
           // debugPrint("Anchors added to the scene: ", anchors)
            print("did update coordinator", variableName)
            print("isghostinrange", ghostInRange)
            if (!isGhostVis && hasFloorAnchor && !variableName && ghostInRange) {
                isGhostVis = true
                variableName = true
                print("adding ghost")
                guard let modelScene =  try? Entity.loadAnchor(named: "tulipscolored") else { return; }
          
                  view.scene.anchors.append(modelScene)
                }
     
         
        }
        
        
        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
            guard let view = self.view else { return }
           // debugPrint("Anchors added to the scene: ", anchors)
            print("vari: ", variableName)
      
            
            
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
        }
    }
    
  

    func updateUIView(_ view: ARView, context: Context) {
        print("updateuiview")
        var hasFloorAnchor = false
        let anchors = view.scene.anchors
    
        print("ANCHORS: ", anchors)
        if (!anchors.isEmpty) {
            let bla =  anchors[0]
            print("Anchor: ", bla)
            if #available(iOS 16.0, *) {
               // if (bla.classification == .floor) {
               //     print("Anchor floor: ", bla)
              //      hasFloorAnchor = true
             //   }
            } else {
                // Fallback on earlier versions
            }
        }
        
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
    @ObservedObject var bluetoothManager = BLEManager()
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    init() {
        // the `filterController` will transform camera frames into filtered images
        self.filterController = FilterController(pixelBufferPublisher: self.cameraController.previewPixelBufferProvider.$previewPixelBuffer.eraseToAnyPublisher())
    }


    var body: some View {
        ZStack {
            Color.black
                       .edgesIgnoringSafeArea(.all)
            RealityKitView(bluetoothManager: bluetoothManager).onDisappear {
                bluetoothManager.stopScanning()
            }.onAppear{
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
