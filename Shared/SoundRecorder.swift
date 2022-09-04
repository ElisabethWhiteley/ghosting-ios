//
//  SoundRecorder.swift
//  Ghosting
//
//  Created by Elisabeth Teigland Whiteley on 18/01/2022.
//

import Foundation
import Speech

class Recorder {
    
    /*
  enum RecordingState {
    case recording, paused, stopped
  }
  private var bluetoothManager = BLEManager()
  private var engine: AVAudioEngine!
  private var mixerNode: AVAudioMixerNode!
  private var state: RecordingState = .stopped
    
    

  private var audioPlayer = AVAudioPlayerNode()
  
  init() {
    setupSession()
    setupEngine()
    
  }
    
    
  fileprivate func setupSession() {
      let session = AVAudioSession.sharedInstance()
    try? session.setCategory(.playAndRecord, options: [.mixWithOthers, .defaultToSpeaker])
      try? session.setActive(true, options: .notifyOthersOnDeactivation)
   }
    
    fileprivate func setupEngine() {
      engine = AVAudioEngine()
      mixerNode = AVAudioMixerNode()

      // Set volume to 0 to avoid audio feedback while recording.
      mixerNode.volume = 0

      engine.attach(mixerNode)

    engine.attach(audioPlayer)
        
      makeConnections()

      // Prepare the engine in advance, in order for the system to allocate the necessary resources.
      engine.prepare()
    }

    
    fileprivate func makeConnections() {
       
      let inputNode = engine.inputNode
      let inputFormat = inputNode.outputFormat(forBus: 0)
        print("Input Sample Rate: \(inputFormat.sampleRate)")
      engine.connect(inputNode, to: mixerNode, format: inputFormat)
      
      let mainMixerNode = engine.mainMixerNode
      let mixerFormat = AVAudioFormat(commonFormat: .pcmFormatFloat32, sampleRate: inputFormat.sampleRate, channels: 1, interleaved: false)
    
      engine.connect(mixerNode, to: mainMixerNode, format: mixerFormat)

      let path = Bundle.main.path(forResource: "RadioStatic.mp3", ofType:nil)!
      let url = URL(fileURLWithPath: path)
      let file = try! AVAudioFile(forReading: url)
      audioPlayer.scheduleFile(file, at: nil)
      engine.connect(audioPlayer, to: mainMixerNode, format: nil)
        
        }
    
    
    //MARK: Start Recording Function
    func startRecording() throws {
        print("Start Recording!")
        self.bluetoothManager.startScanning()
      let tapNode: AVAudioNode = mixerNode
      let format = tapNode.outputFormat(forBus: 0)

     
       
      tapNode.installTap(onBus: 0, bufferSize: 4096, format: format, block: {
        (buffer, time) in

        print("BUFFER")
        print(buffer.description)
        print(buffer.stride)
       
        //Do Stuff
        print("Doing Stuff")
      })
    
      
      try engine.start()
        audioPlayer.play()
      state = .recording
    }
    
    
    //MARK: Other recording functions
    func resumeRecording() throws {
        self.bluetoothManager.startScanning()
      try engine.start()
      state = .recording
    }

    func pauseRecording() {
        self.bluetoothManager.stopScanning()
      engine.pause()
      state = .paused
    }

    func stopRecording() {
        self.bluetoothManager.stopScanning()
      // Remove existing taps on nodes
      mixerNode.removeTap(onBus: 0)
      
      engine.stop()
      state = .stopped
    }
    

    */
    
}
