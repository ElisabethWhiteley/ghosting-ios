//
//  SoundManager.swift
//  Ghosting
//
//  Created by Elisabeth Teigland Whiteley on 16/01/2022.
//

import Foundation
import AVFoundation
import Speech


extension StringProtocol { // for Swift 4 you need to add the constrain `where Index == String.Index`
    var byWords: [SubSequence] {
        var byWords: [SubSequence] = []
        enumerateSubstrings(in: startIndex..., options: .byWords) { _, range, _, _ in
            byWords.append(self[range])
        }
        return byWords
    }
}

class SoundManager: NSObject, ObservableObject, SFSpeechRecognizerDelegate {
    enum RecordingState {
       case recording, paused, stopped
     }
    enum SpiritBoxResponseState {
      case notRecognized, recognized, responding
    }
    private var engine: AVAudioEngine!
     private var mixerNode: AVAudioMixerNode!
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer()
    private var request: SFSpeechAudioBufferRecognitionRequest
    var recognitionTask: SFSpeechRecognitionTask?
     private var state: RecordingState = .stopped
    private var audioPlayer = AVAudioPlayerNode()
    private var ghostResponsePlayer = [AVAudioPlayerNode]()
    private var bluetoothManager = BLEManager()
    // Array to store the note URLs
        var ghostSoundsFileURL = [URL]()

        // One audio file per note
        var ghostSoundsAudioFile = [AVAudioFile]()

        // One audio buffer per note
        var ghostSoundsAudioFileBuffer = [AVAudioPCMBuffer]()
    
    
    @Published var authStatus = SFSpeechRecognizerAuthorizationStatus.notDetermined
    @Published var isRecording = false
    @Published var responseState: SpiritBoxResponseState = .notRecognized
    @Published var macPeripheral = Peripheral(id: 1, identifier: "String", name: "Unknown", rssi: 1)
     
    let threeWordPhrases = ["are you here", "can you speak", "can we speak", "are you waiting", "are you happy", "shall we leave", "where are you"]
    
    let fourWordPhrases = ["are there any ghosts", "may i ask you", "can i ask you", "is this your home", "give us a sign", "do something"]
    
    let fiveWordPhrases = ["can you speak to us", "is there anyone with me", "would you like to talk", "are you male or female", "can you make a sound", "can you speak to us"]
    
