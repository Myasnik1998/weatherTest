//
//  Wind.swift
//  PriotixWheaterTest
//
//  Created by Myasnik Tadevosyan on 8/22/19.
//  Copyright © 2019 Myasnik Tadevosyan. All rights reserved.
//

import UIKit

struct Wind {
    var speed: CGFloat
    var deg: CGFloat
    
    enum Codingkey:String,CodingKey {
        case speed = "speed"
        case deg = "deg"
    }
}

extension Wind: Codable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Codingkey.self)
        try? container.encode(deg, forKey: .deg)
        try? container.encode(speed, forKey: .speed)
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: Codingkey.self)
        speed = try values.decode(CGFloat.self, forKey: .speed)
        deg = try values.decode(CGFloat.self, forKey: .deg)
    }
}

