//
//  Location.swift
//  1-CoreLocation
//
//  Created by Alexandre Desponds on 16.09.16.
//  Copyright © 2016 Alexandre Desponds. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class LocationManager: NSObject, CLLocationManagerDelegate{
    
    let locationManager = CLLocationManager()
    var location : CLLocationCoordinate2D?
    var alt : Double?
    var horAcc : Double?
    var verAcc : Double?
    var status : Bool = false
    
    weak var delegate : LocationManagerDelegate?
    
    /* Singletone */
    class var shared : LocationManager {
        
        struct Static {
            static let instance : LocationManager = LocationManager()
        }
        
        return Static.instance
    }
    
    override init() {
        super.init()
        
        self.locationManager.delegate = self
        self.locationManager.headingOrientation = CLDeviceOrientation.landscapeRight
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLDistanceFilterNone
    }
    
    func authorize() -> Bool{
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
                case .notDetermined:
                    locationManager.requestWhenInUseAuthorization()
                    return true
                case .restricted:
                    print("Location services are not allowed for this app")
                case .denied:
                    print("Location services are not allowed for this app")
                default:
                    print("Location services are authorize")
                    return true
            }
        }
        return false
    }
    
    func stopUpdatingLocation() {
        self.status = false
        locationManager.stopUpdatingLocation()
    }
    
    func startUpdatingLocation() {
        if self.authorize() {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.status = true
        self.location = locationManager.location?.coordinate
        self.alt = locationManager.location?.altitude
        self.horAcc = locationManager.location?.horizontalAccuracy
        self.verAcc = locationManager.location?.verticalAccuracy
        delegate?.updateGPS(location: self)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.status = false
    }
}
