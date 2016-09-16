//
//  ViewController.swift
//  1-CoreLocation
//
//  Created by Alexandre Desponds on 16.09.16.
//  Copyright © 2016 Alexandre Desponds. All rights reserved.
//

import UIKit
import MapKit
import AVFoundation

class ViewController: UIViewController, LocationManagerDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var latData: UILabel!
    @IBOutlet weak var lngData: UILabel!
    @IBOutlet weak var AltData: UILabel!
    @IBOutlet weak var AccVerData: UILabel!
    @IBOutlet weak var AccHorData: UILabel!
    
    let pin = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LocationManager.shared.delegate = self
        mapView.mapType = MKMapType.satellite
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        LocationManager.shared.startUpdatingLocation()
    }
    
    func updateGPS(location: LocationManager){
        latData.text = location.location?.latitude.description
        lngData.text = location.location?.longitude.description
        AltData.text = location.alt?.description
        AccVerData.text = location.verAcc?.description
        AccHorData.text = location.horAcc?.description
        status.textColor = UIColor.green
        pin.coordinate = location.location!
        mapView.addAnnotation(self.pin)
        centerMapOnLocation(location: CLLocation(latitude: (location.location?.latitude)!, longitude: (location.location?.longitude)!))
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 10 * 2.0, 10 * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}

