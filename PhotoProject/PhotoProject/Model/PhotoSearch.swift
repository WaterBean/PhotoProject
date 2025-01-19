//
//  PhotoSearch.swift
//  PhotoProject
//
//  Created by 한수빈 on 1/19/25.
//

import Foundation


struct PhotoSearchResponse: Decodable {
    var total: Int
    var total_pages: Int
    let results: [Photo]
}


struct Photo: Decodable, Identifiable {
    let id: String
    let created_at: String
    let width: Int
    let height: Int
    let urls: ImageUrl
    let likes: Int
    let user: User
}

struct User: Decodable {
    let name: String
    let profile_image: Medium
}


struct Medium: Decodable {
    let medium: String
}

struct ImageUrl: Decodable {
    let raw: String
    let small: String
}
