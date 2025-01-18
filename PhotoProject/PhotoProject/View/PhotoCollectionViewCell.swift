//
//  PhotoCollectionViewCell.swift
//  PhotoProject
//
//  Created by 한수빈 on 1/18/25.
//

import UIKit
import SnapKit

final class PhotoCollectionViewCell: UICollectionViewCell {
    let photoImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        contentView.addSubview(photoImageView)
    }
    
    func configureLayout() {
        photoImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
