//
//  MapainvitadoBusqueda.swift
//  CleanseProject
//
//  Created by user176688 on 2/1/21.
//  Copyright © 2021 user176688. All rights reserved.
//
import CoreLocation
import UIKit
import MapKit
class MapainvitadoBusqueda: UIViewController, MKMapViewDelegate,CLLocationManagerDelegate {


          @IBOutlet weak var UItextfieldDireccion: UITextField!
          @IBOutlet weak var botoncomenzar: UIButton!
          @IBOutlet weak var Mapapantalla: MKMapView!
          @IBOutlet weak var Selector: UISegmentedControl!
          
          @IBOutlet weak var irDireccionboton: UIButton!
          var locationManager = CLLocationManager()

          override func viewDidLoad(){
              super.viewDidLoad()
              Mapapantalla.delegate = self
              locationManager.delegate = self
              locationManager.desiredAccuracy = kCLLocationAccuracyBest
              locationManager.requestAlwaysAuthorization()
              locationManager.requestWhenInUseAuthorization()
              locationManager.startUpdatingLocation()

            
              Mapapantalla.delegate = self
              //     let madrid = CLLocationCoordinate2D(latitude: 40, longitude: -4)
              //    pin(location: madrid)
           
              
          }
          func getAddress(){
                  let geocoder = CLGeocoder()
              geocoder.geocodeAddressString(UItextfieldDireccion.text!){(placemarks,error)
                  in
                  guard let placemarks = placemarks, let location = placemarks.first?.location
                  else{
                      print("Ninguna dirección encontrada")
                  return
              }
                  print(location)
              
                  self.mapthis(destinationCord: location.coordinate)
          }
          }
          
        

          //  func pin(location: CLLocationCoordinate2D) {
          //  let anotation = MKPointAnnotation()
              
          //  anotation.coordinate = location
          //  anotation.title = "Papelera"
          //  anotation.subtitle = "calle vazquez san juan 13"
          //       Mapapantalla.addAnnotation(anotation)
          //}
          
          //  func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
          //  print(view.annotation?.title!! as Any)
           
          //}
          func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
              let render = MKPolygonRenderer(overlay: overlay as! MKPolyline)
              render.strokeColor = .blue
              return render
          }
          
          //func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
          //  locationManager.startUpdatingLocation()
          // }
          
          func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
              print(locations)
              //  pin(location: locations[0].coordinate)
          }

          func mapthis(destinationCord : CLLocationCoordinate2D){
          

              let souceCordinate = (locationManager.location?.coordinate)!
              let socuePlacemark = MKPlacemark(coordinate: souceCordinate)
              let desplaceMark =  MKPlacemark(coordinate: destinationCord)
              
              let sourceItem = MKMapItem(placemark: socuePlacemark)
              let desItem = MKMapItem(placemark: desplaceMark)
              let destinationRequest = MKDirections.Request()
              
              destinationRequest.source = sourceItem
              destinationRequest.destination = desItem
              destinationRequest.transportType = .automobile
              destinationRequest.requestsAlternateRoutes = true
              
              let directions = MKDirections(request: destinationRequest)
              directions.calculate { (response, error) in
                  guard let response = response else{
                      
                      if let error = error{
                          
                          print("Algo esta mal:")
                      }
                      return
                  }
                  let route = response.routes[0]
                  self.Mapapantalla.addOverlay(route.polyline)
                  self.Mapapantalla.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
              }
          }
          @IBAction func cambiarvismapa(_ sender: Any) {
              switch Selector.selectedSegmentIndex {
              case 0:
                  Mapapantalla.mapType = .standard
              case 1:
                  Mapapantalla.mapType = .satellite
              case 2:
                  Mapapantalla.mapType = .hybrid
              default:
                  break
              }
          }
          
          @IBAction func IrDireccionAccion(_ sender: Any) {
              getAddress()
          }
          
}
