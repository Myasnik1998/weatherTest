//
//  WeatherApiManager.swift
//  PriotixWheaterTest
//
//  Created by Myasnik Tadevosyan on 8/21/19.
//  Copyright © 2019 Myasnik Tadevosyan. All rights reserved.
//

import Foundation
import UIKit

class WeatherApiManager {
    
    func currentWeatherDataBy(coordinate lat:Double,long:Double,succses:@escaping(Weather) -> Void, failure: @escaping(Error?) -> Void) {
        
        AlamofireWrapper.instance.getRequest(_strUrl: "/weather", params: ["lat":lat,"lon":long,"appid":Constants.weatherAPIKey,"units":"metric"], headers: nil, success: {(response) in
            
            guard let jsonData = response as? Data else {
                return
            }
            
            do {
                let weather = try JSONDecoder().decode(Weather.self, from: jsonData)
                succses(weather)
            } catch let error {
                failure(error)
            }
        }) { (error) in
            failure(error)
        }
    }
    
    func forecastAtBy(coordinate lat:Double,long:Double,succses:@escaping([Weather]) -> Void, failure: @escaping(Error?) -> Void){
        AlamofireWrapper.instance.getRequest(_strUrl: "/forecast", params: ["lat":lat,"lon":long,"appid":Constants.weatherAPIKey,"units":"metric"], headers: nil, success: {(response) in
            
            guard let jsonData = response as? Data else {
                return
            }
            
            do {
                let weather = try JSONDecoder().decode([Weather].self, from: jsonData, keyPath: "list")
                succses(weather)
            } catch let error {
                failure(error)
            }
        }) { (error) in
            failure(error)
        }
    }
    
    func forecastAtBy(name:String, succses:@escaping([Weather]) -> Void, failure: @escaping(Error?) -> Void){
        AlamofireWrapper.instance.getRequest(_strUrl: "/forecast", params: ["q":name,"appid":Constants.weatherAPIKey,"units":"metric"], headers: nil, success: {(response) in
            
            guard let jsonData = response as? Data else {
                return
            }
            
            do {
                let weather = try JSONDecoder().decode([Weather].self, from: jsonData, keyPath: "list")
                succses(weather)
            } catch let error {
                failure(error)
            }
        }) { (error) in
            failure(error)
        }
    }
    
    func weatherbyCountry(name text:String ,succses:@escaping(Weather) -> Void, failure: @escaping(Error?) -> Void){
        AlamofireWrapper.instance.getRequest(_strUrl: "/weather", params: ["q": text,"appid":Constants.weatherAPIKey,"units":"metric"], headers: nil, success: {(response) in
//            https://api.openweathermap.org/data/2.5/weather?q=A&units=metric&APPID=bd15ccbe82356c7fd80b849765c95ef7
            guard let jsonData = response as? Data else {
                return
            }
            
            do {
                let weather = try JSONDecoder().decode(Weather.self, from: jsonData)
                succses(weather)
            } catch let error {
                failure(error)
            }
        }) { (error) in
            failure(error)
        }
    }
    
    func cancelSearchRequest() {
        AlamofireWrapper.instance.cancelRequest()
    }
    
}
