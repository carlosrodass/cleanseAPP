import UIKit
import MapKit


class MapViewController: UIViewController {
    
   
    @IBOutlet weak var controlView: UIView!
    @IBOutlet weak var mapView: MapView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchViewTopConstrain: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    private let locationservice = LocationService()
    private var pointType : POIntType?
    private var pointofinterest = [PointInteres]()
    private lazy var locationAlert: UIAlertController = {
        let alertController = UIAlertController(title: "Authorizacion Localizacion", message: "Utilizamos su hubicacion para mejorar el servicio. Para cambiar el permiso de hubicacion por favor actualiza su configuracion de privacidad", preferredStyle: .alert)
        
        let OkAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let settingAction = UIAlertAction(title: "ajuste de actualizacion", style: .default, handler: {(_) in
            if let url = URL(string: UIApplication.openSettingsURLString){
                UIApplication.shared.open(url)
            }
        })
        
        
        alertController.addAction(OkAction)
        alertController.addAction(settingAction)
        return alertController
    }()
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        locationservice.delegate = self
        controlView.layer.cornerRadius = 10
        searchView.layer.cornerRadius = 20
    }
    
    //Centrando localizacion de usuario
    @IBAction func didTapUserLocation(_ sender: UIButton) {
        
        centerToUserLocation()
    }
    
    //Booleano, cambiando tipo de vista (standard-satellite)
    @IBAction func didTapMapButton(_ sender: UIButton) {
        mapView.mapType = mapView.mapType == .standard ? .satellite : .standard
    }
    
    //Desplegando panel de busqueda
    @IBAction func didTapSearchButton(_ sender: UIButton) {
        searchView(shown: true)
    }
    
    //Cerrando panel de bsuqueda
    @IBAction func didTapCloseSliderView(_ sender: UIButton) {
        searchView(shown: false)
    }
    
    //Busqueda de contenedores o supermercados
    @IBAction func didTapPointButton(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            pointType = .Contenedores
        case 1:
            pointType = .SuperMercado
        default:
            break
        }
        seacrhPoi()
        
    }
    //Centrar mapa en localizacion de usuario
    private func centerToUserLocation(){
        
        let mapRegion = MKCoordinateRegion(center: mapView.userLocation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        DispatchQueue.main.async {[weak self] in
            self?.mapView.setRegion(mapRegion, animated: true)
        }

    }
    //Busqueda de localizacion
    private func searchView(shown: Bool){
        
        UIView.animate(withDuration: 0.3){ [weak self] in
            guard let weakSelf = self else {
                return
                
            }
            
            let viewHeight = weakSelf.searchView.frame.size.height
            weakSelf.searchViewTopConstrain.constant = shown
                ? -1 * viewHeight
                : 0
            weakSelf.view.layoutIfNeeded()
        }
    }
    
    private func seacrhPoi(){
        
        guard let poiType = pointType else {
            return
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        BuscarServicios.poiSearc(for: poiType, around: mapView.centerCoordinate){ [weak self]
            (mapItems) in
            self?.updateSearcResult(with: mapItems)
        }
    }
    private func updateSearcResult(with mapItems: [MKMapItem]){
        
        
        pointofinterest.removeAll()
        //buscsamos dentro del objeto segun parametros tenga
        for mapItem in mapItems{
            if let nombre = mapItem.name, let direccion = mapItem.placemark.formattedAddress,let pointType = pointType{
                let poin = PointInteres(title:nombre , direccion: direccion, coordinate: mapItem.placemark.coordinate, poiType: pointType)
                pointofinterest.append(poin)
            }
        }
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotations(pointofinterest)
        DispatchQueue.main.async{[weak self] in
            self?.tableView.reloadData()
            
        }
        
    }
}
//locationservicedelegage

extension MapViewController: LocationServiceDelegate{
    
    func setMapRegion(center: CLLocation) {
        let mapRegion = MKCoordinateRegion(center: center.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        DispatchQueue.main.async {[weak self] in
            self?.mapView.setRegion(mapRegion, animated: true)
        }
    }
    
    func authorizationDefined() {
          DispatchQueue.main.async { [weak self] in
                  guard let weakSelf = self else{
                    return
                  }
                  weakSelf.present(weakSelf.locationAlert, animated: true, completion: nil)
          }
    }
}



extension MapViewController: UITableViewDataSource{
    
    func numberOfSections(in taableView: UITableView)-> Int{
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pointofinterest.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellResult", for: indexPath)
        
        let poi = pointofinterest[indexPath.row]
        
        cell.textLabel?.text = poi.title
        cell.detailTextLabel?.text = poi.subtitle
        cell.detailTextLabel?.numberOfLines = 0
        
        return cell
        
    }
}

