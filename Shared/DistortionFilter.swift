//
//  DistortionFilter.swift
//  Ghosting (iOS)
//
//  Created by Elisabeth Teigland Whiteley on 25/09/2022.
//

import CoreImage

class VHSTrackingLines: CIFilter
{
    var inputImage: CIImage?
    var inputTime: CGFloat = 0
    var inputSpacing: CGFloat = 50
    var inputStripeHeight: CGFloat = 0.7
    var inputBackgroundNoise: CGFloat = 0.1
    
    
    override func setDefaults()
    {
        inputSpacing = 50
        inputStripeHeight = 0.5
        inputBackgroundNoise = 0.05
    }
    
    override var attributes: [String : Any]
    {
        return [
            kCIAttributeFilterDisplayName: "VHS Tracking Lines",
            "inputImage": [kCIAttributeIdentity: 0,
                              kCIAttributeClass: "CIImage",
                        kCIAttributeDisplayName: "Image",
                               kCIAttributeType: kCIAttributeTypeImage],
            "inputTime": [kCIAttributeIdentity: 0,
                             kCIAttributeClass: "NSNumber",
                           kCIAttributeDefault: 8,
                       kCIAttributeDisplayName: "Time",
                               kCIAttributeMin: 0,
                         kCIAttributeSliderMin: 0,
                         kCIAttributeSliderMax: 2048,
                              kCIAttributeType: kCIAttributeTypeScalar],
            "inputSpacing": [kCIAttributeIdentity: 0,
                                kCIAttributeClass: "NSNumber",
                              kCIAttributeDefault: 50,
                          kCIAttributeDisplayName: "Spacing",
                                  kCIAttributeMin: 20,
                            kCIAttributeSliderMin: 20,
                            kCIAttributeSliderMax: 200,
                                 kCIAttributeType: kCIAttributeTypeScalar],
            "inputStripeHeight": [kCIAttributeIdentity: 0,
                                     kCIAttributeClass: "NSNumber",
                                   kCIAttributeDefault: 0.5,
                               kCIAttributeDisplayName: "Stripe Height",
                                       kCIAttributeMin: 0,
                                 kCIAttributeSliderMin: 0,
                                 kCIAttributeSliderMax: 1,
                                      kCIAttributeType: kCIAttributeTypeScalar],
            "inputBackgroundNoise": [kCIAttributeIdentity: 0,
                                        kCIAttributeClass: "NSNumber",
                                      kCIAttributeDefault: 0.05,
                                  kCIAttributeDisplayName: "Background Noise",
                                          kCIAttributeMin: 0,
                                    kCIAttributeSliderMin: 0,
                                    kCIAttributeSliderMax: 0.25,
                                         kCIAttributeType: kCIAttributeTypeScalar]
        ]
    }
    
    override var outputImage: CIImage?
    {
        guard let inputImage = inputImage else
        {
            return nil
        }
        
        let tx = NSValue(cgAffineTransform: CGAffineTransform(translationX: CGFloat(drand48() * 100), y: CGFloat(drand48() * 100)))
        
        let noise = CIFilter(name: "CIRandomGenerator")!.outputImage!
            .applyingFilter("CIAffineTransform",
                            parameters: [kCIInputTransformKey: tx])
            .applyingFilter("CILanczosScaleTransform",
                            parameters: [kCIInputAspectRatioKey: 5])
            .cropped(to: inputImage.extent)
        
        let noisey = CIFilter(name: "CIStripesGenerator")!.outputImage!
            .applyingFilter("CIAffineTransform",
                            parameters: [kCIInputTransformKey: tx])
            .applyingFilter("CILanczosScaleTransform",
                            parameters: [kCIInputAspectRatioKey: 5])
            .cropped(to: inputImage.extent)
        
        
        let kernel = CIColorKernel(source:
                                    "kernel vec4 thresholdFilter(__sample image, __sample noise, float time, float spacing, float stripeHeight, float backgroundNoise)" +
                                   "{" +
                                   "   vec2 uv = destCoord();" +
                                   
                                   "   float stripe = smoothstep(1.0 - stripeHeight, 1.0, sin((time + uv.y) / spacing)); " +
                                   
                                   "   return image + (noise * noise * stripe) + (noise * backgroundNoise);" +
                                   "}"
        )!
        
        
        let extent = inputImage.extent
        let arguments = [inputImage, noise, inputTime, inputSpacing, inputStripeHeight, inputBackgroundNoise] as [Any]
        
        let final = kernel.apply(extent: extent, arguments: arguments)?
            .applyingFilter("CIPhotoEffectNoir", parameters: [:])
        
        return final
    }
}



