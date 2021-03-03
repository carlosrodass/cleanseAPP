//
//  PointInteres.swift
//  CleanseProject
//
//  Created by user176688 on 3/3/21.
//  Copyright © 2021 user176688. All rights reserved.
//

import MapKit

enum POIntType : String {
    case Contenedores, SuperMercado
    
}

class PointInteres: NSObject,MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    let title: String?
    let subtitle: String?
    let poiType: POIntType
    
    init(title: String, direccion: String, coordinate: CLLocationCoordinate2D, poiType: POIntType) {
        self.title = title
        self.subtitle = direccion
        self.coordinate = coordinate
        self.poiType = poiType
        
        super.init()
    }
}
