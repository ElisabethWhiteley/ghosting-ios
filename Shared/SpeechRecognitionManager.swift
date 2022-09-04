//
//  SpeechRecognitionManager.swift
//  Ghosting
//
//  Created by Elisabeth Teigland Whiteley on 16/01/2022.
//

import Foundation
import Speech


class SpeechRecognitionManager: NSObject, ObservableObject, SFSpeechRecognizerDelegate {
    
    /*
    let audioEngine = AVAudioEngine()
    let mixerNode = AVAudioMixerNode()
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer()
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    var audioPlayer = AVAudioPlayerNode()
    @Published var authStatus = SFSpeechRecognizerAuthorizationStatus.notDetermined
    @Published var isRecording = false
    @Published var isRecognizedQuestion = false

    let threeWordPhrases = ["are you here", "can you speak", "can we speak", "are you waiting", "are you happy", "shall we leave", "where are you"]
    
    let fourWordPhrases = ["are there any ghosts", "may i ask you", "can i ask you", "is this your home", "give us a sign", "do something"]
    
    let fiveWordPhrases = ["can you speak to us", "is there anyone with me", "would you like to talk", "are you male or female", "can you make a sound", "can you speak to us"]

    
    override init() {
        super.init()
      setupSession()
      setupEngine()
      
    }
      
    
    private func setupEngine() {

          // Set volume to 0 to avoid audio feedback while recording.
          mixerNode.volume = 0

        audioEngine.attach(mixerNode)
        audioPlayer.volume = 70
        audioEngine.attach(audioPlayer)
            
        makeConnections()

        audioEngine.prepare()
        }

    private func setupSession() {
        let session = AVAudioSession.sharedInstance()
      try? session.setCategory(.playAndRecord, options: [.mixWithOthers, .defaultToSpeaker])
        try? session.setActive(true, options: .notifyOthersOnDeactivation)
     }
   private func makeConnections() {
           
          let inputNode = audioEngine.inputNode
          let inputFormat = inputNode.outputFormat(forBus: 0)
          audioEngine.connect(inputNode, to: mixerNode, format: inputFormat)
          
          let mainMixerNode = audioEngine.mainMixerNode
          let mixerFormat = AVAudioFormat(commonFormat: .pcmFormatFloat32, sampleRate: inputFormat.sampleRate, channels: 1, interleaved: false)
        
          audioEngine.connect(mixerNode, to: mainMixerNode, format: mixerFormat)

          let path = Bundle.main.path(forResource: "HelpMeWhisper.mp3", ofType:nil)!
          let url = URL(fileURLWithPath: path)
          let file = try! AVAudioFile(forReading: url)
    let audioFileBuffer = AVAudioPCMBuffer(pcmFormat: file.processingFormat, frameCapacity: AVAudioFrameCount(file.length))
   try! file.read(into: audioFileBuffer!, frameCount: AVAudioFrameCount(file.length))
   // let audioFileBuffer = AVAudioPCMBuffer(PCMFormat: file.fileFormat, frameCapacity: AVAudioFrameCount(file.length))
       //   read(into buffer: audioFileBuffer )
    audioPlayer.scheduleBuffer(audioFileBuffer!, at: nil, options:.loops, completionHandler: nil)
          audioEngine.connect(audioPlayer, to: mainMixerNode, format: nil)
            
            }
    
    func cancelRecording() {
        isRecognizedQuestion = false
        isRecording = false
        recognitionTask?.cancel()
        recognitionTask = nil
       
        // stop audio
        request.endAudio()
       // mixerNode.removeTap(onBus: 0)
        audioEngine.stop()
       // audioEngine.inputNode.removeTap(onBus: 0)
       
      //  audioEngine.outputNode.removeTap(onBus: 0)
      
    }
    
//MARK: - Recognize Speech
    func recordAndRecognizeSpeech() {
       
        isRecording = true
        let tapNode: AVAudioNode = mixerNode
        let format = tapNode.outputFormat(forBus: 0)

         
        tapNode.installTap(onBus: 0, bufferSize: 1024, format: format) { buffer, _ in
               self.request.append(buffer)
           }

        do {
         try audioEngine.start()
            print("IS STARTING AUDIOENGINE")
            
        }
        catch
        {
            print("cant start ------------------------")
        }
        
          audioPlayer.play()
     
        
        
        guard let myRecognizer = SFSpeechRecognizer() else {
          
           // self.sendAlert(title: "Speech Recognizer Error", message: "Speech recognition is not supported for your current locale.")
            return
        }
        if !myRecognizer.isAvailable {
          
           // self.sendAlert(title: "Speech Recognizer Error", message: "Speech recognition is not currently available. Check back at a later time.")
            // Recognizer is not available right now
            return
        }
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { (result, error) in
               if result != nil { // check to see if result is empty (i.e. no speech found)
                   if let result = result {
                  //  print("RESULT")
                  //  print(result.bestTranscription.formattedString)
                    let phrase = result.bestTranscription.formattedString.lowercased()
                    let words = phrase.byWords;
                    var newPhraseIsValid = false;
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
                    
                    if newPhraseIsValid && self.isRecognizedQuestion == false {
                        self.isRecognizedQuestion = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            self.isRecognizedQuestion = false
                        }
                    }

                   } else if let error = error {
                       print("There has been a speech recognition error")
                       print(error)
                   }
               }

           })
        
       recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { result, error in
            result?.bestTranscription.segments.forEach { segment in
            }
            print("SPEECH RECOG RESULT ")
            print(result)
            if let result = result {
                let phrase = result.bestTranscription.formattedString.lowercased()
                let words = phrase.byWords;
                var newPhraseIsValid = false;
                if self.threeWordPhrases.contains(words.suffix(3).joined(separator: " ")) {
                    print("recognized 3 word phrase")
                    print(words.suffix(3).joined(separator: " "))
                    newPhraseIsValid = true;
                }
                else if self.fourWordPhrases.contains(words.suffix(4).joined(separator: " ")) {
                    print("recognized 4 word phrase")
                    print(words.suffix(4).joined())
                    newPhraseIsValid = true;
                }
                else if self.fiveWordPhrases.contains(words.suffix(5).joined(separator: " ")) {
                    print("recognized 5 word phrase")
                    print(words.suffix(5).joined())
                    newPhraseIsValid = true;
                }
                
                if newPhraseIsValid && self.isRecognizedQuestion == false {
                    self.isRecognizedQuestion = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        self.isRecognizedQuestion = false
                    }
                }
              
               
            } else if let error = error {
             //   self.sendAlert(title: "Speech Recognizer Error", message: "There has been a speech recognition error.")
                print(error)
            }
        })
    }
    
     */
}
