//
//  DailyViewModel.swift
//  PriotixWheaterTest
//
//  Created by Myasnik Tadevosyan on 8/23/19.
//  Copyright © 2019 Myasnik Tadevosyan. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

protocol DailyViewModelDelegate {
    func didRecive(weathers: [Weather]?)
}

class DailyViewModel: BaseViewModel {
    
    private var dataProvider:WeatherDataProvider!
    var dailyViewModelDelegate:DailyViewModelDelegate?
    
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
        
        var sortedDates = weathers.map { (weather) -> String in
            return weather.date.wt_dayFormat()
        }
        sortedDates.removeDuplicates()
        
        var filterdWeathers = [Weather]()
        
        for sortedDate in sortedDates {
            for weather in weathers {
                if sortedDate == weather.date.wt_dayFormat(){
                    filterdWeathers.append(weather)
                    break
                }
            }
        }
        filterdWeathers.removeFirst()
        return filterdWeathers
    }
    
    private func getForecastWeather() {
        dataProvider.weatherHandler = { [weak self] weathers, error in
            guard let wSelf = self else { return }
            let filteredWeathers = wSelf.filterDailyWeathers(weathers: weathers)
            wSelf.dailyViewModelDelegate?.didRecive(weathers: filteredWeathers)
            if error != nil {
                Alert.showAlert(error?.localizedDescription ?? "")
            }
        }
    }
    
}

