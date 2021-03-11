//
//  MKPlacemark.swift
//  CleanseProject
//
//  Created by user176688 on 3/3/21.
//  Copyright © 2021 user176688. All rights reserved.
//

import MapKit

extension MKPlacemark {
    var formattedAddress: String? {
        guard
            let streetNumber = subThoroughfare,
            let streetName = thoroughfare,
            let city = locality,
            let state = administrativeArea,
            let zip = postalCode
        else {
            if let title = title {
                return "\(title)"
            }
            else {
                return nil
            }
        }
        
        let address = "\(streetNumber) \(streetName), \(city), \(state) \(zip)"
        return address
    }
}
