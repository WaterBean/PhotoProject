//
//  SortButton.swift
//  PhotoProject
//
//  Created by 한수빈 on 1/19/25.
//

import UIKit

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
        config.image = UIImage(systemName: "line.3.horizontal.decrease.circle")
        config.cornerStyle = .capsule
        config.titlePadding = 4
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 3

        configuration = config
        configurationUpdateHandler = configHandler(_:)
        layer.masksToBounds = false
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
            button.configuration?.attributedTitle = AttributedString(NSAttributedString(string: SortOption.relevant.rawValue, attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .bold)]))
        case .normal:
            button.option = .latest
            button.configuration?.attributedTitle = AttributedString(NSAttributedString(string: SortOption.latest.rawValue, attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .bold)]))

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

