//
//  RandomPhotoView.swift
//  PhotoProject
//
//  Created by 한수빈 on 1/22/25.
//

import UIKit
import SnapKit

final class RandomPhotoView: BaseView {

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        return layout
    }())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        collectionView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        collectionView.register(RandomPhotoCollectionViewCell.self, forCellWithReuseIdentifier: "RandomPhotoCollectionViewCell")
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        
    }

}
