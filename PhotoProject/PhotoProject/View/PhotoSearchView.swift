//
//  PhotoSearchView.swift
//  PhotoProject
//
//  Created by 한수빈 on 1/17/25.
//

import UIKit
import SnapKit

final class PhotoSearchView: BaseView {
    let searchStatusLabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "사진을 검색해보세요."
        label.textAlignment = .center
        return label
    }()
    
    let stackView = {
        let stack = UIStackView()
        stack.distribution = .fillProportionally
        stack.alignment = .leading
        stack.axis = .horizontal
        stack.spacing = 6
        return stack
    }()
    

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width-48)/2, height: 220)
        
        return layout
    }())
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    override func configureHierarchy() {
        addSubview(searchStatusLabel)
        addSubview(stackView)
        addSubview(collectionView)
    }
    
    override func configureLayout() {
        searchStatusLabel.snp.makeConstraints {
            $0.center.equalTo(safeAreaLayoutGuide)
        }
        
        stackView.snp.makeConstraints{
            $0.top.equalTo(searchStatusLabel.snp.bottom).offset(20)
            $0.leading.equalTo(safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(44)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        collectionView.backgroundColor = .black
    }
    
    
}

