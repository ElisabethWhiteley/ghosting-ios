//
//  VideoCamera.swift
//  Ghosting
//
//  Created by Elisabeth Teigland Whiteley on 22/01/2022.
//

import Foundation
import SwiftUI
import AVKit
import Vision
import VideoToolbox


let ComicEffect = "Comic Effect"
let ComicEffectFilter = CIFilter(name: "CIComicEffect")
let imageView = UIImageView()
/*
struct VideoCamera: View {
    @State private var timer = 5
    @State private var onComplete = false
    @State private var recording = false
    
    
    var body: some View {
        ZStack {
            VideoRecordingView(timeLeft: $timer, onComplete: $onComplete, recording: $recording)
            VStack {
                Button(action: {
                    self.recording.toggle()
                }, label: {
                    Text("Toggle Recording")
                })
                    .foregroundColor(.white)
                    .padding()
                Button(action: {
                    self.timer -= 1
                    print(self.timer)
                }, label: {
                    Text("Toggle timer")
                })
                    .foregroundColor(.white)
                    .padding()
                Button(action: {
                    self.onComplete.toggle()
                }, label: {
                    Text("Toggle completion")
                })
                    .foregroundColor(.white)
                    .padding()
            }
        }
    }
    
}

struct RecordingView_Previews: PreviewProvider {
    static var previews: some View {
        VideoCamera()
    }
}


struct VideoRecordingView: UIViewRepresentable {
    
    @Binding var timeLeft: Int
    @Binding var onComplete: Bool
    @Binding var recording: Bool
    func makeUIView(context: UIViewRepresentableContext<VideoRecordingView>) -> PreviewView {
        let recordingView = PreviewView()
        recordingView.onComplete = {
            self.onComplete = true
        }
        
        recordingView.onRecord = { timeLeft, totalShakes in
            self.timeLeft = timeLeft
            self.recording = true
        }
        
        recordingView.onReset = {
            self.recording = false
            self.timeLeft = 30
        }
        return recordingView
    }
    
    func updateUIView(_ uiViewController: PreviewView, context: UIViewRepresentableContext<VideoRecordingView>) {
        
    }
}

extension PreviewView: AVCaptureFileOutputRecordingDelegate{
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        print(outputFileURL.absoluteString)
    }
}

class PreviewView: UIView, AVCaptureVideoDataOutputSampleBufferDelegate {
    private var captureSession: AVCaptureSession?
    private var shakeCountDown: Timer?
    let videoFileOutput = AVCaptureMovieFileOutput()
    var recordingDelegate:AVCaptureFileOutputRecordingDelegate!
    var recorded = 0
    var secondsToReachGoal = 30
    
    var onRecord: ((Int, Int)->())?
    var onReset: (() -> ())?
    var onComplete: (() -> ())?
    
    init() {
        super.init(frame: .zero)
        
        var allowedAccess = false
        let blocker = DispatchGroup()
        blocker.enter()
        AVCaptureDevice.requestAccess(for: .video) { flag in
            allowedAccess = flag
            blocker.leave()
        }
        blocker.wait()
        
        if !allowedAccess {
            print("!!! NO ACCESS TO CAMERA")
            return
        }
        
        // setup session
        let session = AVCaptureSession()
        session.beginConfiguration()
        
        let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                  for: .video, position: .back)
        guard videoDevice != nil, let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice!), session.canAddInput(videoDeviceInput) else {
            print("!!! NO CAMERA DETECTED")
            return
        }
        session.addInput(videoDeviceInput)
        session.commitConfiguration()
        self.captureSession = session
    }
    
    override class var layerClass: AnyClass {
        AVCaptureVideoPreviewLayer.self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        return layer as! AVCaptureVideoPreviewLayer
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        recordingDelegate = self
        startTimers()
        if nil != self.superview {
            self.videoPreviewLayer.session = self.captureSession
            self.videoPreviewLayer.videoGravity = .resizeAspectFill
            self.captureSession?.startRunning()
            
            let dataOutput = AVCaptureVideoDataOutput()
            dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
            captureSession?.addOutput(dataOutput)
            print("Camera set up with dataoutput stuff")
            //self.startRecording()
        } else {
            self.captureSession?.stopRunning()
        }
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        print("Camera was able to capture a frame", Date())
        
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {return}
        let cameraImage = CIImage(cvPixelBuffer: pixelBuffer)
        
        ComicEffectFilter!.setValue(cameraImage, forKey: kCIInputImageKey)
                
        let filteredImage = UIImage(ciImage: ComicEffectFilter?.value(forKey: kCIOutputImageKey) as! CIImage)
                
        DispatchQueue.main.async {
                
                    imageView.image = filteredImage
                }
        
        var picture: CGImage?
           VTCreateCGImageFromCVPixelBuffer(pixelBuffer, options: nil, imageOut: &picture)
       
           // 2
        var ciImage = CIImage(cgImage: picture!)
           // 3

             ciImage = ciImage.applyingFilter("CIComicEffect")
           
        
        
        
        guard let model = try? VNCoreMLModel(for: Resnet50().model) else {return}
        let request = VNCoreMLRequest(model: model) {
            (finishedReq, err) in
            // check error
           // print(finishedReq.results)
            
            guard let results = finishedReq.results as? [VNClassificationObservation] else {return}
            guard let firstObservation = results.first else {return}
            print(firstObservation.identifier, firstObservation.confidence)
        }
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
    }
    
    private func onTimerFires(){
       // print("🟢 RECORDING \(videoFileOutput.isRecording)")
        secondsToReachGoal -= 1
        recorded += 1
        onRecord?(secondsToReachGoal, recorded)
        
        if(secondsToReachGoal == 0){
            stopRecording()
            shakeCountDown?.invalidate()
            shakeCountDown = nil
            onComplete?()
            videoFileOutput.stopRecording()
        }
    }
    
    func startTimers(){
        if shakeCountDown == nil {
            shakeCountDown = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] (timer) in
                self?.onTimerFires()
            }
        }
    }
    
    func startRecording(){
        captureSession?.addOutput(videoFileOutput)
        
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let filePath = documentsURL.appendingPathComponent("tempPZDC")
        
        videoFileOutput.startRecording(to: filePath, recordingDelegate: recordingDelegate)
    }
    
    func stopRecording(){
        videoFileOutput.stopRecording()
       // print("🔴 RECORDING \(videoFileOutput.isRecording)")
    }
}
*/
