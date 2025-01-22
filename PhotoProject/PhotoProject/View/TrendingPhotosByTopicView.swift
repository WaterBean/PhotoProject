//
//  TrendingPhotosByTopicView.swift
//  PhotoProject
//
//  Created by 한수빈 on 1/20/25.
//

import UIKit
import SnapKit

final class TrendingPhotosByTopicView: BaseView {

    private let scrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private let contentView = UIView()
    
    lazy var goldCollection = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    lazy var busiCollection = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    lazy var archCollection = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    private let titleLabel1 = {
        let label = UILabel()
        label.text = "골든 아워"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let titleLabel2 = {
        let label = UILabel()
        label.text = "비즈니스 및 업무"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let titleLabel3 = {
        let label = UILabel()
        label.text = "건축 및 인테리어"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 6
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width-16)/2, height: 220)
        return layout
    }
    
    override func configureHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        [goldCollection, busiCollection, archCollection, titleLabel1, titleLabel2, titleLabel3].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.snp.width)
            make.verticalEdges.equalTo(scrollView)
        }
        
        titleLabel1.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.horizontalEdges.equalTo(contentView).inset(16)
            make.height.equalTo(40)
        }
        
        goldCollection.snp.makeConstraints { make in
            make.top.equalTo(titleLabel1.snp.bottom)
            make.horizontalEdges.equalTo(contentView)
            make.height.equalTo(230)
        }
        
        titleLabel2.snp.makeConstraints { make in
            make.top.equalTo(goldCollection.snp.bottom).offset(6)
            make.horizontalEdges.equalTo(contentView).inset(16)
            make.height.equalTo(40)
        }
        
        busiCollection.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(contentView)
            make.height.equalTo(230)
        }
        
        archCollection.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView)
            make.top.equalTo(goldCollection.snp.bottom).offset(50)
            make.bottom.equalTo(busiCollection.snp.top).offset(-50)
            make.height.equalTo(230)
        }
        
        
        titleLabel3.snp.makeConstraints { make in
            make.top.equalTo(archCollection.snp.bottom).offset(6)
            make.horizontalEdges.equalTo(contentView).inset(16)
            make.height.equalTo(40)
        }
    }
    
    override func configureView() {
        [goldCollection, busiCollection, archCollection].forEach {
            $0.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCollectionViewCell")
            $0.showsHorizontalScrollIndicator = false
        }
        goldCollection.tag = 0
        archCollection.tag = 1
        busiCollection.tag = 2
        
    }

}
