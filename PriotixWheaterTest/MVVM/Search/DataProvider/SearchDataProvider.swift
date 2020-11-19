//
//  SearchDataProvider.swift
//  PriotixWheaterTest
//
//  Created by Myasnik Tadevosyan on 8/23/19.
//  Copyright © 2019 Myasnik Tadevosyan. All rights reserved.
//

import Foundation

class SearchDataProvider {
    var weatherByTextHandler:((Weather?,Error?) -> Void)?
    
    init() {

    }
    
    func getWeatherByCountryName(text: String ) {
        WeatherApiManager().cancelSearchRequest()
        WeatherApiManager().weatherbyCountry(name: text, succses: {[weak self] (weather) in
            guard let wSelf = self else { return }
            wSelf.weatherByTextHandler?(weather, nil)
        }) {[weak self] (error) in
            guard let wSelf = self else { return }
            wSelf.weatherByTextHandler?(nil, error)
        }
    }
    
}
