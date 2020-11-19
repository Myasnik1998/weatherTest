//
//  HomeViewController.swift
//  PriotixWheaterTest
//
//  Created by Myasnik Tadevosyan on 8/21/19.
//  Copyright © 2019 Myasnik Tadevosyan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var weatherDescLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    let viewModel = HomeViewModel()
    private var hourlyChildVC: HourlyViewController?
    private var dailyChildVC: DailyViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
    }
    
    func setupViewModel() {
        self.viewModel.homeViewModelDelegate = self
    }
    
    func updateUI(weather:Weather?) {
        guard let weather = weather else { return }
        countryLabel.text     = weather.name
        weatherDescLabel.text = weather.weather.first?.description
        tempLabel.text        = "\(Int(weather.main.temp))" + "°"
        humidityLabel.text    = weather.main.humidity.description+"%"
        minTempLabel.text     = weather.main.temp_min.description+"°"
        maxTempLabel.text     = weather.main.temp_max.description+"°"
        pressureLabel.text    = weather.main.pressure.description
        tempLabel.sizeToFit()
    }
    
    //MARK: Actions
    
    @IBAction func locationButtonClick(_ sender: UIBarButtonItem) {
        viewModel.didTapLocation()
    }
    
    @IBAction func searchButtonClick(_ sender: UIBarButtonItem) {
        viewModel.didTapSearchButton(viewController: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HourlyViewController" {
            if let hourlyChildVC = segue.destination as? HourlyViewController {
                self.hourlyChildVC = hourlyChildVC
            }
        }
        if segue.identifier == "DailyViewController" {
            if let dailyChildVC = segue.destination as? DailyViewController {
                self.dailyChildVC = dailyChildVC
            }
        }
    }
}

extension HomeViewController: SearchViewControllerDelegate {
    func didSelectItem(weather: Weather) {
        updateUI(weather: weather)
        viewModel.getWeatherByName(name: weather.name)
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func didReciveSearched(weathers: [Weather]?) {
        if let dailyVC = self.dailyChildVC, let hourlyVC = self.hourlyChildVC,let weathers = weathers {
            dailyVC.adapter.weathers = dailyVC.viewModel.filterDailyWeathers(weathers: weathers)
            dailyVC.collectionView.reloadData()
            hourlyVC.adapter.weathers = hourlyVC.viewModel.filterDailyWeathers(weathers: weathers)
            hourlyVC.collectionView.reloadData()
        }
    }
    
    func didRecive(weather: Weather?) {
        updateUI(weather: weather)
    }
}
