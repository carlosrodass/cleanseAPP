//
//  BuscarServicio.swift
//  CleanseProject
//
//  Created by user176688 on 3/3/21.
//  Copyright © 2021 user176688. All rights reserved.
//

import MapKit

class BuscarServicios{
    typealias SearchHandler = ([MKMapItem])-> Void
    
    static func poiSearc(for poinType: POIntType, around center: CLLocationCoordinate2D, completion: @escaping SearchHandler){
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = poinType.rawValue
        request.region = region
        MKLocalSearch(request: request).start {(response, error) in
            if error != nil {
                return
            }
            guard let response = response else {return}
            
            completion(response.mapItems)
            
            
        }
        
    }
    
    
    
    
    
}
