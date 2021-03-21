import UIKit
import MapKit
import CoreLocation
import Lottie
import BLTNBoard



class MapViewController: UIViewController , CLLocationManagerDelegate{
    
    var container:Container?
    var containerList : [Container] = []
    var latitude : [Double] = [40.4167, 40.4187]
    var longitude : [Double] = [-3.70325, -3.67800]
    
    @IBOutlet weak var mapView: MapView!
    @IBOutlet weak var controlView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var directionView: UIView!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var tripTimeLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var viewpoinsID: UIView!
    
    @IBOutlet weak var viewpoinidbut: UIView!
    @IBOutlet weak var viewpoinsidtop: UIView!
    
    @IBOutlet weak var aumentadorbotellaskg: UIStepper!
    @IBOutlet weak var directionViewTopConstrainPoint: NSLayoutConstraint!
    @IBOutlet weak var goPoint: UIView!
    @IBOutlet weak var directionViewPoint: UIView!
    @IBOutlet weak var numberPlastic: UILabel!
    
    @IBOutlet weak var numberIdcontainer: UILabel!
    @IBOutlet weak var advisoryStackView: UIStackView!
    @IBOutlet weak var directionViewTopConstraint: NSLayoutConstraint!
   
    @IBOutlet weak var sendPoint: UIButton!
  
    
    private let animatViewww = AnimationView()
    private let locationService = LocationService()
    private var poiType: POIType?
    private var pois = [POI]()
    private var mapCenterLocation: CLLocation?
    private var searchCompleter = MKLocalSearchCompleter()
    private var completerResults = [MKLocalSearchCompletion]()
    private var completerSearch = false
    private var previousPinLocation: CLLocation?
    private var routes = [MKRoute]()
    private var routeIndex = 0
    private var selectedAnnotation: MKAnnotationView?
    private var mapHasRoute = false
    
