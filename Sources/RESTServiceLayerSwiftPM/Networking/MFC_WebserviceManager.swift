//
//  WebserviceManager.swift
//  Native-iOS-Baselione
//
//  Created by Mindstix on 26/07/21.
//

import Foundation
import Alamofire
//import Amway_Base_Utility

public enum ServiceType {
    
    case FetchWeatherDetails
}

public typealias ServiceRequestSuccessBlock  = (_ result:Any) -> Void
public typealias ServiceRequestFailureBlock  = (_ failurError:NSError) -> Void
public typealias ServiceRequestOfflineBlock  = (_ offline:NSError) -> Void

// Manages the service calls throughout the app
//
public class MFC_WebserviceManager : NSObject {
    
    static var shared = MFC_WebserviceManager()
    weak var alamofireManager : MFC_AlamofireManager? = MFC_AlamofireManager.shared
    
    
    public override init() {
        super.init()
    }

    public func sendRequest(serviceType : ServiceType,
                     url : String,
                     headers : [String : Any],
                     params : [String : Any],
                     success: @escaping ServiceRequestSuccessBlock,
                     failure: @escaping ServiceRequestFailureBlock,
                     offline: @escaping ServiceRequestOfflineBlock){
        
        // Provision for custom tokens
        let accessToken = ""
        print("SERVICE TYPE IS - \(serviceType)")
        
        switch serviceType {
                    
        case .FetchWeatherDetails:
            sendRequestToGetWeatherDetails(url : url, headers: headers, accessToken: accessToken, serviceType: serviceType, params: params, success: success, failure: failure, offline: offline)
        }
    }
        
    //MARK:- Get Weather details Function
    public func sendRequestToGetWeatherDetails(url: String, headers: [String : Any], accessToken : String, serviceType : ServiceType, params: [String : Any], success: @escaping ServiceRequestSuccessBlock, failure: @escaping ServiceRequestFailureBlock, offline: @escaping ServiceRequestOfflineBlock) {
        
        let header : [String : String] = headers as! [String : String]
        let url = self.getURLFromString(urlString: url)
        let httpHeaders = HTTPHeaders.init(header)
        
        alamofireManager?.makeAPIRequest(urlRequest: url, parameters: params, methodType: .post, encodingType: URLEncoding.default, headers: httpHeaders, success: { (response) in
            let JSON = try! JSONSerialization.jsonObject(with: response, options: [])
           print(JSON)
            if let weatherObject = try? JSONDecoder().decode(Weather.self, from: response) {
                success(weatherObject)
            }
        }) { (error) in
            failure(error as NSError)
        }
    }
    
     func getURLFromString(urlString : String) -> String {
        return urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
}
