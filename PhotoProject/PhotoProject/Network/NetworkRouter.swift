//
//  UnsplashRequest.swift
//  PhotoProject
//
//  Created by 한수빈 on 1/21/25.
//


import Foundation
import Alamofire

enum NetworkRouter: URLRequestConvertible {
    
    case searchPhotos(query: String, page: Int, per_page: Int , order_by: SortButton.SortOption, color: Color)
    case topicPhotos(topic: Topic.RawValue, page: Int = 1, per_page: Int = 10)
    case photoStatics(id: String)
    case randomPhoto(count: Int)
    
    var baseURL: URL {
        URL(string: "https://api.unsplash.com/")!
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .searchPhotos:
            return "search/photos"
        case let .topicPhotos(topic, _, _):
            return "topics/\(topic)/photos"
        case let .photoStatics(id: id):
            return "photos/\(id)/statistics"
        case .randomPhoto(_):
            return "photos/random"
        }
    }
    
    var headers: HTTPHeaders {
        ["Authorization": "Client-ID \(APIKey.photoAccessKey)"]
    }
    
    var parameters: Parameters? {
        switch self {
        case let .searchPhotos(query, page, per_page, order_by, color):
            ["query": query, "page": page, "per_page": per_page, "order_by": order_by.fetchString, "color": color.fetchString, "client_id": APIKey.photoAccessKey]
        case .topicPhotos(_, _, _):
            nil
        case .photoStatics(_):
            nil
        case .randomPhoto(count: let count):
            ["count": count]
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .searchPhotos:
            return URLEncoding.queryString
        default:
            return URLEncoding.queryString
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)
        
        urlRequest.method = method
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Client-ID \(APIKey.photoAccessKey)", forHTTPHeaderField: "Authorization")
        
        if let parameters = parameters {
            return try encoding.encode(urlRequest, with: parameters)
        }
                
        return urlRequest

    }
}
