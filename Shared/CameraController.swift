//
//  CameraController.swift
//  Ghosting
//
//  Created by Elisabeth Teigland Whiteley on 12/02/2022.
//

import AVFoundation
import Combine
import SwiftUI
import AVKit
import Vision
import VideoToolbox

class PreviewPixelBufferProvider: ObservableObject {

    @Published var previewPixelBuffer: (CVPixelBuffer?, Bool?)
    @Published var bojet: Bool = false

}


/// Controller of the `AVCaptureSession` that will manage the interface to the camera
/// and will publish new frames via the `previewPixelBufferProvider`.
class CameraController {
    
    let previewPixelBufferProvider = PreviewPixelBufferProvider()
    lazy private var previewPixelBufferDelegate = PreviewPixelBufferDelegate(previewPixelBufferProvider: self.previewPixelBufferProvider)

    private let captureSession = AVCaptureSession()
    private let sessionQueue = DispatchQueue(label: "Session Queue")

    private var videoDeviceInput: AVCaptureDeviceInput!
    private let videoDataOutput = AVCaptureVideoDataOutput()

    private lazy var videoOutputQueue = DispatchQueue(label: "Video Output Queue")

    #if os(iOS)
      private let orientationObserver = OrientationObserver()
      #endif

    init() {
        self.sessionQueue.async {
            self.configureSession()
        }
    }

    private func configureSession() {
        self.captureSession.beginConfiguration()
        defer { self.captureSession.commitConfiguration() }

        self.captureSession.sessionPreset = .photo

        // add video input
        do {
            var defaultVideoDevice: AVCaptureDevice?

            // default to a wide angle back camera
            if let backCameraDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) {
                defaultVideoDevice = backCameraDevice
            } else if let frontCameraDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) {
                // if the rear wide angle camera isn't available, default to the front wide angle camera
                defaultVideoDevice = frontCameraDevice
            }
            guard let videoDevice = defaultVideoDevice else {
                assertionFailure("Default video device is unavailable.")
                return
            }
            let videoDeviceInput = try AVCaptureDeviceInput(device: videoDevice)

            if self.captureSession.canAddInput(videoDeviceInput) {
                self.captureSession.addInput(videoDeviceInput)
                self.videoDeviceInput = videoDeviceInput
            } else {
                assertionFailure("Couldn't add video device input to the session.")
                return
            }
        } catch {
            assertionFailure("Couldn't create video device input: \(error)")
            return
        }

        // add the video data output; this will vend us new frames from the camera
        if self.captureSession.canAddOutput(self.videoDataOutput) {
            self.captureSession.addOutput(self.videoDataOutput)

            self.videoDataOutput.setSampleBufferDelegate(self.previewPixelBufferDelegate, queue: self.videoOutputQueue)
           
            #if os(iOS)
                       // always tell the output the current orientation
                       self.orientationObserver.$captureVideoOrientation.receive(on: self.sessionQueue).bind(to: self.videoDataOutput) { videoDataOutput, videoOrientation in
                           videoDataOutput.connection(with: .video)?.videoOrientation = videoOrientation
                       }
                       #endif
            
        } else {
            assertionFailure("Could not add video data output to the session")
            return
        }
    }


    // MARK: Capture
    func startCapturing() {
        #if !targetEnvironment(simulator)
        self.sessionQueue.async {
            self.captureSession.startRunning()
        }
        #endif
    }

    func stopCapturing() {
        self.sessionQueue.async {
            self.captureSession.stopRunning()
        }
    }

}


/// Helper for getting camera frames from the `AVCaptureVideoDataOutput` and passing them
/// to the `previewPixelBufferProvider`.
private class PreviewPixelBufferDelegate: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {

    let previewPixelBufferProvider: PreviewPixelBufferProvider

    init(previewPixelBufferProvider: PreviewPixelBufferProvider) {
        self.previewPixelBufferProvider = previewPixelBufferProvider
    }

    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        // pass new frames in the main thread since this is the interface to SwiftUI
        
        guard let model = try? VNCoreMLModel(for: Resnet50().model) else {return}
        var firstOb = ""
        var viewingObject = true;
            let request = VNCoreMLRequest(model: model) {
            (finishedReq, err) in
            // check error
           // print(finishedReq.results)
               
            guard let results = finishedReq.results as? [VNClassificationObservation] else {return}
             //   print("RESULTS: ", results)
                guard let firstObservation = results.first else {return}
                    results.forEach { result in
                        if result.identifier == "banana" && result.confidence > 0.001 {
                            viewingObject = true;
                        print(result.identifier, result.confidence)
                        }
                    }
                
                firstOb = firstObservation.identifier
                DispatchQueue.main.async {
                   
                   
                }
           //  print(firstObservation.identifier, firstObservation.confidence)
           
        }
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
        DispatchQueue.main.async {
            self.previewPixelBufferProvider.previewPixelBuffer = (pixelBuffer, viewingObject)
        }
    }

}
