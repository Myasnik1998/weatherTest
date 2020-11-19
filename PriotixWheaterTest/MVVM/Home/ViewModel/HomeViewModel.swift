//
//  HomeViewModel.swift
//  PriotixWheaterTest
//
//  Created by Myasnik Tadevosyan on 8/21/19.
//  Copyright © 2019 Myasnik Tadevosyan. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

protocol HomeViewModelDelegate {
    func didRecive(weather: Weather?)
    func didReciveSearched(weathers:[Weather]?)
}

class HomeViewModel: BaseViewModel {
    
    private var dataProvider:HomeDataProvider!
    var homeViewModelDelegate:HomeViewModelDelegate?
    
    override init() {
        super.init()
        getLocation()
    }
    
    @objc override func didBecomeActive() {
        if LocationService.shared.isEnable {
            getLocation()
        }
    }
    
    func didTapLocation() {
        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "didTapLocation"), object: nil)
        getLocation()
    }
    
    func didTapSearchButton(viewController: UIViewController) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController {
            if let homeVC = viewController as? HomeViewController{
                vc.delegate = homeVC
                homeVC.navigationController?.pushViewController(vc, animated: true)
            }
            
        }
    }
    
    private func setupDataProvider(location: CLLocationCoordinate2D) {
        self.dataProvider = HomeDataProvider(location: location)
        self.getCurrentWeather()
        self.reciveSearchedWeathers()
    }
    
    private func getLocation() {
        getLocation { (coordinate) in
            self.setupDataProvider(location: coordinate)
        }
    }
    
    func getWeatherByName(name: String) {
        dataProvider.getSearchedWeatherBy(name: name)
    }
    
    func reciveSearchedWeathers() {
        dataProvider.searchedWeatherHandler = { [weak self] weathers, error in
            guard let wSelf = self else { return }
            wSelf.homeViewModelDelegate?.didReciveSearched(weathers: weathers)
            if error != nil {
                Alert.showAlert(error?.localizedDescription ?? "")
            }
        }
    }
    
    private func getCurrentWeather() {
        dataProvider.currentWeatherHandler = { [weak self] weather, error in
            guard let wSelf = self else { return }
            wSelf.homeViewModelDelegate?.didRecive(weather: weather)
            if error != nil {
                Alert.showAlert(error?.localizedDescription ?? "")
            }
        }
    }
    
}
