//
//  AlamofireWrapper.swift
//  PriotixWheaterTest
//
//  Created by Myasnik Tadevosyan on 8/21/19.
//  Copyright © 2019 Myasnik Tadevosyan. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireWrapper {
    
    static let instance = AlamofireWrapper()
    let sessionManager = Alamofire.SessionManager.default
    var request: DataRequest?
    
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    func cancelRequest() {
        request?.cancel()
    }
    
    func getRequest(_strUrl: String, params: [String:Any]?, headers: HTTPHeaders?, success: @escaping(Any) -> Void, failure: @escaping(Error?) -> Void) {
        
        if !AlamofireWrapper.isConnectedToInternet() {
            Alert.showAlert("The Internet connection appears to be offline. Please reconect")
            return
        }
        
        let params: Parameters? = params ?? nil
        
        request = sessionManager.request(Constants.weatherBaseUrl + _strUrl, method: .get, parameters: params , encoding: URLEncoding.default, headers: nil).validate().responseData { (response) in
            if response.result.isSuccess, let jsonData = response.result.value {
                success(jsonData)
                return
            }
            
            if response.result.isFailure {
                failure(response.error)
            }
        }
    }
}
