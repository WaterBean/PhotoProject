//
//  ColorCollectionViewCell.swift
//  PhotoProject
//
//  Created by 한수빈 on 1/19/25.
//

import UIKit

final class ColorCollectionViewCell: BaseCollectionViewCell {
    
    private let label = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    
}
