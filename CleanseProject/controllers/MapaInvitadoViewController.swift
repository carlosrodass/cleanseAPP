//
//  MapaInvitado.swift
//  CleanseProject
//
//  Created by user176688 on 2/1/21.
//  Copyright © 2021 user176688. All rights reserved.
//

import UIKit
import MapKit

class MapaInvitado: UIViewController, MKMapViewDelegate,CLLocationManagerDelegate{

    @IBOutlet weak var Selectormapa: UISegmentedControl!
       @IBOutlet weak var inicioregistroboton: UIButton!
       @IBOutlet weak var probarAppboton: UIButton!
       @IBOutlet weak var Mapaprimerapantalla: MKMapView!
       let locationManager = CLLocationManager()
       override func viewDidLoad() {
           super.viewDidLoad()

           Mapaprimerapantalla.delegate = self
           locationManager.delegate = self
           locationManager.requestWhenInUseAuthorization()
           let madrid = CLLocationCoordinate2D(latitude: 40, longitude: -4)
           pin(location: madrid)
           print(madrid)
           
           inicioregistroboton.layer.cornerRadius = 10
           probarAppboton.layer.cornerRadius = 10
           
        
       }
       func pin(location: CLLocationCoordinate2D) {
           let anotation = MKPointAnnotation()
           
           anotation.coordinate = location
           anotation.title = "Papelera"
           anotation.subtitle = "calle vazquez san juan 13"
           Mapaprimerapantalla.addAnnotation(anotation)
       }

       func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
           print(view.annotation?.title!! as Any)
       }
       
       func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
           locationManager.startUpdatingLocation()
       }
       
       func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           print(locations[0])
           pin(location: locations[0].coordinate)
       }
       @IBAction func cambiarmapa(_ sender: Any) {
           switch Selectormapa.selectedSegmentIndex {
           case 0:
              Mapaprimerapantalla.mapType = .standard
           case 1:
               Mapaprimerapantalla.mapType = .satellite
           case 2:
               Mapaprimerapantalla.mapType = .hybrid
           default:
               break
           }
       }

       
       
}
