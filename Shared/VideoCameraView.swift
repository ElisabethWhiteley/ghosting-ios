//
//  VideoCameraView.swift
//  Ghosting
//
//  Created by Elisabeth Teigland Whiteley on 12/02/2022.
//

import SwiftUI
import Combine


struct VideoCameraView: View {

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
            PreviewView(imagePublisher: self.filterController.filteredImagePublisher)
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

struct VideoCameraView_Previews: PreviewProvider {
    static var previews: some View {
        VideoCameraView()
    }
}
