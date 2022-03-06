//
//  ReflectionLocationManager.swift
//  HolisticProgrammer
//
//  Created by Humberto De la Cruz Santos on 2/18/22.
//

import Foundation
import CoreLocation


class ReflectionLocationManager : NSObject, ObservableObject, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager?
    private var startLocation = CLLocation()
    private var updatedLocation = CLLocation()
    @Published var distance = CLLocationDistance()
    
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
            
        } else {
          print("Tell them is off and they will need it. ")
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else {
            return
        }
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("You location is restricted due to parent control")
        case .denied:
            print("You denied location, go to setting")

        case .authorizedAlways, .authorizedWhenInUse:
            guard let currentLocation = locationManager.location else { return }
            startLocation = currentLocation
            locationManager.startUpdatingLocation()
        @unknown default:
            break
        }

    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            updatedLocation = lastLocation
            updateDistance()
        }
    }
    
    func updateDistance() {
        distance = updatedLocation.distance(from: startLocation)
    }
    

    func stopLoadingLocations() {
        locationManager?.stopUpdatingLocation()
    }
    
    
}
