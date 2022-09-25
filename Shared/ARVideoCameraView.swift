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
    let imagePublisher: AnyPublisher<(CIImage?, Bool?), Never>
    


    func makeUIView(context: Context) -> ARView {
       let view = ARView()
        func postProcessWithCoreImage(context: ARView.PostProcessContext) {

            // Create and configure the Core Image filter.
            let filter = CIFilter.falseColor()
            filter.color0 = CIColor.blue
            filter.color1 = CIColor.yellow

            // Convert the frame buffer from a Metal texture to a CIImage, and
            // set the CIImage as the filter's input image.
            guard let input = CIImage(mtlTexture: context.sourceColorTexture) else {
                fatalError("Unable to create a CIImage from sourceColorTexture.")
            }
            filter.setValue(input, forKey: kCIInputImageKey)

            // Get a reference to the filter's output image.
            guard let output = filter.outputImage else {
                fatalError("Error applying filter.")
            }

            // Create a render destination and render the filter to the context's command buffer.
            let destination = CIRenderDestination(mtlTexture: context.compatibleTargetTexture,
                                                  commandBuffer: context.commandBuffer)
            destination.isFlipped = false
            _ = try? self.ciContext.startTask(toRender: output, to: destination)
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
        view.publisher(self.imagePublisher)
       return view
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, ARSessionDelegate {
        weak var view: ARView?

        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
            guard let view = self.view else { return }
            debugPrint("Anchors added to the scene: ", anchors)
        }
        
        
        @objc func handleTap() {
            print("TAPPED THAT APP")
            guard let view = self.view else { return }

            // Create a new anchor to add content to
           // let anchor = AnchorEntity()
            guard let modelScene =  try? Entity.loadAnchor(named: "tulipscolored") else { return; }
        
            view.scene.anchors.append(modelScene)
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
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    init() {
        // the `filterController` will transform camera frames into filtered images
        self.filterController = FilterController(pixelBufferPublisher: self.cameraController.previewPixelBufferProvider.$previewPixelBuffer.eraseToAnyPublisher())
    }


    var body: some View {
        ZStack {
            Color.black
                       .edgesIgnoringSafeArea(.all)
            RealityKitView()
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
                                        if seconds > 9 {
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
                UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
                UIViewController.attemptRotationToDeviceOrientation()
                self.cameraController.startCapturing()

              
            }
            .onDisappear {
                self.cameraController.stopCapturing()
                AppDelegate.orientationLock = .all
                UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
               
            }
    }
}

struct ARVideoCameraView_Previews: PreviewProvider {
    static var previews: some View {
        ARVideoCameraView()
    }
}
