//
//  PhotoCollectionViewCell.swift
//  PhotoProject
//
//  Created by 한수빈 on 1/18/25.
//

import UIKit
import SnapKit
import Kingfisher

final class PhotoCollectionViewCell: BaseCollectionViewCell {
    let photoImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.tintColor = .brown
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        contentView.addSubview(photoImageView)
    }
    
    override func configureLayout() {
        photoImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func updateCell(image: String) {
        photoImageView.kf.setImage(with: URL(string: image))
    }
}
