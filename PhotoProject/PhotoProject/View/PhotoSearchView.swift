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
    
    let sortButton = SortButton(option: .relevant)
    
    let optionView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    let colorCollectionView = UICollectionView(frame: .zero, collectionViewLayout: {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 2
        layout.sectionInset = UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 100)
        layout.itemSize = CGSize(width: 100, height: 44)
        return layout
    }())
    
    let searchCollectionView = UICollectionView(frame: .zero, collectionViewLayout: {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 2
        layout.sectionInset = UIEdgeInsets(top: 16, left: 2, bottom: 16, right: 2)
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width-6)/2, height: 220)
        return layout
    }())
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureHierarchy() {
        addSubview(searchStatusLabel)
        addSubview(optionView)
        addSubview(searchCollectionView)
        optionView.addSubview(colorCollectionView)
        optionView.addSubview(sortButton)
    }
    
    override func configureLayout() {
        searchStatusLabel.snp.makeConstraints {
            $0.center.equalTo(safeAreaLayoutGuide)
        }
        
        optionView.snp.makeConstraints{
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        
        colorCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        sortButton.snp.makeConstraints {
            $0.trailing.equalTo(safeAreaLayoutGuide).offset(12)
            $0.verticalEdges.equalToSuperview().inset(4)
            $0.width.equalTo(100)
            
        }
        
        searchCollectionView.snp.makeConstraints {
            $0.top.equalTo(optionView.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        colorCollectionView.register(ColorCollectionViewCell.self, forCellWithReuseIdentifier: "ColorCollectionViewCell")
        colorCollectionView.backgroundColor = .clear
        colorCollectionView.tag = 0
        colorCollectionView.allowsSelection = true
        colorCollectionView.showsHorizontalScrollIndicator = false
        searchCollectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        searchCollectionView.backgroundColor = .clear
        searchCollectionView.tag = 1
    }
    
    
}

