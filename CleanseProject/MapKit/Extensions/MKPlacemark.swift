//
//  MKPlacemark.swift
//  CleanseProject
//
//  Created by user176688 on 3/3/21.
//  Copyright © 2021 user176688. All rights reserved.
//

import MapKit

extension MKPlacemark{
    var formattedAddress: String?{
        guard
            let numeroCalle = subThoroughfare,
            let nombreCalle = thoroughfare,
            let ciudad = locality,
            let estacion = administrativeArea,
            let codigopostal = postalCode
        else{
            if let titulo = title{
                return "\(title)"
            }
            else{
                return nil
            }
            
        }
        
        let direccion = "\(numeroCalle) \(nombreCalle), \(ciudad),\(estacion)\(codigopostal)"
        
        return direccion
        
    }
}