    override init() {
        self.request = SFSpeechAudioBufferRecognitionRequest()
        super.init()
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
        for i in 0...4
        {
            ghostResponsePlayer.append(AVAudioPlayerNode())
            engine.attach(ghostResponsePlayer[i])
            // audioEngine code
        }
       print("APPENDED PLAYER NODES")
        
      //  engine.attach(ghostResponsePlayer)
         makeConnections()

         // Prepare the engine in advance, in order for the system to allocate the necessary resources.
         engine.prepare()
       }

       
       fileprivate func makeConnections() {
          
         let inputNode = engine.inputNode
         let inputFormat = inputNode.outputFormat(forBus: 0)
         engine.connect(inputNode, to: mixerNode, format: inputFormat)
         
         let mainMixerNode = engine.mainMixerNode
         let mixerFormat = AVAudioFormat(commonFormat: .pcmFormatFloat32, sampleRate: inputFormat.sampleRate, channels: 1, interleaved: false)
       
         engine.connect(mixerNode, to: mainMixerNode, format: mixerFormat)

        
         let path = Bundle.main.path(forResource: "Static.mp3", ofType:nil)!
         let url = URL(fileURLWithPath: path)
         let file = try! AVAudioFile(forReading: url)
        
        let audioFileBuffer = AVAudioPCMBuffer(pcmFormat: file.processingFormat, frameCapacity: AVAudioFrameCount(file.length))
       try! file.read(into: audioFileBuffer!, frameCount: AVAudioFrameCount(file.length))
        audioPlayer.scheduleBuffer(audioFileBuffer!, at: nil, options:.loops, completionHandler: nil)
       
        
        
        
        let ghostResponsePaths: [String] = [
            Bundle.main.path(forResource: "womanAway.mp3", ofType: nil)!,
            Bundle.main.path(forResource: "womanAway.mp3", ofType: nil)!,
            Bundle.main.path(forResource: "womanBehindYou2.mp3", ofType: nil)!,
            Bundle.main.path(forResource: "womanImHere.mp3", ofType: nil)!,
            Bundle.main.path(forResource: "womanImClose.mp3", ofType: nil)!]
        
        for i in 0...4
                    {
            ghostSoundsFileURL.append(URL(fileURLWithPath: ghostResponsePaths[i]))
                        // Read the corresponding url into the audio file
                        try! ghostSoundsAudioFile.append(AVAudioFile(forReading: ghostSoundsFileURL[i]))

                        // Read data from the audio file, and store it in the correct buffer
                        let ghostSoundsAudioFormat = ghostSoundsAudioFile[i].processingFormat

                        let ghostSoundsAudioFrameCount = UInt32(ghostSoundsAudioFile[i].length)

            ghostSoundsAudioFileBuffer.append(AVAudioPCMBuffer(pcmFormat: ghostSoundsAudioFormat, frameCapacity: ghostSoundsAudioFrameCount)!)

                        // Read the audio file into the buffer
                        try! ghostSoundsAudioFile[i].read(into: ghostSoundsAudioFileBuffer[i])
                    }
        
        
        
        
        
        
        
        for i in 0...4
                    {
                        engine.attach(ghostResponsePlayer[i])

                        engine.connect(ghostResponsePlayer[i], to: mainMixerNode, fromBus: 0, toBus: (i+1), format: ghostSoundsAudioFileBuffer[i].format)
                    }
        
        
        engine.connect(audioPlayer, to: mainMixerNode, fromBus: 0, toBus: 1, format: nil)
           }
       
       
       //MARK: Start Recording Function
       func startRecording() {
           print("Start Recording!")
        self.bluetoothManager.startScanning()
         isRecording = true
        let tapNode: AVAudioNode = mixerNode
        let format = tapNode.outputFormat(forBus: 0)
        tapNode.installTap(onBus: 0, bufferSize: 4096, format: format, block: {
          (buffer, time) in
            self.request.append(buffer)
        })
          
         
       
         
        do {
         try engine.start()
            
        }
        catch
        {
        }
           audioPlayer.play()
         state = .recording
        
        
        guard let myRecognizer = SFSpeechRecognizer() else {
            return
        }
        if !myRecognizer.isAvailable {
            return
        }
        startSpeechRecognition()
       }

 
    func startSpeechRecognition() {
        
        // Cancel the previous task if it's running.
            if let recognitionTask = recognitionTask {
                recognitionTask.cancel()

                self.recognitionTask = nil
            }
        
       
        request = SFSpeechAudioBufferRecognitionRequest()
      
        
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { (result, error) in
               if result != nil { // check to see if result is empty (i.e. no speech found)
                   if let result = result {
                  //  print("RESULT")
                  //  print(result.bestTranscription.formattedString)
                    let phrase = result.bestTranscription.formattedString.lowercased()
                    let words = phrase.byWords;
                    var newPhraseIsValid = false;
                    print("PERIPHERALS")
                    self.macPeripheral = self.bluetoothManager.macPeripheral
                    print(self.bluetoothManager.macPeripheral)
                    if self.threeWordPhrases.contains(words.suffix(3).joined(separator: " ")) {
                       print(words)
                        newPhraseIsValid = true;
                    
                    }
                    else if self.fourWordPhrases.contains(words.suffix(4).joined(separator: " ")) {
                        print(words)
                        newPhraseIsValid = true;
                      
                    }
                    else if self.fiveWordPhrases.contains(words.suffix(5).joined(separator: " ")) {
                        print(words)
                        newPhraseIsValid = true;
                
                    }
                    
                    if newPhraseIsValid && self.responseState == .notRecognized {
                        if self.bluetoothManager.isGhostInRange {
                            self.responseState = .responding
                            self.playGhostSound()
                        }
                        else {
                            self.responseState = .recognized
                        }
                       
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            self.responseState = .notRecognized
                        }
                    }

                   } else if let error = error {
                       print("There has been a speech recognition error")
                       print(error)
                   }
               }

           })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 55.0) { [weak self] in
            print("after 55 seconds")
           
            self?.startSpeechRecognition()
            print("started")
        }
    }
    
    
    func playGhostSound() {
        print("PLAYING GHOST SOUND")
                let sound = Int.random(in: 1..<5)
print(sound)
                // Set up the corresponding audio player to play its sound.
        let player = ghostResponsePlayer[sound];
        print("PLAYER")
        print(player)
        print("BUFFER")
        print(ghostSoundsAudioFileBuffer[sound])
                ghostResponsePlayer[sound].scheduleBuffer(ghostSoundsAudioFileBuffer[sound], at: nil, options: .interrupts, completionHandler: nil)
        print("GOT PAST")
        ghostResponsePlayer[sound].play()
print("PLAYING GHOST SOUND FINAL")
            }
    
   
    
    
       //MARK: Other recording functions
   
    func startSpiritBox() {
        self.bluetoothManager.startScanning()
        if state == .paused {
            do { try resumeRecording() }
            catch {
                print("failed to resume")
            }
        } else {
            startRecording()
        }
    }
    
    func stopSpiritBox() {
        self.bluetoothManager.stopScanning()
        self.responseState = .notRecognized
       pauseRecording()
    }
    
   
       func resumeRecording() throws {
         try engine.start()
         state = .recording
        isRecording = true
        startSpeechRecognition()
       }

       func pauseRecording() {
        isRecording = false
        recognitionTask?.cancel()
        recognitionTask = nil
       
        // stop audio
        request.endAudio()
         engine.pause()
         state = .paused
       }

       func stopRecording() {
        isRecording = false
        recognitionTask?.cancel()
        recognitionTask = nil
       
        // stop audio
        request.endAudio()
        
         // Remove existing taps on nodes
         mixerNode.removeTap(onBus: 0)
        
     
         engine.stop()
         state = .stopped
       }
       

       
}