class GhostOrbFilter: CIFilter
{
    var inputImage: CIImage?
   private var iteration: CGFloat = 1.0
   private var orbPosition: CIVector = CIVector(x: 700, y: -10)
    var ghostInRange: Bool?
    
    
    override var outputImage: CIImage?
    {
        guard let inputImage = inputImage else
        {
            return nil
        }
        
        if orbPosition.x <= 0.0 && orbPosition.y <= 0.0 {
          //  print("I AM LESS THAN 2 ------------------------")
            
        
                orbPosition =  CIVector(
                    x: (inputImage.extent.width ) - (inputImage.extent.width ) / 4,
                    y: (inputImage.extent.height ) - (inputImage.extent.height ) / 7)
                print("orb x: ", orbPosition.x)
                print("orb y: ", orbPosition.y)
            
        
            
            
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
                orbPosition = CIVector(x: orbPosition.x + 0.5, y: orbPosition.y - 2 * ((iteration - 100) / 350))
            case _ where iteration < 725:
                orbPosition = CIVector(x: orbPosition.x + 1.5, y: orbPosition.y - 2 * ((iteration - 100) / 350))
            case _ where iteration < 750:
                orbPosition = CIVector(x: orbPosition.x + 4, y: orbPosition.y - 1.5 * ((iteration - 100) / 350))
            case _ where iteration < 800:
                orbPosition = CIVector(x: orbPosition.x + 5, y: orbPosition.y - 1 * ((iteration - 100) / 400))
            case _ where iteration < 1000:
                orbPosition = CIVector(x: orbPosition.x + 4.5, y: orbPosition.y - 0.5 * ((iteration - 100) / 550))
            case _ where iteration < 1100:
                orbPosition = CIVector(x: orbPosition.x + 3, y: orbPosition.y + 0.5 * ((iteration - 100) / 600))
            case _ where iteration < 1200:
                orbPosition = CIVector(x: orbPosition.x + 2, y: orbPosition.y + 2 * ((iteration - 100) / 650))
            case _ where iteration < 1400:
                orbPosition = CIVector(x: orbPosition.x + 0.5, y: orbPosition.y + 3 * ((iteration - 100) / 700))
          
            default:
                orbPosition = CIVector(x: orbPosition.x - 4, y: orbPosition.y + 3 * ((iteration - 100) / 800))
            }
        }
        
        iteration = iteration + 2
        /*
        let noir = CIFilter(
           name: "CIPhotoEffectNoir",
           parameters: ["inputImage": inputImage]
         )?.outputImage
        */
        let sunGenerate = CIFilter(
          name: "CISunbeamsGenerator",
          parameters: [
            "inputStriationStrength": 3,
            "inputSunRadius": 1,
            "inputMaxStriationRadius": 8,
            "inputColor": CIColor(red: 255, green: 0, blue: 255, alpha: 0.2),
            "inputCenter": ghostInRange ?? false ? orbPosition : CIVector(x: -10, y: -10)
          ])?
          .outputImage
        
        
    
      //  print("IA ME JKEJ K")
        return inputImage.applyingFilter(
          "CIBlendWithMask",
          parameters: [
            kCIInputBackgroundImageKey: sunGenerate as Any,
            kCIInputMaskImageKey: inputImage as Any
          ])
        
    }
}
