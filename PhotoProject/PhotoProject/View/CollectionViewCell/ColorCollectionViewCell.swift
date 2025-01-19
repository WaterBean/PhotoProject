//
//  ColorCollectionViewCell.swift
//  PhotoProject
//
//  Created by 한수빈 on 1/19/25.
//

import UIKit

final class ColorCollectionViewCell: BaseCollectionViewCell {
    
    private let label = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    
}

final class SortButton: UIButton {
        
    var option = SortOption.relevant
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(option: SortOption) {
        self.init(frame: .zero)
        var config = UIButton.Configuration.bordered()
        config.title = option.rawValue
        config.background.backgroundColor = .white
        config.baseForegroundColor = .black
        configuration = config
        configurationUpdateHandler = configHandler(_:)
        layer.cornerRadius = 22
        clipsToBounds = true
        isSelected = false
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configHandler(_ button: UIButton) -> Void {
        print(button.state)
        let button = button as! SortButton
        switch button.state {
        case .selected:
            button.option = .relevant
            button.configuration?.title = SortOption.relevant.rawValue
            button.configuration?.image = UIImage(systemName: "1.circle")
        case .normal:
            button.option = .latest
            button.configuration?.title = SortOption.latest.rawValue
            button.configuration?.image = UIImage(systemName: "2.circle")
        default : break
        }
        
    }
    
    enum SortOption: String {
        ///정확도
        case relevant = "관련순"
        ///날짜순
        case latest = "최신순"
        var fetchString: String {
            return String(describing: self)
        }
    }
    
    
}

