//
//  NetworkManager.swift
//  PhotoProject
//
//  Created by 한수빈 on 1/18/25.
//

import Foundation
import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()
    private init () {}
    
    func fetchSearchPhotos(query: String, page: Int, per_page: Int = 20, order_by: SortButton.SortOption, color: Color, completion: @escaping (PhotoSearchResponse) -> Void ) {
        let endpoint = "https://api.unsplash.com/search/photos"
        let parameters: Parameters = ["query": query, "page": page, "per_page": per_page, "order_by": order_by.fetchString, "color": color.rawValue, "client_id": APIKey.photoAccessKey]
        
        AF.request(endpoint, parameters: parameters)
            .validate()
            .responseDecodable(of: PhotoSearchResponse.self) { response in
                switch response.result {
                case .success(let result):
                    completion(result)
                case . failure(let error):
                    print(error)
                    break
                }
                
            }
    }
    
    
    func fetchTopicPhotos(topic: Topic, page: Int = 1, completion: @escaping ([Photo]) -> Void ) {
        let endpoint = "https://api.unsplash.com/topics/\(topic.rawValue)/photos"
        let parameters: Parameters = ["page": 1, "per_page": 10, "client_id": APIKey.photoAccessKey]
        
        AF.request(endpoint, parameters: parameters)
            .validate()
            .responseDecodable(of: [Photo].self) { response in
                switch response.result {
                case .success(let result):
                    completion(result)
                case . failure(let error):
                    print(error)
                    break
                }
                
            }
    }
    
    
    func fetchStatistics(id: String, page: Int = 1, completion: @escaping (PhotoStatisticsResponse) -> Void ) {
        let endpoint = "https://api.unsplash.com/photos/\(id)/statistics"
        let parameters: Parameters = ["client_id": APIKey.photoAccessKey]
        
        AF.request(endpoint, parameters: parameters)
            .validate()
            .responseDecodable(of: PhotoStatisticsResponse.self) { response in
                switch response.result {
                case .success(let result):
                    print(result)
                    completion(result)
                case . failure(let error):
                    print(error)
                    break
                }
                
            }
    }
    
    
    
    
    
}


enum Color: String {
    case black
    case white
    case yellow
    case red
    case purple
    case green
    case blue
}

enum Topic: String {
    case goldenHour = "golden-hour"
    case businessWork = "business-work"
    case architectureInterior = "architecture-interior"

}
