//
//  LocationManager.swift
//  RampBuilder
//
//  Created by Madsbook on 04.06.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI
import Combine
import CoreLocation

class SpeedViewModel: NSObject, ObservableObject {
    private var locationManager: CLLocationManager = CLLocationManager()
    
    var objectWillChange = PassthroughSubject<Void, Never>()

    @Published var status: CLAuthorizationStatus? {
      willSet { objectWillChange.send() }
    }
    
    var statusString: String {
        guard let status = status else {
            return "unknown"
        }

        switch status {
        case .notDetermined: return "notDetermined"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .authorizedAlways: return "authorizedAlways"
        case .restricted: return "restricted"
        case .denied: return "denied"
        default: return "unknown"
        }
    }
    
    var locationList: [Double] = []
    
    @Published var speed: Double = 0 {
      willSet { objectWillChange.send() }
    }
        
    var maxSpeed: Double = 0
    var formattedMaxSpeed: String {
        let formatter = MeasurementFormatter()
        formatter.unitOptions = [.providedUnit]
        formatter.numberFormatter.maximumFractionDigits = 0
        let speed = Measurement(value: self.maxSpeed, unit: UnitSpeed.metersPerSecond)
        return formatter.string(from: speed.converted(to: UnitSpeed.kilometersPerHour))
    }
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        self.locationManager.distanceFilter = 1
        self.locationManager.allowsBackgroundLocationUpdates = true
    }
    
    func startUpdating() {
        self.locationManager.startUpdatingLocation()
        print("start updating \(speed)")
    }
    
    func stopUpdating() {
        self.locationManager.stopUpdatingLocation()
        print("stop updating \(speed)")
    }
    
    func checkAuthorization() {
        AnalyticsManager.instance.logEvent("SpeedView opened")
        
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            startUpdating()
            break
        case .authorizedAlways:
            startUpdating()
            break
        case .denied:
//            self.formattedSpeed = "Update location settings to enable speed measurements"
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            startUpdating()
            break
        case .restricted:
            break
        @unknown default:
            fatalError()
        }
    }
    
    func openSettings() {
        UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
    }
}

extension SpeedViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.status = status
        
        AnalyticsManager.instance.setUserProperties(["location_permission": statusString])
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let speed = self.locationManager.location?.speed else { return }
        self.speed = speed
        
        self.maxSpeed = speed > maxSpeed ? speed : maxSpeed
        
        self.locationList.append(speed)
    
        print(speed)
    }
}
