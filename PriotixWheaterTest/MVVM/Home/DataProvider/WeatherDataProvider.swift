//
//  WeatherDataProvider.swift
//  PriotixWheaterTest
//
//  Created by Myasnik Tadevosyan on 8/23/19.
//  Copyright © 2019 Myasnik Tadevosyan. All rights reserved.
//

import Foundation
import CoreLocation

class WeatherDataProvider {
    
    var weatherHandler:(([Weather]?,Error?) -> Void)?
    
    init(location: CLLocationCoordinate2D) {
        getDailyWeatherDataBy(location: location)
    }
    
    private func getDailyWeatherDataBy(location: CLLocationCoordinate2D ) {
        WeatherApiManager().forecastAtBy(coordinate: location.latitude, long: location.longitude, succses: {[weak self] (weathers) in
            guard let wSelf = self else { return }
            wSelf.weatherHandler?(weathers, nil)
        }) {[weak self] (error) in
            guard let wSelf = self else { return }
            wSelf.weatherHandler?(nil, error)
        }
    }
    
}
