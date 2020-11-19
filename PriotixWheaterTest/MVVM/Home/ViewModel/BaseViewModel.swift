//
//  BaseViewModel.swift
//  PriotixWheaterTest
//
//  Created by Myasnik Tadevosyan on 8/23/19.
//  Copyright © 2019 Myasnik Tadevosyan. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class BaseViewModel {
    
    init() {
        setupNotifications()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    @objc func didBecomeActive() {
        
    }
    
    func getLocation(locationCoord:@escaping ((CLLocationCoordinate2D)-> Void)) {
        if LocationService.shared.isEnable {
            if LocationService.shared.isDenied {
                if let bundleId = Bundle.main.bundleIdentifier,
                    let url = URL(string: "\(UIApplication.openSettingsURLString)&path=LOCATION/\(bundleId)")
                {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            } else {
                LocationService.shared.getLocation {(location) in
                    if let coordinate = location?.coordinate  {
                        locationCoord(coordinate)
                    }
                }
            }
        } else {
            if let url = URL(string: "App-prefs:root=General") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
}
