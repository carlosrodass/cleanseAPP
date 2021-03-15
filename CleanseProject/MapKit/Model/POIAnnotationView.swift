//
//  POIAnnotationView.swift
//  CleanseProject
//
//  Created by alumnos on 11/03/2021.
//  Copyright © 2021 user176688. All rights reserved.
//

import MapKit

class POIAnnotationView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let poi = newValue as? POI else { return }
            
            let button = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30)))
            
            
            if let poiImage = UIImage(named: "poi-\(poi.poiType.rawValue)") {
                button.setBackgroundImage(poiImage, for: .normal)
                
                if let scaledImage = resize(image: poiImage, newSize: CGSize(width: 30, height: 30)) {
                    image = scaledImage
                }
            }
            
            canShowCallout = true
            leftCalloutAccessoryView = button
        }
    }
    
    private func resize(image: UIImage, newSize: CGSize) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}


