//
//  DateFormatter.swift
//  PhotoProject
//
//  Created by 한수빈 on 1/20/25.
//

import Foundation

final class DataFormatterManager {
    private init() { }
    private static let formatter = DateFormatter()
    
    static func formatted(string: String)-> String? {
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'z'"
        let date = formatter.date(from: string)
        formatter.dateFormat = "yyyy년 M월 d일 게시됨"
        let formattedString = formatter.string(from: date ?? Date())
        return formattedString
    }
}
