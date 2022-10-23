//
//  LocationManager.swift
//  Ghosting (iOS)
//
//  Created by Elisabeth Teigland Whiteley on 08/05/2022.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?
    var lastKnownHeading: CLLocationDirection?
    var lastKnownBearing: Double?
    var latitude = 60.4340887
    var longitude = 5.309672
    @Published var angleToGhost = 0.0
    @Published var isInGhostLocation = false

    override init() {
        super.init()
        manager.delegate = self
    }

    func start() {
        print("latitude inside location manager: ", latitude)
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        manager.startUpdatingHeading()
    }
    
    func stop() {
        manager.stopUpdatingLocation()
        manager.stopUpdatingHeading()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
      //  print("LOCATION: ", lastKnownLocation)
        lastKnownBearing = getBearingBetweenTwoPoints(point1: locations.first, point2: CLLocation(latitude: latitude, longitude: longitude))
        angleToGhost = getAngleToGhost()
        print("angle to ghost: ", angleToGhost)

       isInGhostLocation = isThisGhostLocation()
      // print("BEARING: ", lastKnownBearing)
       // print("HEADING: ", lastKnownHeading)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
           lastKnownHeading = newHeading.trueHeading
       }
    
    
    
    func degreesToRadians(degrees: Double) -> Double { return degrees * .pi / 180.0 }
    func radiansToDegrees(radians: Double) -> Double { return radians * 180.0 / .pi }

    func getBearingBetweenTwoPoints(point1 : CLLocation?, point2 : CLLocation?) -> Double {
        
        if (point1 != nil && point2 != nil) {
            let lat1 = degreesToRadians(degrees: point1!.coordinate.latitude)
            let lon1 = degreesToRadians(degrees: point1!.coordinate.longitude)

            let lat2 = degreesToRadians(degrees: point2!.coordinate.latitude)
            let lon2 = degreesToRadians(degrees: point2!.coordinate.longitude)

            let dLon = lon2 - lon1

            let y = sin(dLon) * cos(lat2)
            let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon)
            let radiansBearing = atan2(y, x)

            let bla = radiansToDegrees(radians: radiansBearing)
            return bla < 0 ? bla + 360 : bla
        }
        return 0.0
    }

    func isThisGhostLocation() -> Bool {
        let epsilon = 0.000045 // 0.000045
        if (lastKnownLocation != nil) {
            let isSameLocation = fabs(lastKnownLocation!.latitude - latitude) <= epsilon && fabs(lastKnownLocation!.longitude - longitude) <= epsilon
           print("IS IN GHOST LOCATION: ", isSameLocation)
            
            return isSameLocation
        }
       return false
    }
    
    func getAngleToGhost() -> Double {
        
        if (lastKnownBearing != nil && lastKnownHeading != nil) {
            let difference = abs(lastKnownBearing! - lastKnownHeading!)
                        
            if (difference < 50) {
                if (lastKnownBearing! <= lastKnownHeading!) {
                    return -1 * (difference / 50 * 8)
                }
                return difference / 50 * 8
            }
            
            if (difference > 300) {
                if (lastKnownBearing! > lastKnownHeading!) {
                    return -1 * ((360 - difference) / 50 * 8 )
                }
                
                return (360 - difference) / 50 * 8
            }
        }
        return 0.0
    }
}