    var locationManager : CLLocationManager?
    private lazy var locationAlert: UIAlertController = {
        let alertController = UIAlertController(title: "Autorización de ubicación", message: "cleanse puede proporcionar los puntos de interés en función de su hubicación actual. Para cambiar el permiso de ubicación, actualice su configuración de privacidad.", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let settingAction = UIAlertAction(title: "Configuración de actualización", style: .default, handler: { (_) in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        })
        
        alertController.addAction(okAction)
        alertController.addAction(settingAction)
        
        return alertController
    }()
    
    private lazy var routeAlert: UIAlertController = {
        let alertController = UIAlertController(title: "Route Error", message: "Directions are not available to this destination", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        return alertController
    }()
    
    // Create UITextField
    let myTextField: UITextField = UITextField(frame: CGRect(x: 0, y: 0, width: 300.00, height: 20.00))
    
    let variousIDs : [Int] = [1,2]
    var randomElement  = 1
//    self.randomElement = variousIDs.randomElement()!
    
    
    private lazy var boardManager: BLTNItemManager = {
   
    let item = BulletinItem(title: "Trade trash")
    item.image = UIImage(named: "cargo")
    item.actionButtonTitle = "Continue"
    item.alternativeButtonTitle = "Maybe later"
    item.descriptionText = "Introduce in KG your plastic"
    let greenColor = UIColor(red: 0.294, green: 0.85, blue: 0.392, alpha: 1)
    item.appearance.actionButtonColor = greenColor
    item.appearance.actionButtonTitleColor = .white
    item.actionHandler = { _ in
        
        let tradePlastic : String = item.textField.text!
        let container_id : String = String(self.randomElement)
        
        let parametros : [String: String] = [
                   "trash": tradePlastic,
                   "container_id": container_id
                   ]

        Request.shared.tradePlastic(parameters: parametros).responseJSON {
            response in
            switch response.result {
                  case .success:
                    
                      let alertacept = UIAlertController(title: "Points", message: "You reach more points! congratulations!", preferredStyle: .alert)
                      alertacept.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                      self.present(alertacept, animated: true, completion: nil)
                      debugPrint(response)
                   
                  case let .failure(error):
                    
                    let alerterror = UIAlertController(title: "Algo salió mal", message: "El ID del contenedor es incorrecto", preferredStyle: .alert)
                      alerterror.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                      self.present(alerterror, animated: true, completion: nil)
                      print(error)
            }
        }
     
    }
    
    item.alternativeHandler = { _ in
        
        self.dismiss(animated: true)
        
    }
    
    return BLTNItemManager(rootItem: item)
    
    }()
    


    override func viewDidLoad() {
        super.viewDidLoad()
    
        //Delegates
        locationManager?.delegate = self
        locationService.delegate = self
        searchCompleter.delegate = self
        
        //Map
        mapCenterLocation = CLLocation(latitude: mapView.userLocation.coordinate.latitude, longitude: mapView.userLocation.coordinate.longitude)
        registerAnnotationView()
        
        //Loading containers from database
        let requestB = Request.shared.getContainers()

        requestB.responseJSON { [self]  (response) in
            
                if let data = response.value as? [[String:Any]]{
                    
                    for i in 0..<latitude.count{
                        
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = CLLocationCoordinate2D(latitude: self.latitude[i] , longitude: self.longitude[i])
                        annotation.title = data[i]["Street_name"] as? String
                        annotation.subtitle = data[i]["Street_number"] as? String
                                                
                        mapView.addAnnotation(annotation)

                    }
                }
        }
        
//        loadContainers(poi:containerList)
    
    }


    @IBAction func addPlasticView(_ sender: Any) {
        
        boardManager.showBulletin(above: self)
    
    }
  
    @IBAction func didTapUserLocation(_ sender: UIButton) {
        centerToUserLocation()
    }
    
    @IBAction func didTapMapButton(_ sender: UIButton) {
        mapView.mapType = mapView.mapType == .standard ? .satellite : .standard
    }
    
    @IBAction func didTapSearchButton(_ sender: UIButton) {
        poiType = nil
        searchView(shown: true)
        directionView(shown: false)
    }
    
    @IBAction func didTapCloseSlideView(_ sender: UIButton) {
        closeSlideView()
        
        
        if sender.tag == 1 {
            clearMapView()
        }
    }
    
    @IBAction func didTapPoiButton(_ sender: UIButton) {
        completerSearch = false
        clearSearchTextField()
        
        switch sender.tag {
        case 0:
            poiType = .supermercado
            
        case 1:
            poiType = .PuntoLimpio
            
        default:
            break
        }
        
        searchPOI()
    }
    
    @IBAction func textFieldEditingChange(_ sender: UITextField) {
        poiType = .pin
        
        if let text = sender.text {
            searchCompleter.queryFragment = text
        }
    }
    
    @IBAction func didLongPressedGesture(_ sender: UILongPressGestureRecognizer) {
        let point = sender.location(in: mapView)
        let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        if previousPinLocation == nil || previousPinLocation!.distance(from: location) > 10 {
            previousPinLocation = location
            
            CLGeocoder().reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
                if error != nil {
                    return
                }
                
                if let clPlacemark = placemarks?.first {
                    let placemark = MKPlacemark(placemark: clPlacemark)
                    
                    if let address = placemark.formattedAddress {
                        let poi = POI(title: "Pinned Location", address: address, coordinate: coordinate, poiType: .pin)
                        self?.mapView.addAnnotation(poi)
                    }
                }
            }
        }
    }
    
    @IBAction func didTapGesture(_ sender: UITapGestureRecognizer) {
        closeSlideView()
        
        let touchPoint = sender.location(in: mapView)
        let touchCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        let mapPoint = MKMapPoint(touchCoordinate)
     
        var myRoutes = [MKRoute]()
        var routeIndex = 0
        
        for overlay in mapView.overlays {
            if overlay is MKPolyline, let polylineRenderer = mapView.renderer(for: overlay) as? MKPolylineRenderer {
                let polylinePoint = polylineRenderer.point(for: mapPoint)
                
                if polylineRenderer.path.contains(polylinePoint) {
                    if let title = overlay.title, let indexStr = title, let index = Int(indexStr) {
                        routeIndex = index
                        myRoutes.append(routes[routeIndex])
                        break
                    }
                }
            }
        }
        
        if !myRoutes.isEmpty {
            for (index, route) in routes.enumerated() {
                if index != routeIndex {
                    myRoutes.append(route)
                }
            }
            
            routes = myRoutes
            renderRoute()
        }
    }
    
    @IBAction func tirititi(_ sender: Any) {
        if let locationManager = self.locationManager {
            let region = self.regionToMonitor()
            guard let longPress = sender as? UILongPressGestureRecognizer else { return }
            let touchLocation = longPress.location(in: mapView)
            let coordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
            let circle = MKCircle(center: coordinate, radius: region.radius)
            mapView.addOverlay(circle)
            if(locationManager.monitoredRegions.count > 0) {
                locationManager.stopMonitoring(for: region)
                print("se ha lanzado el diametroooo en la regionnnnn mi panaaaaaaaaa")
                
            }else{
                locationManager.startMonitoring(for: region)
                print("no se ha iniciado el circulete compadreeee")
            }
            
        }

    }
    @IBAction func didTapGo(_ sender: UIButton) {
        guard let poi = selectedAnnotation?.annotation as? POI else { return }
        
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        let placemark = MKPlacemark(coordinate: poi.coordinate)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = poi.title
        mapItem.openInMaps(launchOptions: launchOptions)
        
        
    }
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
       print("eeeey tio estas entrando dentro de mi barrio tio")
    }
     
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
       print("adiossssss tolifacioooooooo")
    }
    
    
  
    private func directionViewaPoints(shown:Bool){
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let weakSelf = self else { return }
            
            weakSelf.directionViewTopConstrainPoint.constant = shown
                ? 400
                : 0
        
            weakSelf.view.layoutIfNeeded()
        }
        
    }
    
    private func centerToUserLocation() {
        let mapRegion = MKCoordinateRegion(center: mapView.userLocation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        
        DispatchQueue.main.async { [weak self] in
            self?.mapView.setRegion(mapRegion, animated: true)
        }
    }
    
    private func searchView(shown: Bool) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let weakSelf = self else { return }
            
            let viewHeight = weakSelf.searchView.frame.size.height
            
            weakSelf.searchViewTopConstraint.constant = shown
                ? -1 * viewHeight
                : 0
            
            weakSelf.view.layoutIfNeeded()
        }
    }
    
    private func directionView(shown: Bool) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let weakSelf = self else { return }
            
            weakSelf.directionViewTopConstraint.constant = shown
                ? -240
                : 0
        
            weakSelf.view.layoutIfNeeded()
        }
    }
    
    private func searchPOI() {
        guard let poiType = poiType else { return }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        SearchService.search(for: poiType.rawValue, around: mapView.centerCoordinate) { [weak self] (mapItems) in
            self?.updateSearchResult(with: mapItems)
        }
    }
    
    private func updateSearchResult(with mapItems: [MKMapItem]) {
        pois.removeAll()
        mapView.removeAnnotations(mapView.annotations)
        
        for mapItem in mapItems {
            if let name = mapItem.name, let address = mapItem.placemark.formattedAddress, let poiType = poiType {
                let poi = POI(title: name, address: address, coordinate: mapItem.placemark.coordinate, poiType: poiType)
                
                // add annotation
                // addAnnotation(for: poi)
                pois.append(poi)
            }
        }
        
        mapView.addAnnotations(pois)
        
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func clearSearchTextField() {
        searchTextField.text = nil
        searchTextField.resignFirstResponder()
    }
    
    private func closeSlideView() {
        clearSearchTextField()
        searchView(shown: false)
        directionView(shown: false)
        directionViewaPoints(shown: false)
    }
    
    private func centerMap(to poi: POI) {
        setMapRegion(center: CLLocation(latitude: poi.coordinate.latitude, longitude: poi.coordinate.longitude))
        closeSlideView()
    }
    
    private func loadContainers(poi: [Container]) {
//        let annotation = MKPointAnnotation()
//
//        print(poi)
////        for i in 0...1 {
////
////        }
//
////        annotation.coordinate = CLLocationCoordinate2D(latitude: poi.gsLat, longitude: poi.gsLong)
////        annotation.title = poi.gsStreetName
////        annotation.subtitle = String(poi.gsStreetNumber)
//
////        mapView.addAnnotation(annotation)
    }
    
    private func registerAnnotationView() {
//        mapView.register(POIAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.register(POIMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.register(POIClusterAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
    }
    
    private func showDirection(to poi: POI) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        clearMapView()
        routes.removeAll()
        
        selectedAnnotation?.annotation = poi
        
        if let destinationTitle = poi.title {
            destinationLabel.text = "To \(destinationTitle)"
            addressLabel.text = poi.subtitle
        }
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: mapView.userLocation.coordinate))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: poi.coordinate))
        
        // MKMapItem elemento del mapa incluye una ubicación geográfica y cualquier dato interesante que pueda aplicarse a esa ubicación, como la dirección en esa ubicación y el nombre de una empresa en esa dirección
        //MKPlacemarc  Los datos de la marca de posición incluyen información como el país o la región, el estado, la ciudad y la dirección de la calle asociada con la coordenada especificada. Una marca de posición es un objeto de anotación concreto y se ajusta al MKAnnotationprotocolo. Debido a que es una anotación, puedes agregar una marca de posición directamente a la lista de anotaciones de la vista del mapa.
        request.requestsAlternateRoutes = true
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        directions.calculate { [weak self] (response, error) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            guard let weakSelf = self else { return }
            
            if let error = error {
                print(error.localizedDescription)
                weakSelf.present(weakSelf.routeAlert, animated: true, completion: nil)
            }
            
            guard let response = response else { return }
            
            weakSelf.routes = response.routes
            weakSelf.renderRoute()
        }
    }
    func regionToMonitor()->CLCircularRegion{
        
        let autentia = CLCircularRegion(center: CLLocationCoordinate2D(latitude: 40.436563, longitude: -3.716541), radius: 100, identifier: "autentia")
        
        autentia.notifyOnExit = true
        autentia.notifyOnEntry = true
        return autentia
    }
    
    private func renderRoute() {
        var primaryRoute = MKRoute()
        let _ = advisoryStackView.subviews.map({ $0.removeFromSuperview() })
        
        for route in routes {
            if routeIndex == 0 {
                primaryRoute = route
            }
            else {
                mapView.addOverlay(route.polyline, level: .aboveRoads)
            }
            routeIndex += 1
        }
        
        mapHasRoute = true
        routeIndex = 0
        mapView.addOverlay(primaryRoute.polyline, level: .aboveRoads)
        mapView.setVisibleMapRect(primaryRoute.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 80, left: 80, bottom: 200, right: 80), animated: true)
        
        tripTimeLabel.text = "\(Int(primaryRoute.expectedTravelTime/60)) min"
        distanceLabel.text = distanceStringByLocale(distance: primaryRoute.distance)
        
        if let poi = selectedAnnotation?.annotation {
            mapView.addAnnotation(poi)
        }
        
        if !primaryRoute.advisoryNotices.isEmpty {
            for advise in primaryRoute.advisoryNotices {
                var advisoryImageView = UIImageView()
                
                if advise.lowercased().contains(RouteAdvisory.toll.rawValue), let imageView = advisoryImage(for: .toll) {
                    advisoryImageView = imageView
                }
                else if advise.lowercased().contains(RouteAdvisory.ferry.rawValue), let imageView = advisoryImage(for: .ferry) {
                    advisoryImageView = imageView
                }
                else if advise.lowercased().contains(RouteAdvisory.walking.rawValue), let imageView = advisoryImage(for: .walking) {
                    advisoryImageView = imageView
                }
                
                advisoryStackView.addArrangedSubview(advisoryImageView)
            }
        }
        
        directionView(shown: true)
    }
    
    private func advisoryImage(for advise: RouteAdvisory) -> UIImageView? {
        return UIImageView(image: UIImage(named: "icon-\(advise.rawValue)"))
    }
    
    private func distanceStringByLocale(distance: Double) -> String {
        if let locale = Locale.current.regionCode, locale.caseInsensitiveCompare("US") == .orderedSame {
            return String(format: "%.1f mi", distance/1609.344)
        }
        
        if distance / 1000 < 1 {
            return "\(distance) m"
        }
        return "\(Int(distance/1000)) km"
    }
    
    private func clearMapView() {
        mapHasRoute = false
        mapView.removeOverlays(mapView.overlays)
        mapView.removeAnnotations(mapView.annotations)
        mapView.deselectAnnotation(selectedAnnotation?.annotation, animated: true)
    }
}


