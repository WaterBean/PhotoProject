//
//  PhotoDetailsView.swift
//  PhotoProject
//
//  Created by 한수빈 on 1/19/25.
//

import UIKit
import SnapKit

final class PhotoDetailsView: BaseView {
    private let scrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    let contentView = UIView()
    
    let profileImage = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 22
        return image
    }()
    let nameLabel = UILabel()
    let dateLabel = UILabel()
    let imageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    let sizeTitleLabel = UILabel()
    let viewsTitleLabel = UILabel()
    let downloadTitleLabel = UILabel()
    let sizeNumberLabel = UILabel()
    let viewsNumberLabel = UILabel()
    let downloadNumberLabel = UILabel()
    let infoTitleLabel = UILabel()
    
    let chartLabel = UILabel()
    
    override func configureHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        [profileImage, nameLabel, dateLabel, imageView, sizeTitleLabel, viewsTitleLabel, downloadTitleLabel, sizeNumberLabel, viewsNumberLabel, downloadNumberLabel, infoTitleLabel, chartLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.width.equalTo(scrollView.snp.width)
            $0.verticalEdges.equalTo(scrollView)
        }
        
        profileImage.snp.makeConstraints {
            $0.top.equalTo(contentView).inset(10)
            $0.leading.equalToSuperview().inset(10)
            $0.size.equalTo(44)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImage)
            $0.trailing.equalToSuperview()
            $0.leading.equalTo(profileImage.snp.trailing).offset(10)
            $0.height.equalTo(20)
        }
        
        dateLabel.snp.makeConstraints {
            $0.bottom.equalTo(profileImage)
            $0.trailing.equalToSuperview()
            $0.leading.equalTo(profileImage.snp.trailing).offset(10)
            $0.height.equalTo(20)
        }

        imageView.snp.makeConstraints {
            $0.top.equalTo(profileImage.snp.bottom).offset(10)
            
            $0.horizontalEdges.equalTo(contentView)
            $0.height.equalTo(200)
        }
        
        infoTitleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(40)
            $0.bottom.equalTo(chartLabel.snp.top).offset(-100)
            $0.leading.equalTo(contentView).inset(20)
        }

        sizeTitleLabel.snp.makeConstraints {
            $0.top.equalTo(infoTitleLabel)
            $0.leading.equalTo(infoTitleLabel.snp.trailing).offset(80)
        }

        viewsTitleLabel.snp.makeConstraints {
            $0.top.equalTo(sizeTitleLabel.snp.bottom).offset(20)
            $0.leading.equalTo(sizeTitleLabel)
        }
        
        downloadTitleLabel.snp.makeConstraints {
            $0.top.equalTo(viewsTitleLabel.snp.bottom).offset(20)
            $0.leading.equalTo(viewsTitleLabel)
        }
        
        sizeNumberLabel.snp.makeConstraints {
            $0.top.equalTo(sizeTitleLabel)
            $0.trailing.equalToSuperview().inset(10)
        }
        
        viewsNumberLabel.snp.makeConstraints {
            $0.top.equalTo(viewsTitleLabel)
            $0.trailing.equalToSuperview().inset(10)
        }
        
        downloadNumberLabel.snp.makeConstraints {
            $0.top.equalTo(downloadTitleLabel)
            $0.trailing.equalToSuperview().inset(10)
        }
        
        chartLabel.snp.makeConstraints {
            $0.top.equalTo(infoTitleLabel.snp.bottom).offset(100)
            $0.bottom.equalTo(contentView).inset(10)
            $0.leading.equalTo(infoTitleLabel)
            $0.height.equalTo(500)
        }
    }
    
    
    
    override func configureView() {
        
    }
}
