//
//  LocationManager.swift
//  location_permission
//
//  Created by Baiaman on 27/10/21.
//

import Foundation
import CoreLocation
class LocationManager: NSObject, CLLocationManagerDelegate {

    static let shared = LocationManager()
    private var locationManager: CLLocationManager = CLLocationManager()
    private var requestLocationAuthorizationCallback: ((CLAuthorizationStatus) -> Void)?

    public func requestLocationAuthorization(completion: @escaping (String)->()){
        self.locationManager.delegate = self
        let currentStatus = CLLocationManager.authorizationStatus()
        if(currentStatus == .notDetermined){
            self.locationManager.requestWhenInUseAuthorization()
        }else if(currentStatus == .authorizedWhenInUse){
            self.locationManager.requestAlwaysAuthorization()
        }else {
            completion("denied")
            return
        }
        

        self.requestLocationAuthorizationCallback = { status in
            switch status {
            case .notDetermined:
                completion("not_determined")
                break
            case .restricted:
                completion("not_determined")
                break
            case .denied:
                completion("denied")
                break
            case .authorizedAlways:
                completion("always")
                break
            case .authorizedWhenInUse:
                completion("authorized_when_in_use")
                break
             default:
                completion("error")
            }
        }
        
    }
    
    public func getLocationStatus(completion: @escaping (String)->()){
        
        let currentStatus = CLLocationManager.authorizationStatus()
        
        switch currentStatus {
        case .notDetermined:
            completion("not_determined")
            break
        case .restricted:
            completion("denied")
            break
        case .denied:
            completion("denied")
            break
        case .authorizedAlways:
            completion("always")
            break
        case .authorizedWhenInUse:
            completion("authorized_when_in_use")
            break
         default:
            completion("error")
        }

    }
    
    public func openSettings(){
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }

        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: nil)
        }
    }
    
    // MARK: - CLLocationManagerDelegate
    public func locationManager(_ manager: CLLocationManager,
                                didChangeAuthorization status: CLAuthorizationStatus) {
        self.requestLocationAuthorizationCallback?(status)
    }
}