// MARK: - LocationServiceDelegate

extension MapViewController: LocationServiceDelegate {
    func setMapRegion(center: CLLocation) {
        let mapRegion = MKCoordinateRegion(center: center.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        
        DispatchQueue.main.async { [weak self] in
            self?.mapView.setRegion(mapRegion, animated: true)
        }
    }
    
    func authorizationDenied() {
        DispatchQueue.main.async { [weak self] in
            guard let weakSelf = self else { return }
            
            weakSelf.present(weakSelf.locationAlert, animated: true, completion: nil)
        }
    }
}


// MARK: - TableViewDataSource and Delegate

extension MapViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return completerSearch ? completerResults.count : pois.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellResult", for: indexPath)
        
        if completerSearch {
            let result = completerResults[indexPath.row]
            
            cell.textLabel?.attributedText = highlight(text: result.title, rangeValues: result.titleHighlightRanges)
            cell.detailTextLabel?.attributedText = highlight(text: result.subtitle, rangeValues: result.subtitleHighlightRanges)
        }
        else {
            let poi = pois[indexPath.row]
            
            cell.textLabel?.text = poi.title
            cell.detailTextLabel?.text = poi.subtitle
            cell.detailTextLabel?.numberOfLines = 0
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if completerSearch {
            let searchResult = completerResults[indexPath.row]
            
            SearchService.search(for: searchResult.title) { [weak self] (mapItems) in
                guard let weakSelf = self else { return }
                
                weakSelf.updateSearchResult(with: mapItems)
                let poi = weakSelf.pois[0]
                weakSelf.centerMap(to: poi)
            }
        }
        else {
            let poi = pois[indexPath.row]
            mapView.addAnnotation(poi)
            centerMap(to: poi)
        }
        
        completerResults.removeAll()
        pois.removeAll()
    }
    
