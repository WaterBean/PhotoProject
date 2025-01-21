//
//  RandomPhotoCollectionViewCell.swift
//  PhotoProject
//
//  Created by 한수빈 on 1/21/25.
//

import UIKit
import SnapKit

final class RandomPhotoCollectionViewCell: BaseCollectionViewCell {
    
    let imageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(imageView)
    }
    
    override func configureLayout() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    override func configureView() {
        
    }
}
