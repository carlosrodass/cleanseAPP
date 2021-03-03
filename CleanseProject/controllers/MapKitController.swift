import UIKit
import MapKit
import CoreLocation

class MapKitController: UIViewController{

    
    private let rangeInMeters: Double = 10000
    private let locationManager = CLLocationManager()//instanciando locaciazion usuario
    override func viewDidLoad() {
        super.viewDidLoad()
        pin()
        checkLocationServices()
        //determinando mapkit gestiona todos  los eventos del mapa qu yo quiera
        mapKit.delegate = self

        let localizacion = CLLocationCoordinate2DMake(40, -4)
        let span = MKCoordinateSpan(latitudeDelta: 1.02, longitudeDelta: 1.02)
        let region = MKCoordinateRegion(center: localizacion, span: span)
        mapKit.setRegion(region, animated: true)
        
        let sourceLocation = CLLocationCoordinate2D(latitude: 40.4209619, longitude: -3.7193334)
                let destinationLocation = CLLocationCoordinate2D(latitude: 40.43547, longitude: -3.7317)
                
                createPath(sourceLocation: sourceLocation, destinationLocation: destinationLocation)
                
        mapKit.showsUserLocation = true
    }
    func createPath(sourceLocation : CLLocationCoordinate2D, destinationLocation : CLLocationCoordinate2D) {
           let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
           let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
           
           
           let sourceMapItem = MKMapItem(placemark: sourcePlaceMark)
           let destinationItem = MKMapItem(placemark: destinationPlaceMark)
           
           
           let sourceAnotation = MKPointAnnotation()
           sourceAnotation.title = "Principe pio"
           sourceAnotation.subtitle = "estacion"
           if let location = sourcePlaceMark.location {
               sourceAnotation.coordinate = location.coordinate
           }
           
           let destinationAnotation = MKPointAnnotation()
           destinationAnotation.title = "Moncloa"
           destinationAnotation.subtitle = "contenedor"
           if let location = destinationPlaceMark.location {
               destinationAnotation.coordinate = location.coordinate
           }
           
           self.mapKit.showAnnotations([sourceAnotation, destinationAnotation], animated: true)
           
           
           
           let directionRequest = MKDirections.Request()
           directionRequest.source = sourceMapItem
           directionRequest.destination = destinationItem
           directionRequest.transportType = .automobile
           
           let direction = MKDirections(request: directionRequest)
           
           
           direction.calculate { (response, error) in
               guard let response = response else {
                   if let error = error {
                       print("ERROR FOUND : \(error.localizedDescription)")
                   }
                   return
               }
               
               let route = response.routes[0]
               self.mapKit.addOverlay(route.polyline, level: MKOverlayLevel.aboveRoads)
               
               let rect = route.polyline.boundingMapRect
               
               self.mapKit.setRegion(MKCoordinateRegion(rect), animated: true)
               
           }
       }
    @IBOutlet weak var mapKit: MKMapView!
    func pin(){
        
        //metiendo caracteristicas marcador0
        let anotation = MKPointAnnotation()
        anotation.title = "Contenedor"
        anotation.subtitle = "30% carga"
        
        //anadiendo anotacion mapa
        mapKit.addAnnotation(anotation)
        
        //creando localizacion
        let location = CLLocationCoordinate2D(latitude:40.43547,longitude: -3.7317)
        
        //recibiendo localizacion en la anotacion
        anotation.coordinate = location
       
    }
    func golocation(for mapView: MKMapView) -> CLLocation {
        
        //metiendo caracteristicas marcador
        let anotation = MKPointAnnotation()
        anotation.title = "Contenedor"
        anotation.subtitle = "30% carga"
        
        //anadiendo anotacion mapa
        mapKit.addAnnotation(anotation)
        
        //creando localizacion
        let location = CLLocationCoordinate2D(latitude:40.43547,longitude: -3.7317)
        
        //recibiendo localizacion en la anotacion
        anotation.coordinate = location
       
        return CLLocation(latitude: location.latitude, longitude: location.longitude)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView,rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        renderer.strokeColor = .green
        renderer.lineWidth = 5
        return renderer
    }
    
    private func CheckLocationServices() { //comprobando si estan habilitados los servicios de localizacion del usuario
        guard CLLocationManager.locationServicesEnabled() else {
          
            return
        }
        //si se activan los sevicios tomamos el delegado de locationManager y le indicamos la precision con la que queremos trabajar
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    private func checkAuthorizationForLocation() {
        
        switch CLLocationManager.authorizationStatus() {
            case .authorizedWhenInUse, .authorizedAlways:
                mapKit.showsUserLocation = true// istancia de mapkit ha de mostrar la posicion usuarioo
                centerViewOnUser()// que cewntre la vista de usuario
                locationManager.startUpdatingLocation()//activando actualizacion de localizacion
                break
            case .denied:
                // Here we must tell user how to turn on location on device
                break
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
                    // Here we must tell user that the app is not authorize to use location services
                break
            @unknown default:
                break
        }
    }
    private func checkLocationServices() {
        guard CLLocationManager.locationServicesEnabled() else {
                // Here we must tell user how to turn on location on device
           
            return
        }
            
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
     
        checkAuthorizationForLocation()
    }
     
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        checkAuthorizationForLocation()
    }
    
    private func centerViewOnUser() { //  partir de la localización del usuario, establecer un región rectangular centrada con un punto
        guard let location = locationManager.location?.coordinate else { return }
        
        let coordinateRegion = MKCoordinateRegion.init(center: location,
                                                       latitudinalMeters: rangeInMeters,
                                                       longitudinalMeters: rangeInMeters)
        mapKit.setRegion(coordinateRegion, animated: true)
    }
    
    //  la localización la obtenemos del último valor de la lista de localizaciones que devuelve el método
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
            let coordinateRegion = MKCoordinateRegion.init(center: location.coordinate,
                                                           latitudinalMeters: rangeInMeters,
                                                           longitudinalMeters: rangeInMeters)
            
        mapKit.setRegion(coordinateRegion, animated: true)
    }
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let coordinates = mapKit.centerCoordinate
        return CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
    }
    


}
extension MapKitController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let rendere = MKPolylineRenderer(overlay: overlay)
        rendere.lineWidth = 5
        rendere.strokeColor = .systemBlue
        
        return rendere
    }
    
}

extension MapKitController: CLLocationManagerDelegate {
    
   func locationManagerr(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
       
    }
        
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: CLLocation) {
       
    }
}
