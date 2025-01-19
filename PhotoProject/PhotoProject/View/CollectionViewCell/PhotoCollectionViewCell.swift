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
    
    private let starButton = {
        let button = UIButton()
        button.configuration = UIButton.Configuration.filled()
        var config = button.configuration
        config?.image = UIImage(systemName: "star.fill")
        config?.imagePadding = 6
        config?.cornerStyle = .capsule
        config?.baseForegroundColor = .yellow
        config?.background.backgroundColor = .darkGray
        button.configuration = config
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
    }
    
    override func configureHierarchy() {
        contentView.addSubview(photoImageView)
        contentView.addSubview(starButton)
    }
    
    override func configureLayout() {
        photoImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        starButton.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().inset(20)
        }
    }
    
    func updateCell(image: String, star: Int) {
        photoImageView.kf.setImage(with: URL(string: image))
        starButton.setTitle(star.formatted(.number), for: .normal)
    }
    
    
}
