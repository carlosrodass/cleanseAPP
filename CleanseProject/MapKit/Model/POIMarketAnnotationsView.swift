//
//  POIMarketAnnotationsView.swift
//  CleanseProject
//
//  Created by alumnos on 11/03/2021.
//  Copyright © 2021 user176688. All rights reserved.
//

import MapKit

class POIMarkerAnnotationView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let poi = newValue as? POI else { return }
            
            let button = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30)))
            
//            if let poiImage = UIImage(named: "poi-\(poi.poiType.rawValue)"), let pinImage = UIImage(named: "\(poi.poiType.rawValue)") {
            if let buttonImage = UIImage(named: "direct"), let pinImage = UIImage(named: "\(poi.poiType.rawValue)") {
                button.setBackgroundImage(buttonImage, for: .normal)
                glyphImage = pinImage
            }
            
            clusteringIdentifier = "poiCluster"
            canShowCallout = true
            markerTintColor = poi.tintColor
            leftCalloutAccessoryView = button
            
            let addressLabel = UILabel()
            addressLabel.numberOfLines = 0
            addressLabel.text = poi.subtitle
            addressLabel.font = UIFont.systemFont(ofSize: 20)
            
            detailCalloutAccessoryView = addressLabel
        }
    }
}
