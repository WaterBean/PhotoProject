//
//  PhotoStatisticsResponse.swift
//  PhotoProject
//
//  Created by 한수빈 on 1/20/25.
//


struct PhotoStatisticsResponse: Decodable, Identifiable {
    let id: String
    let downloads: Statistics
    let views: Statistics
}

struct Statistics: Decodable {
    let total: Int
    let historical: Historical
}

struct Historical: Decodable {
    let values: [Value]
}

struct Value: Decodable {
    let date: String
    let value: Int
}
