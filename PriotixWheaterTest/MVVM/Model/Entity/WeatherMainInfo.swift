//
//  WeatherMainInfo.swift
//  PriotixWheaterTest
//
//  Created by Myasnik Tadevosyan on 8/22/19.
//  Copyright © 2019 Myasnik Tadevosyan. All rights reserved.
//

import UIKit

struct WeatherMainInfo {
    var temp: CGFloat
    var pressure: CGFloat
    var humidity: CGFloat
    var temp_min: CGFloat
    var temp_max: CGFloat
    
    enum Codingkey:String,CodingKey {
        case temp = "temp"
        case pressure = "pressure"
        case humidity = "humidity"
        case temp_min = "temp_min"
        case temp_max = "temp_max"
    }
}

extension WeatherMainInfo: Codable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Codingkey.self)
        try? container.encode(temp, forKey: .temp)
        try? container.encode(pressure, forKey: .pressure)
        try? container.encode(humidity, forKey: .humidity)
        try? container.encode(temp_min, forKey: .temp_min)
        try? container.encode(temp_max, forKey: .temp_max)
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: Codingkey.self)
        temp = try values.decode(CGFloat.self, forKey: .temp)
        pressure = try values.decode(CGFloat.self, forKey: .pressure)
        humidity = try values.decode(CGFloat.self, forKey: .humidity)
        temp_min = try values.decode(CGFloat.self, forKey: .temp_min)
        temp_max = try values.decode(CGFloat.self, forKey: .temp_max)
    }
}
