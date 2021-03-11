import MapKit

class SearchService {
    typealias SearchHandler = ([MKMapItem]) -> Void
    
    static func search(for searchText: String, around center: CLLocationCoordinate2D? = nil, completion: @escaping SearchHandler) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        
        if let center = center {
            let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
            request.region = region
        }
        
        MKLocalSearch(request: request).start { (response, error) in
            if error != nil {
                return
            }
            
            guard let response = response else { return }
            
            completion(response.mapItems)
        }
    }
}
