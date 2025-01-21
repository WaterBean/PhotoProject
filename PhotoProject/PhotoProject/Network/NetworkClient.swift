//
//  NetworkManager.swift
//  PhotoProject
//
//  Created by 한수빈 on 1/18/25.
//

import Foundation
import Alamofire


final class NetworkClient {
    private init () {}
    static func request<T>(_ decodable: T.Type,
                           router: NetworkRouter,
                           success: @escaping (T)-> Void,
                           failure: @escaping (_ error: Error) -> Void) where T: Decodable {
        
        AF.request(router)
            .validate(statusCode: 200..<500)
            .responseString(completionHandler: {
                print($0)
            })
            .responseDecodable(of: decodable) { response in
                switch response.result {
                case .success(let result):
                    success(result)
                case .failure(let error):
                    failure(error)
                }
            }
    }
    
    
}



enum Topic: String {
    case goldenHour = "golden-hour"
    case businessWork = "business-work"
    case architectureInterior = "architecture-interior"
    
}
