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
            let statusStr = self.convertLocationStatus(status: currentStatus)
            completion(statusStr)
            return
        }

        self.requestLocationAuthorizationCallback = { status in
            if(status == .authorizedWhenInUse){
                self.locationManager.requestAlwaysAuthorization()
            }
            let statusStr = self.convertLocationStatus(status: status)
            completion(statusStr)
        }
        
    }
    
    public func getLocationStatus(completion: @escaping (String)->()){
        
        let currentStatus = CLLocationManager.authorizationStatus()
        
        let statusStr = convertLocationStatus(status: currentStatus)
        completion(statusStr)
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
    
    private func convertLocationStatus(status : CLAuthorizationStatus) -> String{
        switch status {
        case .notDetermined:
            return "not_determined"
        case .restricted:
            return "denied"
        case .denied:
            return "denied"
        case .authorizedAlways:
            return "always"
        case .authorizedWhenInUse:
            return "authorized_when_in_use"
         default:
            return "error"
        }
    }
}
