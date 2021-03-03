//
//  MapView.swift
//  CleanseProject
//
//  Created by user176688 on 3/2/21.
//  Copyright © 2021 user176688. All rights reserved.
//

import MapKit

class MapView: MKMapView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //desplazando el compas que viene propio por defecto mapkit
        if let compassView = subviews.filter(
            {
                $0.isKind(of:NSClassFromString("MKCompassView")!)
            }
            ).first{
            compassView.frame = CGRect(x: 16, y: 68, width: 40, height: 40)
            }
    }
}
