//
//  LocationService.swift
//  PriotixWheaterTest
//
//  Created by Myasnik Tadevosyan on 8/21/19.
//  Copyright © 2019 Myasnik Tadevosyan. All rights reserved.
//

import Foundation
import CoreLocation

class LocationService: NSObject {
    
    static let shared = LocationService()
    var locationManager: CLLocationManager?
    var location: CLLocation?
    
    var isEnable: Bool {
        return CLLocationManager.locationServicesEnabled()
    }
    
    var isDenied: Bool {
        if CLLocationManager.locationServicesEnabled() {
            return .authorizedWhenInUse != CLLocationManager.authorizationStatus() &&
                .authorizedAlways != CLLocationManager.authorizationStatus() &&
                .notDetermined != CLLocationManager.authorizationStatus()
        }
        return false
    }
    
    private var getLocationHandler: ((_ location: CLLocation?)->Void)?
    
    private override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager?.delegate = self
        
        if !isDenied {
            startUpdatingLocation()
        }
    }
    
    func startUpdatingLocation() {
        locationManager?.startUpdatingLocation()
    }
    
    public func getLocation(completion: @escaping (_ location: CLLocation?)->Void) {
        getLocationHandler = completion
        if isDenied || .notDetermined == CLLocationManager.authorizationStatus() {
            locationManager?.requestWhenInUseAuthorization()
        } else {
            if let location = self.location {
                self.getLocationHandler? (location)
                self.getLocationHandler = nil
            } else {
                startUpdatingLocation()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    //Time Out!
                    if self.getLocationHandler != nil {
                        self.getLocationHandler? (self.location)
                        self.getLocationHandler = nil
                    }
                }
            }
        }
    }
}

extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let latestLocation = locations.last {
            self.location = latestLocation
            self.getLocationHandler?(latestLocation)
            self.getLocationHandler = nil
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            self.location = manager.location
            if manager.location != nil {
                self.getLocationHandler?(manager.location)
                self.getLocationHandler = nil
            }
            startUpdatingLocation()
        } else if status != .notDetermined {
            if self.getLocationHandler != nil {
                self.getLocationHandler?(nil)
                self.getLocationHandler = nil
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
}
