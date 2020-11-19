//
//  SearchViewModel.swift
//  PriotixWheaterTest
//
//  Created by Myasnik Tadevosyan on 8/23/19.
//  Copyright © 2019 Myasnik Tadevosyan. All rights reserved.
//

import UIKit

protocol SearchViewModelDelegate {
    func didRecive(weather: Weather?)
}

class SearchViewModel: BaseViewModel {
    
    private var dataProvider:SearchDataProvider!
    var searchViewModelDelegate:SearchViewModelDelegate?
    
    override init() {
        super.init()
        setupDataProvider()
    }
    
    private func setupDataProvider() {
        self.dataProvider = SearchDataProvider()
        getCurrentWeather()
    }
    
    func getCountry(text: String) {
        self.dataProvider.getWeatherByCountryName(text: text)
    }
    
    private func getCurrentWeather() {
        dataProvider.weatherByTextHandler = { [weak self] weather, error in
            guard let wSelf = self else { return }
            wSelf.searchViewModelDelegate?.didRecive(weather: weather)
            if error != nil {
//                Alert.showAlert(error?.localizedDescription ?? "")
            }
        }
    }
    
}
