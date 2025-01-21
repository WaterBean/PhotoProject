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
    var results: [Photo]
}


struct Photo: Decodable {
    let id: String
    let created_at: String
    let width: Int
    let height: Int
    let urls: ImageUrl
    let likes: Int
    let user: User
    init() {
        self.id = ""
        self.created_at = ""
        self.width = 0
        self.height = 0
        self.urls = ImageUrl(raw: "", small: "")
        self.likes = 0
        self.user = User(name: "", profile_image: ProfileImage(medium: ""))
    }
}

struct User: Decodable {
    let name: String
    let profile_image: ProfileImage
}


struct ProfileImage: Decodable {
    let medium: String
}

struct ImageUrl: Decodable {
    let raw: String
    let small: String
}

