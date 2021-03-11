//
//  PointInteres.swift
//  CleanseProject
//
//  Created by user176688 on 3/3/21.
//  Copyright © 2021 user176688. All rights reserved.
//

import MapKit

enum POIType: String {
    case puntolimpio, supermercado, pin
}

class POI: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    let title: String?
    let subtitle: String?
    let poiType: POIType
    
    var tintColor: UIColor {
        switch poiType {
        case .puntolimpio:
            return .orange
            
        case .supermercado:
            return .init(red: 51/255, green: 131/255, blue: 51/255, alpha: 1.0)
            
        case .pin:
            return .red
        }
    }
    
    init(title: String, address: String, coordinate: CLLocationCoordinate2D, poiType: POIType) {
        self.title = title
        self.subtitle = address
        self.coordinate = coordinate
        self.poiType = poiType
        
        super.init()
    }
}

