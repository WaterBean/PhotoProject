//
//  PhotoDetailsViewController.swift
//  PhotoProject
//
//  Created by 한수빈 on 1/19/25.
//

import UIKit
import Kingfisher
import SnapKit


final class PhotoDetailsViewController: UIViewController {
    
    var photo: Photo?
    var response: PhotoStatisticsResponse? {
        didSet {
            mainView.viewsNumberLabel.text = response?.views.total.formatted(.number)
            mainView.downloadNumberLabel.text = response?.downloads.total.formatted(.number)
        }
    }
    
    private let mainView = PhotoDetailsView()
    override func loadView() {
        view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.largeTitleDisplayMode = .never
        
        guard let photo else { return }
        
        mainView.nameLabel.text = photo.user.name
        mainView.dateLabel.text = DataFormatterManager.formatted(string: photo.created_at)
        mainView.imageView.kf.setImage(with: URL(string: photo.urls.raw))
        mainView.profileImage.kf.setImage(with: URL(string: photo.user.profile_image.medium))
        mainView.sizeNumberLabel.text = "\(photo.width) x \(photo.height)"
        
        let photoRatio: CGFloat = Double(photo.height) / Double(photo.width)
        updateConstraint(photoRatio)
    }
    
    private func updateConstraint(_ ratio: CGFloat) {
        mainView.imageView.snp.remakeConstraints {
            $0.top.equalTo(mainView.profileImage.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(mainView.contentView)
            $0.height.equalTo(UIScreen.main.bounds.width * ratio)
        }
    }
    
}
