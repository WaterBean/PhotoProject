//
//  APIKey.swift
//  PhotoProject
//
//  Created by 한수빈 on 1/19/25.
//

import Foundation

final class APIKey {
    private init() { }

    static let photoAppId = Bundle.main.object(forInfoDictionaryKey: "PHOTO_APP_ID") as! String
    static let photoSecretKey = Bundle.main.object(forInfoDictionaryKey: "PHOTO_SECRET_KEY") as! String
    static let photoAccessKey = Bundle.main.object(forInfoDictionaryKey: "PHOTO_ACCESS_KEY") as! String
}
