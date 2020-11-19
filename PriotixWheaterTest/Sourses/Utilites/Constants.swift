//
//  Constants.swift
//  PriotixWheaterTest
//
//  Created by Myasnik Tadevosyan on 8/21/19.
//  Copyright © 2019 Myasnik Tadevosyan. All rights reserved.
//

import UIKit

final class Constants {
    
    //MARK: Base url
    
    static let weatherBaseUrl:String = "https://api.openweathermap.org/data/2.5"
    
    //MARK: Api Key
    
    static let weatherAPIKey:String = "7ff74359dbe236addf1ad3c251ba31ff"
    
    //MARK: Requests errors
    
    static func weatherIconUrl(name: String) -> String {
        return "http://openweathermap.org/img/w/\(name).png"
    }

}
