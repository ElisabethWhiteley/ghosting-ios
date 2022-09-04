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
    func makeUIView(context: Context) -> ARView {
       let view = ARView()
        /*
        // Start AR session
        let session = view.session
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        session.run(config)
      
        // Add coaching overlay
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.session = session
        coachingOverlay.goal = .horizontalPlane
        view.addSubview(coachingOverlay)
        
        // Set debug options
       // #if DEBUG
       // view.debugOptions = [.showFeaturePoints, .showAnchorOrigins, .showAnchorGeometry]
      //  #endif
     
        // Handle ARSession events via delegate
        context.coordinator.view = view
        session.delegate = context.coordinator
         */
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
        Coordinator()
    }
    
    class Coordinator: NSObject, ARSessionDelegate {
        weak var view: ARView?

        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
            guard let view = self.view else { return }
            debugPrint("Anchors added to the scene: ", anchors)
        }
        
        
        @objc func handleTap() {
            guard let view = self.view else { return }

            // Create a new anchor to add content to
            let anchor = AnchorEntity()
            view.scene.anchors.append(anchor)

            // Add a Box entity with a blue material
            let box = MeshResource.generateBox(size: 0.5, cornerRadius: 0.05)
            let material = SimpleMaterial(color: .blue, isMetallic: true)
            let diceEntity = ModelEntity(mesh: box, materials: [material])
            print("i am being set")
            diceEntity.position = SIMD3(9.0870006e-10, -1.1317643, -1.9889111)

            anchor.addChild(diceEntity)
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
        
        RealityKitView()
            .ignoresSafeArea()
        
       
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
