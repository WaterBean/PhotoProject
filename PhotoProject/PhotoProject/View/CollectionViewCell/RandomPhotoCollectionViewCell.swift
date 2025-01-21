//
//  RandomPhotoCollectionViewCell.swift
//  PhotoProject
//
//  Created by 한수빈 on 1/21/25.
//

import UIKit

final class RandomPhotoCollectionViewCell: BaseCollectionViewCell {
    
    let imageView = {
        let view = UIImageView()
        return view
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(imageView)
    }
    
    override func configureLayout() {
        
    }
    override func configureView() {
        
    }
}
