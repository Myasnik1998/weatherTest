//
//  HourlyViewModel.swift
//  PriotixWheaterTest
//
//  Created by Myasnik Tadevosyan on 8/23/19.
//  Copyright © 2019 Myasnik Tadevosyan. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

protocol HourlyViewModelDelegate {
    func didRecive(weathers: [Weather]?)
}

class HourlyViewModel: BaseViewModel {
    
    private var dataProvider:WeatherDataProvider!
    var hourlyViewModelDelegate:HourlyViewModelDelegate?
    
    override init() {
        super.init()
        getLocation()
        addObservers()
    }
    
    deinit {
        removeObservers()
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(didTapLocation), name: NSNotification.Name.init(rawValue: "didTapLocation"), object: nil)
    }
    
    func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc override func didBecomeActive() {
        if LocationService.shared.isEnable {
            getLocation()
        }
    }
    
    @objc func didTapLocation(notification: Notification) {
        getLocation()
    }
    
    private func setupDataProvider(location: CLLocationCoordinate2D) {
        self.dataProvider = WeatherDataProvider(location: location)
        self.getForecastWeather()
    }
    
    private func getLocation() {
        getLocation { (coordinate) in
            self.setupDataProvider(location: coordinate)
        }
    }
    
    func filterDailyWeathers(weathers: [Weather]?) -> [Weather] {
        guard let weathers = weathers else { return [Weather]() }
        return Array(weathers.prefix(8))
    }
    
    private func getForecastWeather() {
        dataProvider.weatherHandler = { [weak self] weathers, error in
            guard let wSelf = self else { return }
            let filteredWeathers = wSelf.filterDailyWeathers(weathers: weathers)
            wSelf.hourlyViewModelDelegate?.didRecive(weathers: filteredWeathers)
            if error != nil {
                Alert.showAlert(error?.localizedDescription ?? "")
            }
        }
    }
    
}
