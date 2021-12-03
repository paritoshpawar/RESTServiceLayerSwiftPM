//
//  AlamofireManager.swift
//  StarterPack
//
//  Created by Mindstix
//  Copyright © 2020  All rights reserved.
//
import Foundation
import Alamofire

struct Connectivity {
    static let sharedInstance = NetworkReachabilityManager()!
    static var isConnectedToInternet:Bool {
        return self.sharedInstance.isReachable
    }
}


class MFC_AlamofireManager : NSObject {
    
    static let shared = MFC_AlamofireManager()
    private let alamofireManager : Alamofire.Session
    
    let unAuthorizedError = NSError(domain: "UnAuthorized", code: 401, userInfo: nil)
    let badRequestError = NSError(domain: "BadRequest", code: 400, userInfo: nil)
    let serverError = NSError(domain: "InternalServerError", code: 500, userInfo: nil)
        
    private override init() {
        
        /// Set the custom configuration for service timeouts
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 60
        configuration.timeoutIntervalForRequest = 60
        self.alamofireManager = Alamofire.Session(configuration: configuration)
    }
    
    
    //MARK:- METHODS
    /// Make an API Call and get Dictionary/Error as a response from Success/Failure callbacks
    ///
    /// - Parameters:
    ///   - url: URL in String
    ///   - parameters: Dictionary [String: Any]
    ///   - methodType: .get, .post, .delete
    ///   - headers: Dictionary [String: Any]
    ///   - success: Success callback returning dictionary [String : Any]
    ///   - failure: Failure callback returning Error
    func makeAPIRequest(urlRequest : String, parameters : Parameters?, methodType : Alamofire.HTTPMethod, encodingType : ParameterEncoding,  headers : HTTPHeaders?,
                        success : @escaping (Data) -> Void, failure : @escaping (Error) -> Void) {
        
        
        //let urlRequest = urlRequest.URLRequest as URLRequest
        print("\n----- REQUEST ------")
        print("\nURL : \(urlRequest)")
        print("\nHEADERS : \(headers ?? HTTPHeaders.init([:]))")
        print("\nPARAMETERS : \(parameters ?? [:])")
        
        alamofireManager.request(urlRequest, method: methodType, parameters: parameters, encoding: encodingType, headers: headers).responseJSON { [weak self] (response) in
            
            print("\n----- RESPONSE ------")
            print("\nSTATUS_CODE : \(response.response?.statusCode ?? -1001)")
            print("\nURL : \(urlRequest)")
            print("\nPARAMETERS : \(parameters ?? [:])")
            print("\nRESPONSE : \(response)")
            print("\n----- RESPONSE END ------\n")
            let defaultError = NSError.init(domain: "default error", code: 400, userInfo: nil)
            
            guard let statusCode = response.response?.statusCode else {
                print("Cannot cast Status code")
                failure(self?.badRequestError ?? defaultError)
                return
            }
            
            // Handle Error cases
            switch statusCode {
                
            case 401, 403 :
                failure(self?.unAuthorizedError ?? defaultError)
                return
            case 400..<500 :
                failure(self?.badRequestError ?? defaultError)
            case 500:
                failure(self?.serverError ?? defaultError)
                return
                
            default:
                print("")
            }
            
            switch response.result {
                
            case .success(_) :
                
                guard let statusCode = response.response?.statusCode else {
                    print("NO STATUS CODE PRESENT!! RETURNING!! ")
                    return
                }
                
                switch statusCode {
                    
                case 200..<300 :

                    if let responseData = response.data {
                        success(responseData)
                    }
                default :
                    failure(self?.badRequestError ?? defaultError)
                }
                
            case .failure(let error) :
                print("AlamofireManagerError : \(error.localizedDescription)")
                failure(error)
            }
        }
    }
}
