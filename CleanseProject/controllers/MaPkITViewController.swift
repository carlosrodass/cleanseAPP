

import UIKit
import CoreLocation

class MaPkITViewController: UIViewController {

    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var locationDistance: UILabel!
    @IBOutlet weak var placeImage: UIImageView!
  
    
    var placesViewController: PlaceScrollViewController?
    var locationManager : CLLocationManager?
    var previusLocation : CLLocation?
  
    override func viewDidLoad() {
      super.viewDidLoad()
      if let childViewController = children.first as? PlaceScrollViewController {
        placesViewController = childViewController
      }
      loadPlaces()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        
        locationManager?.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
    }

    override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
    }
    
    func selectPlace() {
      print("place selected")
    }
    

    @IBAction func startLocationService(_ sender: UIButton) {
  
        if CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
                  activateLocationServices()
              }else{
                  locationManager?.requestWhenInUseAuthorization()
              }
    }
    

    private func activateLocationServices(){
        
        locationManager?.startUpdatingLocation()
    }
    
    func loadPlaces() {
      
      guard let entries = loadPlist() else { fatalError("Unable to load data") }
      
      for property in entries {
        guard let name = property["Name"] as? String,
              let latitude = property["Latitude"] as? NSNumber,
              let longitude = property["Longitude"] as? NSNumber,
              let image = property["Image"] as? String else { fatalError("Error reading data") }
        print("name: \(name)")
        print("latitude: \(latitude)")
        print("longitude: \(longitude)")
        print("image: \(image)")
      }
    }
    
    private func loadPlist() -> [[String: Any]]? {
      guard let plistUrl = Bundle.main.url(forResource: "Places", withExtension: "plist"),
        let plistData = try? Data(contentsOf: plistUrl) else { return nil }
      var placedEntries: [[String: Any]]? = nil
      
      do {
        placedEntries = try PropertyListSerialization.propertyList(from: plistData, options: [], format: nil) as? [[String: Any]]
      } catch {
        print("error reading plist")
      }
      return placedEntries
    }
}

   extension MaPkITViewController : CLLocationManagerDelegate{
       
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways{
            
            activateLocationServices()
        }
    }
      
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if previusLocation == nil{
            
            previusLocation = locations.first
        }else{
            guard let latest = locations.first else {return }
            let distanceMeters = previusLocation?.distance(from:latest) ?? 0
            print("distance in meters\(distanceMeters)")
            previusLocation = latest
            
        }
    }
   }
