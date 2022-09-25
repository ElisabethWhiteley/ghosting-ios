//
//  FilterController.swift
//  Ghosting
//
//  Created by Elisabeth Teigland Whiteley on 12/02/2022.
//

import CoreImage
import Combine
import SwiftUI
import AVKit
import Vision
import VideoToolbox


/// Very simple controller for transforming incoming `CVPixelBuffer`s into
/// filtered `CIImage`s – all via Combine publishers.
class FilterController {

    let filteredImagePublisher: AnyPublisher<(CIImage?, Bool?), Never>
 
    private let filter = CIFilter(name: "CIComicEffect")!
    

    

    
    init(pixelBufferPublisher: AnyPublisher<(CVPixelBuffer?, Bool?), Never>) {
      //  print("HAPPENED")
       
        
        var iteration: CGFloat = 1.0
        var orbPosition: CIVector = CIVector(x: 700, y: -10)
        
        
      //  self.objectInView = objectInView
       // print(pixelBufferPublisher)
      
        
      //  self.objectInView = pixelBufferPublisher.map {self}
            // transform the pixel buffer into an `CIImage`...
          
        
       //  print("bla", self.objectInView)
      //  print(self.objectInView)
       
     
        
     
        self.filteredImagePublisher = pixelBufferPublisher
            // transform the pixel buffer into an `CIImage`...
            .map { ($0.0.flatMap({ CIImage(cvPixelBuffer: $0) }), $0.1) }
            // ... apply the filter to it...
            .map { [weak filter = self.filter] (inputImage, isshow) -> (CIImage?, Bool?) in
       //         print("object in vieew: ", bla.eraseToAnyPublisher())
            
// print("isShow. ", isshow)
                /*
            
                print("orb x ", orbPosition.x)
                print("orb x is 0", orbPosition.x == 0.0)
                print("orb y", orbPosition.y)
                print("orb y is 0", orbPosition.y == 0)
                print("input image: ", inputImage) */
                if orbPosition.x <= 0.0 && orbPosition.y <= 0.0 {
                  //  print("I AM LESS THAN 2 ------------------------")
                    
                    if inputImage !== nil {
                        orbPosition =  CIVector(
                        x: (inputImage?.extent.width ?? 0) - (inputImage?.extent.width ?? 0) / 4,
                        y: (inputImage?.extent.height ?? 0) - (inputImage?.extent.height ?? 0) / 7)
                        print("orb x: ", orbPosition.x)
                        print("orb y: ", orbPosition.y)
                    }
                
                    
                    
                   // print("------first Orb position width----------: ", orbPosition.x)
                 //   print("----first Orb position height---------: ", orbPosition.y)
                } else {
                    // print("iteration: ", iteration)
                  //  print("orb x: ", orbPosition.x)
                  //  print("orb y: ", orbPosition.y)
                    if (iteration > 1000) {
                        iteration = 1
                        
                       orbPosition = CIVector(x: 700, y: -10)
                        
                        
                    }
                  //  print("------first Orb position width----------: ", orbPosition.x)
                    switch iteration {
                    case _ where iteration < 200:
                        orbPosition = CIVector(x: orbPosition.x - 4.5, y: orbPosition.y + 5 * ((100 - iteration) / 100))
                    case _ where iteration < 400:
                        orbPosition = CIVector(x: orbPosition.x - 5, y: orbPosition.y - 4 * ((iteration - 100) / 200))
                    case _ where iteration < 600:
                        orbPosition = CIVector(x: orbPosition.x - 1, y: orbPosition.y - 3 * ((iteration - 100) / 300))
                    case _ where iteration < 700:
                        print("Im in 700")
                        orbPosition = CIVector(x: orbPosition.x + 0.5, y: orbPosition.y - 2 * ((iteration - 100) / 350))
                    case _ where iteration < 725:
                        print("Im in 725")
                        orbPosition = CIVector(x: orbPosition.x + 1.5, y: orbPosition.y - 2 * ((iteration - 100) / 350))
                    case _ where iteration < 750:
                        print("Im in 750")
                        orbPosition = CIVector(x: orbPosition.x + 4, y: orbPosition.y - 1.5 * ((iteration - 100) / 350))
                    case _ where iteration < 800:
                        print("Im in 800")
                        orbPosition = CIVector(x: orbPosition.x + 5, y: orbPosition.y - 1 * ((iteration - 100) / 400))
                    case _ where iteration < 1000:
                        print("Im in 1000")
                        orbPosition = CIVector(x: orbPosition.x + 4.5, y: orbPosition.y - 0.5 * ((iteration - 100) / 550))
                    case _ where iteration < 1100:
                        orbPosition = CIVector(x: orbPosition.x + 3, y: orbPosition.y + 0.5 * ((iteration - 100) / 600))
                    case _ where iteration < 1200:
                        orbPosition = CIVector(x: orbPosition.x + 2, y: orbPosition.y + 2 * ((iteration - 100) / 650))
                    case _ where iteration < 1400:
                        orbPosition = CIVector(x: orbPosition.x + 0.5, y: orbPosition.y + 3 * ((iteration - 100) / 700))
                  
                    default:
                        print("Im in default")
                        orbPosition = CIVector(x: orbPosition.x - 4, y: orbPosition.y + 3 * ((iteration - 100) / 800))
                    }
                }
                
               
                
                
               //  objectInView.map { print("RTHE MAP: ", $0 ?? "nothing")}
                iteration = iteration + 2
                
              //  print("iteration: ", iteration)
                // print("orbposition x: ", orbPosition.x)
                // print("orbposition y: ", orbPosition.y)

               // print("inputimage: ", inputImage != nil)
               // print("iteration upped: ", iteration)
                if (inputImage != nil) {
                    let noir = CIFilter(
                       name: "CIPhotoEffectNoir",
                       parameters: ["inputImage": inputImage!]
                     )?.outputImage
                    // 3
                    
                    /*
                    let sunGenerate = CIFilter(
                      name: "CISunbeamsGenerator",
                      parameters: [
                        
                        "inputStriationContrast": 1,
                        "inputMaxStriationRadius": 5,
                        "inputTime": 0.5,
                        "inputSunRadius": 500,
                       // "inputColor": "#d678ffff",
                        "inputStriationStrength": 1,
                   
                        // "inputColor": CIColor(red: 250, green: 255, blue: 255, alpha: 0.5),
                       // "inputSunRadius": 50,
                        // "inputStriationStrength": 1,
                       // "inputStriationContrast": 20,
                        // "inputMaxStriationRadius": 0.2,
                        "inputCenter": CIVector(
                            x: (inputImage?.extent.width ?? 0) - (inputImage?.extent.width ?? 0) / 5,
                            y: (inputImage?.extent.height ?? 0) - (inputImage?.extent.height ?? 0) / 10)
                      ])?
                      .outputImage
 */
                    // 4
                    
                   // print("Orb position width: ", orbPosition.x)
                 //   print("Orb position height: ", orbPosition.y)
                  //  print((inputImage?.extent.width ?? 0) - (inputImage?.extent.width ?? 0) / 4)
                   // print(((inputImage?.extent.height ?? 0) - (inputImage?.extent.height ?? 0) / 10) - iteration)
                    let sunGenerate = CIFilter(
                      name: "CISunbeamsGenerator",
                      parameters: [
                        "inputStriationStrength": 3,
                        "inputSunRadius": 1,
                        "inputMaxStriationRadius": 8,
                        "inputColor": CIColor(red: 255, green: 0, blue: 255, alpha: 0.2),
                        "inputCenter": isshow ?? false ? orbPosition : CIVector(x: -10, y: -10)
                      ])?
                      .outputImage
                    
                    
                    let vhs = VHSTrackingLines();
            
                    vhs.inputImage = inputImage
                    
                    return (vhs.outputImage, true)
                  //  print("IA ME JKEJ K")
                  /*  return (inputImage?.applyingFilter(
                      "CIBlendWithMask",
                      parameters: [
                        kCIInputBackgroundImageKey: sunGenerate as Any,
                        kCIInputMaskImageKey: noir as Any
                      ]), true) */
                }
                // 2
              // print("I AM HERE")
                return (inputImage, true)
               // return UIImage(cgImage: context.createCGImage(compositeImage, from: compositeImage.extent))
                
            
                
                // filter?.setValue(inputImage, forKey: kCIInputImageKey)
                // return filter?.outputImage
            }
            .eraseToAnyPublisher()
    }

}
