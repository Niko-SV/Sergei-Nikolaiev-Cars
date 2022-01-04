
import CoreLocation

final class LocationManager: NSObject, CLLocationManagerDelegate {
    
    private lazy var manager: CLLocationManager = {
       let locationManager = CLLocationManager()
        locationManager.delegate = self
        return locationManager
    }()
    
    private var authorizationCallback: (() -> Void)?
    var locationCallback: ((CLLocation) -> Void)?
    
    func requestAuthorization(completion: @escaping () -> Void) {
        manager.requestWhenInUseAuthorization()
        authorizationCallback = completion
    }
    
    func startLocationUpdates() {
        manager.startUpdatingLocation()
    }
    
    func stopLocationUpdates() {
        manager.stopUpdatingLocation()
    }
    
    var lastUserLocation: CLLocation? {
        manager.location
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if #available(iOS 14.0, *) {
            switch manager.authorizationStatus {
            case .authorizedAlways, .authorizedWhenInUse:
                print("Location usage approved")
                authorizationCallback?()
            case .denied, .restricted:
                print("Location usage disabled")
            case .notDetermined:
                manager.requestWhenInUseAuthorization()
            @unknown default:
                break
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            locationCallback?(lastLocation)
        }
    }
}
