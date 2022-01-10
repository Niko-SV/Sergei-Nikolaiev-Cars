
import UIKit
import MapKit
import CoreLocation

final class PlaceInfoViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    private let locationManager = LocationManager()
    
    var userName: String? = nil
    var userLastLocation: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameLabel.text = userName
        locationManager.locationCallback = displayLastLocation
        displayInitialLocation()
    }
    
    private func displayLastLocation(_ location: CLLocation) {
        showLocationOnMap(location: location)
        userLastLocation = "\(location.coordinate.latitude), \(location.coordinate.longitude)"
        UserDefaults.standard.set(userLastLocation, forKey: DefaultsKeys.userLastLocation)
    }
    
    private func displayInitialLocation() {
        if let lastLocation = locationManager.lastUserLocation {
            displayLastLocation(lastLocation)
        } else {
            locationManager.requestAuthorization() {
                self.locationManager.startLocationUpdates()
            }
        }
    }
    
    private func showLocationOnMap(location: CLLocation) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = location.coordinate
        annotation.title = "You're here"
        mapView.addAnnotation(annotation)
        mapView.setCenter(location.coordinate, animated: true)
    }
}
