//
//  Color.swift
//  PhotoProject
//
//  Created by 한수빈 on 1/20/25.
//

import UIKit

enum Color: String, CaseIterable {
    case black = "블랙"
    case white = "화이트"
    case yellow = "옐로우"
    case red = "레드"
    case purple = "퍼플"
    case green = "그린"
    case blue = "블루"
    
    var colorCode: UIColor {
        return switch self {
        case .black: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case .white: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        case .yellow: #colorLiteral(red: 1, green: 0.9373, blue: 0.3843, alpha: 1)
        case .red : #colorLiteral(red: 0.9412, green: 0.2667, blue: 0.3216, alpha: 1)
        case .purple: #colorLiteral(red: 0.5882, green: 0.2118, blue: 0.8824, alpha: 1)
        case .green : #colorLiteral(red: 0.0078, green: 0.7255, blue: 0.2745, alpha: 1)
        case .blue : #colorLiteral(red: 0.2353, green: 0.349, blue: 1, alpha: 1)
        }
    }
    
    var fetchString: String {
        return String(describing: self)
    }
    
}
