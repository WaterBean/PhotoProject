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
    
    func fetchSearchPhotos(query: String,completion: @escaping ()-> Void ) {
        
        print("phto")
    }
}

