//
//  LocationManagerDelegate.swift
//  1-CoreLocation
//
//  Created by Alexandre Desponds on 16.09.16.
//  Copyright © 2016 Alexandre Desponds. All rights reserved.
//

protocol LocationManagerDelegate : class {
    
    func updateGPS(location: LocationManager)
    
}
