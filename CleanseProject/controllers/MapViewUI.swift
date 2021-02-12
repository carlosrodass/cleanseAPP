




import SwiftUI
import MapKit

struct MapViewUI: UIViewRepresentable {

  let location: Place
  let places: [Place]
  let mapViewType: MKMapType

  func makeUIView(context: Context) -> MKMapView {
    let mapView = MKMapView()
    mapView.setRegion(location.region, animated: false)
    mapView.mapType = mapViewType
    mapView.isRotateEnabled = false
    mapView.addAnnotations(places)
    mapView.delegate = context.coordinator
    let categories: [MKPointOfInterestCategory] = [.restaurant, .atm, .hotel]
    let filter = MKPointOfInterestFilter(including: categories)
    mapView.pointOfInterestFilter = filter
    mapView.showsUserLocation = true
     produceOverlay(mapView: mapView)
    return mapView
  }

  func updateUIView(_ mapView: MKMapView, context: Context) {
    mapView.mapType = mapViewType
  }

  func makeCoordinator() -> MapCoordinator {
    .init()
  }
    func produceOverlay(mapView: MKMapView) {
       var points: [CLLocationCoordinate2D] = []
       points.append(CLLocationCoordinate2DMake(40.063965, -82.346642))
       points.append(CLLocationCoordinate2DMake(40.063921, -82.346185))
       points.append(CLLocationCoordinate2DMake(40.063557, -82.346185))
       points.append(CLLocationCoordinate2DMake(40.063561, -82.347200))
       points.append(CLLocationCoordinate2DMake(40.063961, -82.347150))
       points.append(CLLocationCoordinate2DMake(40.063965, -82.346800))
       let polygon = MKPolygon(coordinates: &points, count: points.count)
       mapView.addOverlay(polygon)
     }

  final class MapCoordinator: NSObject, MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {

      if overlay is MKPolygon {
        let lineView = MKPolygonRenderer(overlay: overlay)
        lineView.strokeColor = UIColor.green
        lineView.lineWidth = 8.0
        return lineView
      }
      return MKOverlayRenderer(overlay: overlay)

    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

      switch annotation {
      case let cluster as MKClusterAnnotation:
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "cluster") as? MKMarkerAnnotationView ?? MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "cluster")
        annotationView.markerTintColor = .brown
        for clusterAnnotation in cluster.memberAnnotations {
          if let place = clusterAnnotation as? Place {
            if place.sponsored {
              cluster.title = place.name
              break
            }
          }
        }
        annotationView.titleVisibility = .visible
        return annotationView
      case let placeAnnotation as Place:
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "InterestingPlace") as? MKMarkerAnnotationView ?? MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "Interesting Place")
        annotationView.canShowCallout = true
        annotationView.glyphText = "👀"
        annotationView.clusteringIdentifier = "cluster"
        annotationView.markerTintColor = UIColor(displayP3Red: 0.082, green: 0.518, blue: 0.263, alpha: 1.0)
        annotationView.titleVisibility = .visible
        annotationView.detailCalloutAccessoryView = UIImage(named: placeAnnotation.image).map(UIImageView.init)
        return annotationView
      default: return nil
      }


    }

  }

}
