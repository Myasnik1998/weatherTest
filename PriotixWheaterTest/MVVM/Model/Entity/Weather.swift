//
//  Weather.swift
//  PriotixWheaterTest
//
//  Created by Myasnik Tadevosyan on 8/22/19.
//  Copyright © 2019 Myasnik Tadevosyan. All rights reserved.
//

import Foundation

struct Weather {
    var weather: [WeatherPrivew] = []
    var name: String
    var wind: Wind
    var main: WeatherMainInfo
    var date: Date
    
    enum Codingkey:String,CodingKey {
        case weather = "weather"
        case name = "name"
        case wind = "wind"
        case main = "main"
        case date = "dt"
    }
}

extension Weather: Codable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Codingkey.self)
        try? container.encode(weather, forKey: .weather)
        try? container.encodeIfPresent(name, forKey: .name)
        try? container.encode(wind, forKey: .wind)
        try? container.encode(main, forKey: .main)
        try? container.encode(date, forKey: .date)
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: Codingkey.self)
        weather = try values.decode([WeatherPrivew].self, forKey: .weather)
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        date = try values.decode(Date.self, forKey: .date)
        wind = try values.decode(Wind.self, forKey: .wind)
        main = try values.decode(WeatherMainInfo.self, forKey: .main)
    }
}
