//
//  WeatherPrivew.swift
//  PriotixWheaterTest
//
//  Created by Myasnik Tadevosyan on 8/22/19.
//  Copyright © 2019 Myasnik Tadevosyan. All rights reserved.
//

import Foundation

struct WeatherPrivew {
    var description: String
    var icon: String
    
    enum Codingkey:String,CodingKey {
        case description = "description"
        case icon = "icon"
    }
}

extension WeatherPrivew: Codable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Codingkey.self)
        try? container.encode(icon, forKey: .icon)
        try? container.encode(description, forKey: .description)
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: Codingkey.self)
        description = try values.decode(String.self, forKey: .description)
        icon = try values.decode(String.self, forKey: .icon)
    }
}
