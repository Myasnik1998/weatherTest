//
//  HourlyCollectionViewCell.swift
//  PriotixWheaterTest
//
//  Created by Myasnik Tadevosyan on 8/23/19.
//  Copyright © 2019 Myasnik Tadevosyan. All rights reserved.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var hoursLable: UILabel!
    @IBOutlet weak var celsiusLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    func setupCell(weather: Weather) {
        hoursLable.text = weather.date.wt_hoursFormat()
        celsiusLabel.text = "\(Int(weather.main.temp))°"
        if let url = URL.init(string: Constants.weatherIconUrl(name: weather.weather.last!.icon)) {
            icon.af_setImage(withURL: url)
        }
    }
    
}
