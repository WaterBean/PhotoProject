//
//  ColorCollectionViewCell.swift
//  PhotoProject
//
//  Created by 한수빈 on 1/19/25.
//

import UIKit
import SnapKit

final class ColorCollectionViewCell: BaseCollectionViewCell {
    
    private let label = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let colorView = {
        let view = UIView()
        view.backgroundColor = .black
        view.clipsToBounds = true
        view.layer.cornerRadius = 18
        return view
    }()
    
    let backView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 22
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    /// view.addSubview()를 통해 계층 구조를 정의하는 함수
    override func configureHierarchy() {
        [backView, label, colorView].forEach {
            contentView.addSubview($0)
        }
    }
    
    /// 제약조건을 통해 뷰를 배치하는 함수
    override func configureLayout() {
        backView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
        
        label.snp.makeConstraints {
            $0.trailing.equalTo(contentView.snp.trailing)
            $0.leading.equalTo(colorView.snp.trailing).offset(6)
            $0.centerY.equalToSuperview()
        }
        
        colorView.snp.makeConstraints {
            $0.leading.equalTo(contentView.snp.leading).inset(6)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(36)
            
        }
    }
    
    /// view의 속성을 변경하는 함수
    override func configureView() {
        backView.backgroundColor = .systemGray6
    }
        
    func updateCell(color: Color) {
        colorView.backgroundColor = color.colorCode
        label.text = color.rawValue
    }

}

