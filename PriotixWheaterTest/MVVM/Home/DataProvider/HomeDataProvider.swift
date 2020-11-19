//
//  HomeDataProvider.swift
//  PriotixWheaterTest
//
//  Created by Myasnik Tadevosyan on 8/22/19.
//  Copyright © 2019 Myasnik Tadevosyan. All rights reserved.
//

import Foundation
import CoreLocation

class HomeDataProvider {
    
    var currentWeatherHandler:((Weather?,Error?) -> Void)?
    var searchedWeatherHandler:(([Weather]?,Error?) -> Void)?

    init(location: CLLocationCoordinate2D) {
        getCurrentWeatherDataBy(location: location)
    }
    
    private func getCurrentWeatherDataBy(location: CLLocationCoordinate2D ) {
        WeatherApiManager().currentWeatherDataBy(coordinate: location.latitude, long: location.longitude, succses: {[weak self] (weather) in
            guard let wSelf = self else { return }
            wSelf.currentWeatherHandler?(weather, nil)
        }) {[weak self] (error) in
            guard let wSelf = self else { return }
            wSelf.currentWeatherHandler?(nil, error)
        }
    }
    
    func getSearchedWeatherBy(name: String ) {
        WeatherApiManager().forecastAtBy(name: name, succses: { [weak self] (weathers) in
            guard let wSelf = self else { return }
            wSelf.searchedWeatherHandler?(weathers, nil)
        }) {[weak self] (error) in
            guard let wSelf = self else { return }
            wSelf.searchedWeatherHandler?(nil, error)
        }
    }
    
}