    private func highlight(text: String, rangeValues: [NSValue]) -> NSAttributedString {
        let attributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow]
        let highlightedString = NSMutableAttributedString(string: text)
        
        let ranges = rangeValues.map{ $0.rangeValue }
        ranges.forEach { (range) in
            highlightedString.addAttributes(attributes, range: range)
        }
        
        return highlightedString
    }
}


// MARK: - MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        if let poiType = poiType, poiType != .pin && !mapHasRoute {
            let newCenterLocation = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
            
            if let prevMapCenterLocation = mapCenterLocation {
                // Refresh the POI search if center moves 500 m from previous center
                if newCenterLocation.distance(from: prevMapCenterLocation) > 500 {
                    mapCenterLocation = newCenterLocation
                    searchPOI()
                }
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let poi = view.annotation as? POI else { return }
        
        showDirection(to: poi)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        var renderer = MKPolylineRenderer()
        
        if let polyline = overlay as? MKPolyline {
            polyline.title = "\(routeIndex)"
            
            let routeColor = routeIndex == 0
                ? UIColor(red: 66/255, green: 167/255, blue: 244/255, alpha: 1.0)
                : UIColor(red: 163/255, green: 212/255, blue: 247/255, alpha: 0.7)
            
            renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = routeColor
        }
        
        return renderer
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        selectedAnnotation = view
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? MKPointAnnotation, let poiType = poiType else { return nil }

        let identifier = "pinView-\(poiType.rawValue)"
        let annotationView: MKMarkerAnnotationView

        if let view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            view.annotation = annotation
            annotationView = view
        }
        else {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView.canShowCallout = true

            let addressLabel = UILabel()
            addressLabel.numberOfLines = 0
            addressLabel.text = annotation.subtitle
            addressLabel.font = UIFont.systemFont(ofSize: 12)

            annotationView.detailCalloutAccessoryView = addressLabel
        }

        return annotationView
    }
}


// MARK: - MKLocalSearchCompleterDelegate

extension MapViewController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        completerSearch = true
        completerResults = completer.results
        tableView.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}


// MARK: - UITextfieldDelegate

extension MapViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


// MARK: - ScrollViewDelegate

extension MapViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchTextField.resignFirstResponder()
    }
}
