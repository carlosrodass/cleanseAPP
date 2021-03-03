//
//  LocationService.swift
//  CleanseProject
//
//  Created by user176688 on 3/2/21.
//  Copyright © 2021 user176688. All rights reserved.
//

import CoreLocation

protocol LocationServiceDelegate: class {
    func authorizationDefined()
    func setMapRegion(center: CLLocation)
    
}

class LocationService: NSObject {
    var locationManager = CLLocationManager()
    
    weak var delegate: LocationServiceDelegate?
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    private func checkAuthorizationStatus(){
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
            
        case .denied:
            delegate?.authorizationDefined()
        case .authorizedAlways, .authorizedWhenInUse:
            startUpdateingLocation()
        default:
            break
        }
    }
    
    private func startUpdateingLocation(){
        locationManager.startUpdatingLocation()
    }
}

extension LocationService : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status : CLAuthorizationStatus) {
        checkAuthorizationStatus()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        if let location = locations.last{
            delegate?.setMapRegion(center: location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    
}
